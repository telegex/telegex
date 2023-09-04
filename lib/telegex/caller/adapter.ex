defmodule Telegex.Caller.Adapter do
  @moduledoc "An adapter to help HTTP clients implement callers."

  alias Telegex.Response

  @type config_key :: :adapter | :options

  @default_adapter Finch

  defmacro __using__(_opts) do
    quote do
      @behaviour Telegex.Caller

      alias Telegex.{Error, RequestError}

      import unquote(__MODULE__)

      @json_header {"content-type", "application/json"}

      @type error :: Telegex.Type.error()
    end
  end

  @spec impl() :: module
  def impl, do: Module.concat(__MODULE__, config(:adapter))

  @spec build_url(String.t()) :: String.t()
  def build_url(method), do: "#{Telegex.Instance.api()}#{Telegex.Instance.token()}/#{method}"

  @spec options :: keyword
  def options, do: config(:options)

  @spec config(config_key) :: module | keyword
  defp config(:adapter) do
    case Application.get_env(:telegex, :caller_adapter) do
      {adapter, _options} -> adapter || @default_adapter
      nil -> @default_adapter
      adapter -> adapter
    end
  end

  defp config(:options) do
    case Application.get_env(:telegex, :caller_adapter) do
      {_adapter, options} -> options || []
      _ -> []
    end
  end

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
