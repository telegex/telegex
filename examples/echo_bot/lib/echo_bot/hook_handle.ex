defmodule EchoBot.HookHandler do
  @moduledoc false

  use Telegex.Hook.Handler

  alias EchoBot.Consumer

  @impl true
  def on_init do
    env_config = Application.get_env(:echo_bot, EchoBot.HookHandler)

    secret_token = "dev-secret-token"

    Telegex.delete_webhook()
    Telegex.set_webhook(env_config[:webhook_url], secret_token: secret_token)

    %Telegex.Hook.Config{server_port: env_config[:server_port], secret_token: secret_token}
  end

  @impl true
  def on_update(update) do
    Consumer.consume(update)

    :ok
  end
end
