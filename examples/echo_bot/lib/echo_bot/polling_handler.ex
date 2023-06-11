defmodule EchoBot.PollingHandler do
  @moduledoc false

  use Telegex.Polling.Handler

  @impl true
  def on_boot do
    {:ok, user} = Telegex.get_me()
    # 删除可能存在的 webhook
    {:ok, _} = Telegex.delete_webhook()

    Logger.info("Bot (#{user.username}) is working (polling)")

    %Telegex.Polling.Config{}
  end

  @impl true
  def on_update(update) do
    EchoBot.Dispatcher.dispatch(update)

    :ok
  end
end
