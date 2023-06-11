defmodule Telegex.Hook.Adapter do
  @moduledoc """
  Adapters for webhooks, these adapters are usually the underlying layer of `plug`.
  """

  defmacro __using__(_) do
    quote do
      @behaviour unquote(__MODULE__)
    end
  end

  @callback child_spec(config :: Telegex.Hook.Config.t()) :: tuple

  def impl, do: Module.concat(__MODULE__, env_config() || Bandit)

  defp env_config, do: Application.get_env(:telegex, :hook_adapter)
end
