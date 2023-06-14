defmodule EchoBot.EchoTextChain do
  @moduledoc false

  use Telegex.Chain

  @impl true
  def call(%{message: %{text: text}} = _update, context) when text == nil do
    {:ignored, context}
  end

  @impl true
  def call(%{message: %{text: text, chat: chat}} = _update, context) do
    context = %{
      context
      | payload: %{
          method: "sendMessage",
          chat_id: chat.id,
          text: text
        }
    }

    {:done, context}
  end
end
