defmodule Telegex.Hook.Adapter do
  @moduledoc """
  Adapters for webhooks, these adapters are usually the underlying layer of `plug`.

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
  1. `Use Telegex.Hook.Handler`
  1. Implement `on_boot/0` and `on_update/1` callback functions
  1. Add your module to the supervision tree

  Hook handler example:

  ```elixir
  defmodule YourProject.HookHandler do
    use Telegex.Hook.Handler

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
    end
  end

  @callback child_spec(config :: Telegex.Hook.Config.t()) :: tuple

  def impl, do: Module.concat(__MODULE__, Telegex.Global.hook_adapter())
end
