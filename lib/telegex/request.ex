defmodule Telegex.Request do
  @moduledoc false

  alias Telegex.Model.{Response, Error, RequestError}
  alias Telegex.Config

  @type errors :: Error.t() | RequestError.t()
  @type result :: [map()] | map()

  @spec call(String.t(), keyword()) :: result() | {:error, errors()}
  def call(method, params \\ []) when is_binary(method) and is_list(params) do
    endpoint = "https://api.telegram.org/bot#{Config.token()}/#{method}"

    json_body = params |> Enum.into(%{}) |> Jason.encode!()

    post(endpoint, json_body) |> handle_response()
  end

  @spec handle_response({:ok, HTTPoison.Response.t()}) :: any() | {:error, Error.t()}
  defp handle_response({:ok, %HTTPoison.Response{body: body} = _response}) do
    %Response{ok: ok, result: result, error_code: error_code, description: description} =
      structed_response(body)

    if ok, do: result, else: {:error, %Error{error_code: error_code, description: description}}
  end

  @spec handle_response({:error, HTTPoison.Error.t()}) :: any() | {:error, RequestError.t()}
  defp handle_response({:error, %HTTPoison.Error{reason: reason} = _response}) do
    {:error, %RequestError{reason: reason}}
  end

  @json_header {"Content-Type", "application/json"}

  @spec post(String.t(), String.t()) ::
          {:ok, HTTPoison.Response.t()} | {:error, HTTPoison.Error.t()}
  defp post(endpoint, json_body)
       when is_binary(endpoint) and is_binary(json_body) do
    HTTPoison.post(endpoint, json_body, [@json_header])
  end

  @spec structed_response(String.t()) :: Response.t()
  defp structed_response(json) do
    data =
      json
      |> Jason.decode!()
      |> Map.new(fn {key, value} ->
        try do
          {String.to_existing_atom(key), value}
        rescue
          _ -> {:ignore, :ignore}
        end
      end)
      |> Map.drop([:ignore])

    struct(Response, data)
  end
end
