defmodule Telegex.Request do
  @moduledoc false

  alias Telegex.Model.{Response, Error, RequestError, InputMedia}
  alias Telegex.Attachment
  alias Telegex.Config

  @type result :: any()

  @spec endpoint(String.t()) :: String.t()
  defp endpoint(method), do: "https://api.telegram.org/bot#{Config.token()}/#{method}"

  def call(method, params \\ []) when is_binary(method) and is_list(params) do
    if attach_fields = Telegex.__attachments__(method) do
      post(method, params, attach_fields, :multipart) |> handle_response()
    else
      post(method, params) |> handle_response()
    end
  end

  @spec handle_response({:ok, HTTPoison.Response.t()}) :: {:ok, result()} | {:error, Error.t()}
  defp handle_response({:ok, %HTTPoison.Response{body: body} = _response}) do
    %Response{ok: ok, result: result, error_code: error_code, description: description} =
      struct_response(body)

    if ok,
      do: {:ok, result},
      else: {:error, %Error{error_code: error_code, description: description}}
  end

  @spec handle_response({:error, HTTPoison.Error.t()}) :: {:error, RequestError.t()}
  defp handle_response({:error, %HTTPoison.Error{reason: reason} = _response}) do
    {:error, %RequestError{reason: reason}}
  end

  @json_header {"Content-Type", "application/json"}

  @spec post(String.t(), keyword()) ::
          {:ok, HTTPoison.Response.t()} | {:error, HTTPoison.Error.t()}
  defp post(method, params)
       when is_binary(method) and is_list(params) do
    json_body = params |> Enum.into(%{}) |> Jason.encode!()

    HTTPoison.post(endpoint(method), json_body, [@json_header], Config.httposion_options())
  end

  @spec post(String.t(), keyword(), [Attachment.t()], :multipart) ::
          {:ok, HTTPoison.Response.t()} | {:error, HTTPoison.Error.t()}
  defp post(method, params, attach_fields, :multipart)
       when is_binary(method) and is_list(params) and is_list(attach_fields) do
    if empty_attachment?(method, params, attach_fields) do
      # 如果没有本地文件，则使用传统的方式请求
      post(method, params)
    else
      multipart_form = build_multipart_form(method, params, attach_fields)
      HTTPoison.post(endpoint(method), multipart_form, [], Config.httposion_options())
    end
  end

  @spec struct_response(String.t()) :: Response.t()
  defp struct_response(json) do
    data = json |> Jason.decode!(keys: :atoms)

    struct(Response, data)
  end

  @spec build_attach_form_data({String.t(), String.t()}) :: tuple()
  defp build_attach_form_data({field, file_path} = _attach, named? \\ true) do
    name = if named?, do: to_string(field), else: Path.basename(file_path)

    {:file, file_path, {"form-data", [{:name, name}, {:filename, Path.basename(file_path)}]}, []}
  end

  defp data_normalize({field, value}, local_attachs) do
    attach_file = local_attachs[field]

    value =
      cond do
        attach_file != nil -> "attach://#{Path.basename(attach_file)}"
        is_list(value) || is_map(value) -> Jason.encode!(value)
        true -> to_string(value)
      end

    {to_string(field), value}
  end

  defp empty_attachment?("sendMediaGroup", params, _attach_fields) do
    params
    |> Keyword.get(:media, [])
    |> Enum.filter(fn %{media: media} -> media |> File.exists?() end)
    |> Enum.empty?()
  end

  defp empty_attachment?("editMessageMedia", params, _attach_fields) do
    if media = params |> Keyword.get(:media) do
      !(ffiled_exists?(media, :thumb) || ffiled_exists?(media, :media))
    else
      true
    end
  end

  # 通用实现：检测是否存在本地附件
  defp empty_attachment?(_method, params, attach_fields) do
    attach_fields
    |> Enum.map(fn %{field: field} -> {field, params[field]} end)
    |> Enum.filter(fn {_, attach} -> attach != nil end)
    |> Enum.filter(fn {_, attach} -> File.exists?(attach) end)
    |> Enum.empty?()
  end

  @spec ffiled_exists?(InputMedia.t(), atom()) :: boolean()
  # 检测文件字段是否存在。
  # 此函数会先检测字段是否存在，再进一步检测文件是否存在。
  defp ffiled_exists?(data, field) do
    if Map.has_key?(data, field) && Map.get(data, field) do
      File.exists?(Map.get(data, field))
    else
      false
    end
  end

  defp build_multipart_form("sendMediaGroup", params, _attach_fields) do
    # 1. 检查附件列表
    media_param = params |> Keyword.get(:media, [])
    local_medias = media_param |> Enum.filter(fn %{media: media} -> File.exists?(media) end)
    # 2. 构建附件 form
    local_media_forms =
      local_medias
      |> Enum.map(fn %{media: media} -> {:media, media} end)
      |> Enum.map(&build_attach_form_data(&1, false))

    local_thumbs =
      media_param
      |> Enum.filter(fn input_media ->
        if input_media |> Map.has_key?(:thumb), do: File.exists?(input_media.thumb), else: false
      end)

    local_thumb_forms =
      local_thumbs
      |> Enum.map(fn %{thumb: thumb} -> {:thumb, thumb} end)
      |> Enum.map(&build_attach_form_data(&1, false))

    attach_forms = local_media_forms ++ local_thumb_forms
    # 3. 构建数据 form
    media_param =
      media_param
      |> Enum.map(fn media ->
        if local_medias |> Enum.member?(media) do
          media = media |> Map.put(:media, "attach://#{Path.basename(media.media)}")

          if media.type == "video" && File.exists?(media.thumb) do
            media |> Map.put(:thumb, "attach://#{Path.basename(media.thumb)}")
          else
            media
          end
        else
          media
        end
      end)

    params = params |> Keyword.put(:media, media_param)

    data_forms =
      params
      |> Enum.map(&data_normalize(&1, []))

    {:multipart, data_forms ++ attach_forms}
  end

  defp build_multipart_form("editMessageMedia", params, _attach_fields) do
    # 1. 检查附件列表
    input_media = params |> Keyword.get(:media, [])
    # 检查 media 字段
    {local_media_exists?, local_media_form} =
      if ffiled_exists?(input_media, :media) do
        {true, [build_attach_form_data({:media, input_media.media}, false)]}
      else
        {false, []}
      end

    # 检查 thumb 字段
    {local_thumb_exists?, local_thumb_form} =
      if ffiled_exists?(input_media, :thumb) do
        {true, [build_attach_form_data({:thumb, input_media.thumb}, false)]}
      else
        {false, []}
      end

    # 2. 构建附件 form
    attach_forms = local_media_form ++ local_thumb_form

    # 3. 构建数据 form
    input_media =
      if local_media_exists?,
        do: input_media |> Map.put(:media, "attach://#{Path.basename(input_media.media)}"),
        else: input_media

    input_media =
      if local_thumb_exists?,
        do: input_media |> Map.put(:media, "attach://#{Path.basename(input_media.thumb)}"),
        else: input_media

    params = params |> Keyword.put(:media, input_media)

    data_forms =
      params
      |> Enum.map(&data_normalize(&1, []))

    {:multipart, data_forms ++ attach_forms}
  end

  # 通用实现：构建 Multipart form
  defp build_multipart_form(_method, params, attach_fields) do
    local_attachs =
      attach_fields
      |> Enum.map(fn %{field: field} -> {field, params[field]} end)
      |> Enum.filter(fn {_, attach} -> attach != nil end)
      |> Enum.filter(fn {_, attach} -> File.exists?(attach) end)

    # 1. 构建表单中的数据字段列表

    no_main_attachment? = fn {field, _} ->
      local_attachs[field] == nil ||
        Enum.member?(attach_fields, %Attachment{field: field, supports_attach_syntax: true})
    end

    data_fields =
      params
      # 只保留数据字段和支持 attach 语法的附件
      |> Enum.filter(no_main_attachment?)
      |> Enum.map(&data_normalize(&1, local_attachs))

    # 2. 构建表单中的附件字段列表
    file_fields = local_attachs |> Enum.map(&build_attach_form_data/1)

    # 3. 合并包含数据和附件的 form 为 multipart 元组
    {:multipart, data_fields ++ file_fields}
  end
end
