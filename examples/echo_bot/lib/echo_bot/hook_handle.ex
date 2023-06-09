defmodule EchoBot.HookHandler do
  @moduledoc false

  use Telegex.Hook.Handler

  alias EchoBot.Consumer

  @impl true
  def on_init do
    env_config = Application.get_env(:echo_bot, EchoBot.HookHandler)

    Telegex.delete_webhook()
    Telegex.set_webhook(env_config[:webhook_url])

    %Telegex.Hook.Config{server_port: env_config[:server_port]}
  end

  @impl true
  def on_update(update) do
    Consumer.consume(update)

    :ok
  end
end
