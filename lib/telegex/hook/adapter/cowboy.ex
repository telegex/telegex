defmodule Telegex.Hook.Adapter.Cowboy do
  @moduledoc "Based on `Plug.Cowboy` webhook server adapter."

  use Telegex.Hook.Adapter

  @impl true
  def child_spec(handler_module, config) do
    {Plug.Cowboy,
     plug:
       {Telegex.Hook.Server,
        %{
          handler_module: handler_module,
          secret_token: config.secret_token
        }},
     scheme: :http,
     options: [port: config.server_port]}
  end
end
