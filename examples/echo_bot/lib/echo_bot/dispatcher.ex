defmodule EchoBot.Dispatcher do
  @moduledoc false

  require Logger

  def dispatch(%{message: %{text: text, chat: chat}} = _update) when text != nil do
    Telegex.send_message(chat.id, text)
  end

  def dispatch(_update) do
    Logger.debug("Ignore update without text message")
  end
end
