defmodule EchoBot.Consumer do
  @moduledoc false

  use DynamicSupervisor

  require Logger

  def start_link(default \\ []) when is_list(default) do
    DynamicSupervisor.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  @impl true
  def init(_) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def receive(%{} = update) do
    DynamicSupervisor.start_child(
      __MODULE__,
      {Task, fn -> consume(update) end}
    )
  end

  defp consume(%{message: %{text: text, chat: chat}} = _update) when text != nil do
    Telegex.Caller.call("sendMessage", chat_id: chat.id, text: text)
  end

  defp consume(_update) do
    Logger.debug("Ignore update without text message")
  end
end
