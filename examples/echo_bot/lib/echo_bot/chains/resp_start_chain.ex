defmodule EchoBot.RespStartChain do
  @moduledoc false

  use Telegex.Chain, {:command, :start}

  @impl true
  def match?(%{text: text, chat: %{type: "private"}}, _context) when text != nil do
    String.starts_with?(text, @command)
  end

  @impl true
  def match?(_message, _context), do: false

  @impl true
  def handle(%{chat: chat, text: _text} = _update, context) do
    context = %{
      context
      | payload: %{
          method: "sendMessage",
          chat_id: chat.id,
          text: "Hello 😀"
        }
    }

    {:done, context}
  end
end
