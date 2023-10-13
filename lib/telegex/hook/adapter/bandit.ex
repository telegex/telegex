defmodule Telegex.Hook.Adapter.Bandit do
  @moduledoc "Based on Bandit webhook server adapter."

  use Telegex.Hook.Adapter

  @impl true
  def child_spec(config) do
    {Bandit,
     plug:
       {Telegex.Hook.Server,
        %{
          on_update: config.on_update,
          on_failure: config.on_failure,
          secret_token: config.secret_token
        }},
     scheme: :http,
     port: config.server_port}
  end
end
