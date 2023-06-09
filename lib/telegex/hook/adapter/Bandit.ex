defmodule Telegex.Hook.Adapter.Bandit do
  @moduledoc "Based on Bandit webhook server adapter."

  use Telegex.Hook.Adapter

  @impl true
  def child_spec(config) do
    {Bandit,
     plug: {Telegex.Hook.Server, %{on_update: config.on_update}},
     scheme: :http,
     port: config.server_port}
  end
end
