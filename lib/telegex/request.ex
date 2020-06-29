defmodule Telegex.Request do
  @moduledoc false

  alias Telegex.Model.{Response, Error, RequestError}
  alias Telegex.Attachment
  alias Telegex.Config

  @type result :: any()

  def call(method, params \\ []) when is_binary(method) and is_list(params) do
    endpoint = "https://api.telegram.org/bot#{Config.token()}/#{method}"

    if attach_fields = Telegex.__attachments__(method) do
      post(endpoint, params, attach_fields, :multipart) |> handle_response()
    else
      post(endpoint, params) |> handle_response()
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

  @httpopts [timeout: 1000 * 45, recv_timeout: 1000 * 30]
  @json_header {"Content-Type", "application/json"}

  @spec post(String.t(), keyword()) ::
          {:ok, HTTPoison.Response.t()} | {:error, HTTPoison.Error.t()}
  defp post(endpoint, params)
       when is_binary(endpoint) and is_list(params) do
    json_body = params |> Enum.into(%{}) |> Jason.encode!()

    HTTPoison.post(endpoint, json_body, [@json_header], @httpopts)
  end

  @spec post(String.t(), keyword(), [Attachment.t()], :multipart) ::
          {:ok, HTTPoison.Response.t()} | {:error, HTTPoison.Error.t()}
  defp post(endpoint, params, attach_fields, :multipart)
       when is_binary(endpoint) and is_list(params) and is_list(attach_fields) do
    no_empty_attachs =
      attach_fields
      |> Enum.map(fn %{field: field} -> {field, params[field]} end)
      |> Enum.filter(fn {_, attach} -> attach != nil end)

    local_attachs = no_empty_attachs |> Enum.filter(fn {_, attach} -> File.exists?(attach) end)

    if Enum.empty?(local_attachs) do
      # 如果没有本地文件，则使用传统的方式请求
      post(endpoint, params)
    else
      # 1. 构建表单中的数据字段列表
      data_fields =
        params
        # 过滤掉不支持 attach 语法的是附件
        |> Enum.filter(fn {field, _} ->
          local_attachs[field] == nil ||
            Enum.member?(attach_fields, %Attachment{field: field, supports_attach_syntax: true})
        end)
        |> Enum.map(fn {field, value} ->
          attach_file = local_attachs[field]

          value =
            cond do
              attach_file != nil -> "attach://#{Path.basename(attach_file)}"
              is_list(value) || is_map(value) -> Jason.encode!(value)
              true -> to_string(value)
            end

          {to_string(field), value}
        end)

      # 2. 构建表单中的附件字段列表
      file_fields =
        local_attachs
        |> Enum.map(fn {field, file_path} ->
          {:file, file_path,
           {"form-data", [{:name, to_string(field)}, {:filename, Path.basename(file_path)}]}, []}
        end)

      multipart_form = {:multipart, data_fields ++ file_fields}

      HTTPoison.post(endpoint, multipart_form, [], @httpopts)
    end
  end

  @spec struct_response(String.t()) :: Response.t()
  defp struct_response(json) do
    data = json |> Jason.decode!(keys: :atoms)

    struct(Response, data)
  end
end
