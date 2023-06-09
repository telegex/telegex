defmodule Telegex.Caller.Adapter.Req do
  @moduledoc "Req based caller adapter."

  use Telegex.Caller.Adapter

  @type req_resp :: Req.Response.t()
  @type req_error :: %{reason: atom}

  @impl true
  def call(method, params, opts) do
    r = request(build_url(method), Enum.into(params, %{}), opts)

    parse_response(r)
  end

  defp request(url, body_map, _opts) do
    req_opts =
      Keyword.merge(
        [
          method: :post,
          url: url,
          headers: [@json_header],
          json: body_map,
          decode_json: [keys: :atoms],
          retry: false
        ],
        options()
      )

    req = apply(Req, :new, [req_opts])

    apply(Req, :request, [req])
  end

  @spec parse_response({:ok, req_resp} | {:error, req_error}) :: {:ok, any} | {:error, error}
  defp parse_response({:ok, %{body: body} = _response}) do
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
