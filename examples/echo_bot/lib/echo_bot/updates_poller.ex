defmodule EchoBot.UpdatesPoller do
  @moduledoc false

  use Telegex.GenPoller

  @impl true
  def on_boot do
    {:ok, user} = Telegex.Instance.cache_me()
    # delete any potential webhook
    {:ok, _} = Telegex.delete_webhook()

    Logger.info("Bot (@#{user.username}) is working (polling)")

    %Telegex.Polling.Config{}
    # you must return the `Telegex.Polling.Config` struct ↑
  end

  @impl true
  def on_update(update) do
    EchoBot.ChainHandler.call(update, %EchoBot.ChainContext{bot: Telegex.Instance.bot()})
  end

  @impl true
  def on_failure(update, e) do
    Logger.error("Uncaught Error: #{inspect(update_id: update.update_id, error: e)}")
  end
end
