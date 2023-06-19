defmodule EchoBot.EchoTextChain do
  @moduledoc false

  use Telegex.Chain, :message

  @impl true
  def match?(%{text: text, chat: %{type: chat_type}} = _message, _context)
      when is_nil(text) or chat_type != "private" do
    false
  end

  @impl true
  def match?(_message, _context), do: true

  @impl true
  def handle(%{chat: chat, text: text} = _update, context) do
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
