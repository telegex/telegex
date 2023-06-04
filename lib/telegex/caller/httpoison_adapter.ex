defmodule Telegex.Caller.HTTPoisonAdapter do
  @moduledoc false

  use Telegex.Caller

  alias HTTPoison.Response

  @impl true
  def call(method, params, opts) do
    url = build_url(method)
    json_body = params |> Enum.into(%{}) |> Jason.encode!()

    url |> request(json_body, opts) |> parse_response()
  end

  def request(url, json_body \\ "", _opts \\ []) do
    HTTPoison.post(url, json_body, [@json_header], adapter_options())
  end

  @spec parse_response({:ok, Response.t()} | {:error, HTTPoison.Error.t()}) ::
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

  defp parse_response({:error, %HTTPoison.Error{reason: reason} = _response}) do
    {:error, %RequestError{reason: reason}}
  end
end
