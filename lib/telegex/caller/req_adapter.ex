defmodule Telegex.Caller.ReqAdapter do
  @moduledoc false

  use Telegex.Caller

  alias Req.Response

  @type req_error :: %{reason: atom}

  @impl true
  def call(method, params, opts) do
    r = request(build_url(method), Enum.into(params, %{}), opts)

    parse_response(r)
  end

  def request(url, body_map \\ %{}, _opts \\ []) do
    [
      method: :post,
      url: url,
      headers: [@json_header],
      json: body_map,
      decode_json: [keys: :atoms]
    ]
    |> Keyword.merge(adapter_options())
    |> Req.new()
    |> Req.request()
  end

  @spec parse_response({:ok, Response.t()} | {:error, req_error}) ::
          {:ok, any} | {:error, Telegex.error()}

  defp parse_response({:ok, %Response{body: body} = _response}) do
    %{ok: ok, result: result, error_code: error_code, description: description} =
      struct_response(body)

    if ok do
      {:ok, result}
    else
      {:error, %Error{error_code: error_code, description: description}}
    end
  end

  # 注意：此处 `Req.request/1` 函数返回错误还不够明确，需要仔细查看文档和阅读源码。
  # 在测试超时错误时会返回 `{:error, %Mint.TransportError{reason: :timieout}}`，所以此处假定错误都会包含 `reason` 字段。
  defp parse_response({:error, %{reason: reason} = _error}) do
    {:error, %RequestError{reason: reason}}
  end
end
