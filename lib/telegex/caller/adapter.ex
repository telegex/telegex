defmodule Telegex.Caller.Adapter do
  @moduledoc "An adapter to help HTTP clients implement callers."

  alias Telegex.{Response, Global}

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
  def impl, do: Module.concat(__MODULE__, adapter_name())

  @spec build_url(String.t()) :: String.t()
  def build_url(method) do
    "#{Global.api_base_url()}/bot#{Telegex.Instance.token()}/#{method}"
  end

  @spec options :: keyword
  def options do
    case Global.caller_adapter() do
      {_adapter, options} -> options
      _ -> []
    end
  end

  @spec adapter_name :: module
  defp adapter_name do
    case Global.caller_adapter() do
      {adapter, _options} -> adapter
      adapter -> adapter
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
