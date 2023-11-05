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
  def handle(%{chat: chat, text: _text} = _message, context) do
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

    send_hello = %{
      method: "sendMessage",
      chat_id: chat.id,
      text:
        "*Hello*\n\n😇 You can learn more from here: [telegex/telegex](https://github.com/telegex/telegex)\\.",
      reply_markup: markup,
      parse_mode: "MarkdownV2",
      disable_web_page_preview: true
    }

    context = %{context | payload: send_hello}

    {:done, context}
  end
end
