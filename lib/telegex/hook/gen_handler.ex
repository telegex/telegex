defmodule Telegex.Hook.GenHandler do
  @moduledoc """
  Generate your webhook handler, which includes a supervisor with a Plug-based child.

  Add [`plug`](https://hex.pm/packages/plug) and [`remote_ip`](https://hex.pm/packages/remote_ip) to your application's deps because they are required for webhook mode.

  You also need to configure adapters for hooks, which provide web services.

  Based on [`Bandit`](https://hexdocs.pm/telegex/Telegex.Hook.Adapter.Bandit.html) - [`bandit`](https://hex.pm/packages/bandit)

  ```elixir
  # add `bandit` to your dpes.
  config :telegex, hook_adapter: Bandit
  ```

  Based on [`Cowboy`](https://hexdocs.pm/telegex/Telegex.Hook.Adapter.Cowboy.html) - [`plug_cowboy`](https://hex.pm/packages/plug_cowboy)

  ```elixir
  # add `plug_cowboy` to your dpes.
  config :telegex, hook_adapter: Cowboy
  ```

  To work in webhook mode:

  1. Create a new module, like `YourProject.HookHandler`
  1. `Use Telegex.Hook.GenHandler`
  1. Implement `on_boot/0` and `on_update/1` callback functions
  1. Add your module to the supervision tree

  Hook handler example:

  ```elixir
  defmodule YourProject.HookHandler do
    use Telegex.Hook.GenHandler

    @impl true
    def on_boot do
      # read some parameters from your env config
      env_config = Application.get_env(:your_project, __MODULE__)
      # delete the webhook and set it again
      {:ok, true} = Telegex.delete_webhook()
      # set the webhook (url is required)
      {:ok, true} = Telegex.set_webhook(env_config[:webhook_url])
      # specify port for web server
      # port has a default value of 4000, but it may change with library upgrades
      %Telegex.Hook.Config{server_port: env_config[:server_port]}
      # you must return the `Telegex.Hook.Config` struct ↑
    end

    @impl true
    def on_update(update) do

      # consume the update
      :ok
    end
  end
  ```

  _Note: `webhook_url` must be a full URL, such as `https://your.domain.com/updates_hook`, where `updates_hook` path is fixed._
  """

  defmacro __using__(_) do
    quote do
      @behaviour unquote(__MODULE__)

      use Supervisor

      alias Telegex.Hook.Adapter

      require Logger

      def start_link(opts \\ []) do
        if Keyword.get(opts, :serve, true) do
          config = on_boot()

          children = [
            Adapter.impl().child_spec(__MODULE__, config)
          ]

          opts = [strategy: :one_for_one, name: unquote(__CALLER__.module).Supervisor]
          Supervisor.start_link(children, opts)
        else
          Logger.warning("Webhook handler is not serving")

          :ignore
        end
      end

      @impl Supervisor
      def init(state) do
        {:ok, state}
      end

      @impl unquote(__MODULE__)
      def on_boot, do: %Telegex.Hook.Config{}

      @impl unquote(__MODULE__)
      def on_update(_update) do
        Logger.warning(
          "New update from Telegram Bot API Server, but `on_update/1` is not implemented"
        )

        :ok
      end

      @impl unquote(__MODULE__)
      def on_failure(_update, reason) do
        Logger.error("An error occurs, override `on_failure/2` to catch it: #{inspect(reason)}")
      end

      defoverridable on_boot: 0, on_update: 1, on_failure: 2
    end
  end

  @callback on_boot :: Telegex.Hook.Config.t()
  @callback on_update(Telegex.Type.Update.t()) :: :ok | Telegex.Chain.result()
  @callback on_failure(update :: Telegex.Type.Update.t(), {e :: any, stacktrace :: any}) ::
              no_return
end
