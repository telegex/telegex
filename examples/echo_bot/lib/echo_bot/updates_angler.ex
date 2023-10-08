defmodule EchoBot.UpdatesAngler do
  @moduledoc false

  use Telegex.GenAngler

  @impl true
  def on_boot do
    {:ok, user} = Telegex.Instance.get_me()
    # read some parameters from your env config
    env_config = Application.get_env(:echo_bot, EchoBot.HookHandler)
    secret_token = "dev-secret-token"
    # delete the webhook and set it again
    Telegex.delete_webhook()
    # set the webhook (url and secret token)
    Telegex.set_webhook(env_config[:webhook_url], secret_token: secret_token)
    # specify port for web server
    # port has a default value of 4000, but it may change with library upgrades
    config = %Telegex.Hook.Config{
      server_port: env_config[:server_port],
      secret_token: secret_token
    }

    # you must return the `Telegex.Hook.Config` struct ↑

    Logger.info("Bot (@#{user.username}) is working (webhook)")

    config
  end

  @impl true
  def on_update(update) do
    EchoBot.ChainHandler.call(update, %EchoBot.ChainContext{bot: Telegex.Instance.me()})
  end
end
