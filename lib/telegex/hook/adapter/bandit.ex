defmodule Telegex.Hook.Adapter.Bandit do
  @moduledoc "Based on Bandit webhook server adapter."

  use Telegex.Hook.Adapter

  @impl true
  def child_spec(handler_module, config) do
    {Bandit,
     plug:
       {Telegex.Hook.Server,
        %{
          handler_module: handler_module,
          secret_token: config.secret_token
        }},
     scheme: :http,
     port: config.server_port}
  end
end
