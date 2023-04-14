defmodule Telegex.HTTPClient do
  @moduledoc false

  # TODO: 将 response 和 error 整合成各类客户端可以通用的结构。

  @type response :: HTTPoison.Response.t()
  @type error_reason :: HTTPoison.Error.t()

  defp client do
    Application.get_env(:telegex, :http_client, HTTPoison)
  end

  @spec post(String.t(), any, list, keyword) :: {:ok, response} | {:error, error_reason}
  def post(url, body, headers, options \\ []) do
    _post(client(), url, body, headers, options)
  end

  def _post(HTTPoison, url, body, headers, options \\ []) do
    HTTPoison.post(url, body, headers, options)
  end
end
