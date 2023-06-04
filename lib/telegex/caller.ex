defmodule Telegex.Caller do
  @moduledoc false

  alias Telegex.Response

  defmacro __using__(_opts) do
    quote do
      @behaviour Telegex.Caller

      alias Telegex.{Error, RequestError}

      import unquote(__MODULE__)

      @json_header {"content-type", "application/json"}
    end
  end

  @callback call(method :: String.t(), params :: keyword, opts :: keyword) ::
              {:ok, any} | {:error, Telegex.error()}

  @spec call(String.t(), keyword, keyword) :: {:ok, any} | {:error, Telegex.error()}
  def call(method, params \\ [], opts \\ []), do: impl().call(method, params, opts)

  @spec impl() :: module
  defp impl, do: config()[:adapter] || Telegex.Caller.ReqAdapter

  @spec token() :: String.t()
  def token, do: Application.get_env(:telegex, :token)

  @spec build_url(String.t()) :: String.t()
  def build_url(method), do: "https://api.telegram.org/bot#{token()}/#{method}"

  @spec adapter_options() :: keyword
  def adapter_options, do: config()[:options] || []

  @spec config :: keyword
  defp config, do: Application.get_env(:telegex, __MODULE__, [])

  @spec struct_response(String.t() | map) :: Response.t()
  def struct_response(json) when is_binary(json) do
    data = Jason.decode!(json, keys: :atoms)

    struct(Response, data)
  end

  def struct_response(%{ok: ok, error_code: error_code, description: description}) do
    %Response{
      ok: ok,
      error_code: error_code,
      description: description
    }
  end

  def struct_response(%{ok: ok, result: result}) do
    %Response{
      ok: ok,
      result: result
    }
  end
end
