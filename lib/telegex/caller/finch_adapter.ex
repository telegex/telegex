defmodule Telegex.Caller.FinchAdapter do
  @moduledoc false

  use Telegex.Caller

  @type req_resp :: Finch.Response.t()
  @type req_error :: %{reason: atom}

  @impl true
  def call(method, params, opts) do
    url = build_url(method)
    json_body = params |> Enum.into(%{}) |> Jason.encode!()

    url |> request(json_body, opts) |> parse_response()
  end

  def request(url, json_body \\ %{}, _opts \\ []) do
    req = apply(Finch, :build, [:post, url, [@json_header], json_body])

    apply(Finch, :request, [req, Telegex.Finch, adapter_options()])
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
end
