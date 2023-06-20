defmodule EchoBot.RespStartChain do
  @moduledoc false

  use Telegex.Chain, {:command, :start}

  alias Telegex.Type.{InlineKeyboardMarkup, InlineKeyboardButton}

  @impl true
  def match?(%{text: text, chat: %{type: "private"}}, _context) when text != nil do
    String.starts_with?(text, @command)
  end

  @impl true
  def match?(_message, _context), do: false

  @impl true
  def handle(%{chat: chat, text: _text} = _update, context) do
    markup = %InlineKeyboardMarkup{
      inline_keyboard: [
        [
          %InlineKeyboardButton{
            text: "Hello",
            callback_data: "hello:v1"
          }
        ]
      ]
    }

    context = %{
      context
      | payload: %{
          method: "sendMessage",
          chat_id: chat.id,
          text: "Hello 😀",
          reply_markup: markup
        }
    }

    {:done, context}
  end
end
