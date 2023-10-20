defmodule Telegex.Hook.Adapter do
  @moduledoc """
  Adapters for webhooks, these adapters are usually the underlying layer of `plug`.
  """

  defmacro __using__(_) do
    quote do
      @behaviour unquote(__MODULE__)
    end
  end

  @callback child_spec(handler_module :: module, config :: Telegex.Hook.Config.t()) :: tuple

  def impl, do: Module.concat(__MODULE__, Telegex.Global.hook_adapter())
end
