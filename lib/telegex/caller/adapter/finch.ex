defmodule Telegex.Caller.Adapter.Finch do
  @moduledoc "Finch based caller adapter."

  use Telegex.Caller.Adapter

  @type req_resp :: Finch.Response.t()
  @type req_error :: %{reason: atom}

  alias Multipart.Part

  @impl true
  def call(method, params, opts) do
    url = build_url(method)

    url |> request(params, opts) |> parse_response()
  end

  def request(url, params \\ [], opts \\ []) do
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

  defp _try_build_multipart(params, attachment_fields, i \\ 0, multipart \\ Multipart.new()) do
    field = Enum.at(attachment_fields, i)
    value = Keyword.get(params, field)

    cond do
      is_nil(field) && Enum.empty?(multipart.parts) ->
        # 如果返回时发现没有添加任何 part，则返回 :none
        :none

      is_nil(field) ->
        multipart = add_other_param_parts(multipart, Keyword.drop(params, attachment_fields))

        body_stream = Multipart.body_stream(multipart)
        content_length = Multipart.content_length(multipart)
        content_type = Multipart.content_type(multipart, "multipart/form-data")

        headers = [{"Content-Type", content_type}, {"Content-Length", to_string(content_length)}]

        {headers, body_stream}

      is_binary(value) && File.exists?(value) ->
        fname = Path.basename(value)

        multipart =
          multipart
          |> Multipart.add_part(Part.file_field(value, fname))
          |> Multipart.add_part(Part.text_field("attach://#{fname}", field))

        _try_build_multipart(params, attachment_fields, i + 1, multipart)

      true ->
        # 达到此处通常表示字段值不是字符串，或不是本地文件
        # TODO: 添加对结构类型附件的支持（结构中包含了一个或多个附件字段）
        _try_build_multipart(params, attachment_fields, i + 1, multipart)
    end
  end

  defp add_other_param_parts(multipart, without_attachments_params) do
    Enum.reduce(without_attachments_params, multipart, fn {key, value}, updated_multipart ->
      cond do
        is_map(value) ->
          Multipart.add_part(updated_multipart, Part.text_field(Jason.encode!(value), key))

        is_binary(value) ->
          Multipart.add_part(updated_multipart, Part.text_field(value, key))

        true ->
          Multipart.add_part(updated_multipart, Part.text_field(to_string(value), key))
      end
    end)
  end
end
