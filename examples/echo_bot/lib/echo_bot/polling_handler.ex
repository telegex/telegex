defmodule EchoBot.PollingHandler do
  @moduledoc false

  use Telegex.Polling.Handler

  @impl true
  def on_boot do
    {:ok, user} = Telegex.Instance.get_me()
    # delete any potential webhook
    {:ok, _} = Telegex.delete_webhook()

    Logger.info("Bot (@#{user.username}) is working (polling)")

    %Telegex.Polling.Config{}
    # you must return the `Telegex.Polling.Config` struct ↑
  end

  @impl true
  def on_update(update) do
    EchoBot.ChainHandler.call(update, %EchoBot.ChainContext{bot: Telegex.Instance.me()})
  end
end
