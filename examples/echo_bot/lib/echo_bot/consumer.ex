defmodule EchoBot.Consumer do
  @moduledoc """
  Consume updated content, handle new messages, callbacks or queries.
  """

  require Logger

  alias Telegex.Model.Update

  # Ignore non-message updates.
  def receive(%Update{message: nil}), do: :ignored

  # Ignore non-text messages.
  def receive(%Update{message: %{text: nil}}), do: :ignored

  # Echo user message.
  def receive(%Update{message: message}) do
    %{text: message_text, chat: %{id: chat_id}, from: from_user} = message

    fullname = fullname(from_user)
    text = "\\[Echo\\] *#{fullname}*: `#{message_text}`\\."

    case Telegex.send_message(chat_id, text, parse_mode: "MarkdownV2") do
      {:ok, _sed_msg} ->
        :ok

      {:error, reason} ->
        Logger.error("Echo failed, reason: #{inspect(reason)}")

        :error
    end
  end

  # Combine the user's first and last name.
  defp fullname(%{first_name: first_name}), do: first_name
  defp fullname(%{first_name: first_name, last_name: last_name}), do: "#{first_name} #{last_name}"
end
