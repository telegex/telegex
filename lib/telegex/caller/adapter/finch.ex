defmodule Telegex.Caller.Adapter.Finch do
  @moduledoc "Finch based caller adapter."

  use Telegex.Caller.Adapter

  @type req_resp :: Finch.Response.t()
  @type req_error :: %{reason: atom}

  @impl true
  def call(method, params, opts) do
    url = build_url(method)

    url |> request(params, opts) |> parse_response()
  end

  defp request(url, params, opts) do
    attachment_fields = Keyword.get(opts, :attachment_fields, [])

    build_args =
      case try_build_multipart(params, attachment_fields) do
        :none ->
          json_body = params |> Enum.into(%{}) |> Jason.encode!()

          [:post, url, [@json_header], json_body]

        {multipart_headers, multipart_body_stream} ->
          [:post, url, multipart_headers, {:stream, multipart_body_stream}]
      end

    req = apply(Finch, :build, build_args)

    apply(Finch, :request, [req, Telegex.Finch, options()])
  end

  @spec parse_response({:ok, req_resp} | {:error, req_error}) :: {:ok, any} | {:error, error}
  defp parse_response({:ok, %{body: body} = _response}) do
    %{result: result, error_code: error_code, description: description} =
      resp = struct_response(body)

    if resp.ok do
      {:ok, result}
    else
      {:error, %Error{error_code: error_code, description: description}}
    end
  end

  # 注意：此处 `Finch.request/1` 函数返回错误还不够明确，需要仔细查看文档和阅读源码。
  # 在测试超时错误时会返回 `{:error, %Mint.TransportError{reason: :timieout}}`，所以此处假定错误都会包含 `reason` 字段。
  defp parse_response({:error, %{reason: reason} = _error}) do
    {:error, %RequestError{reason: reason}}
  end

  @spec try_build_multipart(keyword, list) :: {[{String.t(), String.t()}], Enum.t()} | :none

  defp try_build_multipart(_params, []), do: :none

  defp try_build_multipart(params, attachment_fields),
    do: _try_build_multipart(params, attachment_fields)

  defp _try_build_multipart(params, attachment_fields, i \\ 0, multipart \\ new_multipart()) do
    field = Enum.at(attachment_fields, i)
    value = Keyword.get(params, field)

    not_exists_field? = is_nil(field)
    file_exists? = value && File.exists?(value)

    cond do
      not_exists_field? && Enum.empty?(multipart.parts) ->
        # 如果返回时发现没有添加任何 part，则返回 :none
        :none

      not_exists_field? ->
        top_level_attachments =
          Enum.filter(attachment_fields, fn field -> is_binary(Keyword.get(params, field)) end)

        multipart = add_other_param_parts(multipart, Keyword.drop(params, top_level_attachments))

        body_stream = multipart_body_stream(multipart)
        content_length = multipart_content_length(multipart)
        content_type = multipart_content_type(multipart, "multipart/form-data")

        headers = [{"Content-Type", content_type}, {"Content-Length", to_string(content_length)}]

        {headers, body_stream}

      !file_exists? ->
        # 文件不存在，保持原样继续处理下一个附件字段
        _try_build_multipart(params, attachment_fields, i + 1, multipart)

      true ->
        {multipart, params} = attach_param(field, value, multipart, params)

        _try_build_multipart(params, attachment_fields, i + 1, multipart)
    end
  end

  @spec attach_param(atom, String.t() | map | list | nil, Multipart.t(), keyword | map) ::
          {Multipart.t(), keyword | map}

  def attach_param(_field, nil, multipart, params), do: {multipart, params}

  def attach_param(field, value, multipart, params) when is_binary(value) do
    fname = Path.basename(value)
    attach_url = "attach://#{fname}"

    top_level_param? = !is_map(params)

    multipart = add_part(multipart, file_field_part(value, fname))

    multipart =
      if top_level_param? do
        # 顶级附件参数，需附加 text 字段
        add_part(multipart, text_field_part(attach_url, field))
      else
        # 非顶级附件参数，不附加 text 字段
        multipart
      end

    params =
      if top_level_param? do
        Keyword.put(params, field, attach_url)
      else
        Map.put(params, field, attach_url)
      end

    {multipart, params}
  end

  def attach_param(field, value, multipart, params) when is_map(value) do
    # 将结构类型的参数值自身作为参数，并获得重写后的结构参数
    {multipart, value} = attach_struct(value, multipart)
    # 重写参数值
    params = Keyword.put(params, field, value)

    {multipart, params}
  end

  def attach_param(field, value, multipart, params) when is_list(value) do
    {multipart, value} =
      Enum.reduce(value, {multipart, []}, fn subv, {updated_multipart, subvs} ->
        {updated_multipart, subv} = attach_struct(subv, updated_multipart)

        {updated_multipart, subvs ++ [subv]}
      end)

    # 重写字段的值
    params = Keyword.put(params, field, value)

    {multipart, params}
  end

  defp attach_struct(value, multipart) do
    if function_exported?(value.__struct__, :__attachments__, 0) do
      attachment_fields = value.__struct__.__attachments__()

      attach_fun = fn field, {updated_multipart, updated_params} ->
        attach_param(field, Map.get(value, field), updated_multipart, updated_params)
      end

      # 将结构类型的参数值自身作为参数，并获得重写后的结构参数
      Enum.reduce(attachment_fields, {multipart, value}, attach_fun)
    else
      {multipart, value}
    end
  end

  defp add_other_param_parts(multipart, without_attachments_params) do
    Enum.reduce(without_attachments_params, multipart, fn {key, value}, updated_multipart ->
      cond do
        is_map(value) or is_list(value) ->
          add_part(updated_multipart, text_field_part(Jason.encode!(value), key))

        is_binary(value) ->
          add_part(updated_multipart, text_field_part(value, key))

        true ->
          add_part(updated_multipart, text_field_part(to_string(value), key))
      end
    end)
  end

  defp new_multipart() do
    apply(Multipart, :new, [])
  end

  defp multipart_body_stream(multipart) do
    apply(Multipart, :body_stream, [multipart])
  end

  defp multipart_content_length(multipart) do
    apply(Multipart, :content_length, [multipart])
  end

  defp multipart_content_type(multipart, content_type) do
    apply(Multipart, :content_type, [multipart, content_type])
  end

  defp add_part(multipart, part) do
    apply(Multipart, :add_part, [multipart, part])
  end

  defp text_field_part(value, name) do
    apply(Multipart.Part, :text_field, [value, name])
  end

  defp file_field_part(path, name) do
    apply(Multipart.Part, :file_field, [path, name])
  end
end
