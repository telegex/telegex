defmodule Telegex.Hook.Handler do
  @moduledoc false

  defmacro __using__(_) do
    quote do
      use Supervisor

      @behaviour unquote(__MODULE__)

      require Logger

      def start_link(_) do
        %{server_port: server_port} = on_init()

        children = [
          {Bandit,
           plug: {Telegex.Hook.Server, %{on_update: &on_update/1}},
           scheme: :http,
           port: server_port}
        ]

        opts = [strategy: :one_for_one, name: __MODULE__]
        Supervisor.start_link(children, opts)
      end

      @impl Supervisor
      def init(state) do
        {:ok, state}
      end

      @impl unquote(__MODULE__)
      def on_init, do: %Telegex.Hook.Config{}

      @impl unquote(__MODULE__)
      def on_update(_update) do
        Logger.warning(
          "New update from Telegram Bot API Server, but `on_update/1` is not implemented"
        )
      end

      defoverridable on_init: 0, on_update: 1
    end
  end

  @callback on_init :: Telegex.Hook.Config.t()
  @callback on_update(Telegex.Type.Update.t()) :: :ok
end
