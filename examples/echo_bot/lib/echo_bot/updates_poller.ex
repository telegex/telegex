defmodule EchoBot.UpdatesPoller do
  @moduledoc """
  A polling service for getting updates.
  """

  require Logger

  use GenServer

  alias EchoBot.Consumer

  @doc """
  Start the service.

  At the same time, the `offset` value is initialized to `0`.
  """
  def start_link(default \\ []) when is_list(default) do
    GenServer.start_link(__MODULE__, %{offset: 0}, name: __MODULE__)
  end

  @impl true
  def init(state) do
    # Scheduling polling function
    schedule_pull_updates()
    {:ok, state}
  end

  @doc """
  Handling message.

  Including: pull updates, handle failed requests.
  """
  @impl true
  def handle_info(:pull, %{offset: last_offset} = state) do
    offset =
      case Telegex.get_updates(offset: last_offset) do
        {:ok, updates} ->
          # Consume messages.
          # Generally speaking, we will use DynamicSupervisor to consume messages.
          # Because the polling service should not be blocked, and concurrent processing.
          updates |> Enum.each(&Consumer.receive/1)

          # Calculate the value of the next offset.
          if Enum.empty?(updates),
            do: last_offset,
            else: List.last(updates).update_id + 1

        {:error, %Telegex.Model.Error{description: "Bad Gateway"}} ->
          # Telegram server failure, greatly reducing the frequency of requests
          :timer.sleep(500)

          last_offset

        {:error, reason} ->
          Logger.error("Update pull failed, reason: #{inspect(reason)}")
          # An error occurred, reduce the frequency of requests
          :timer.sleep(200)

          last_offset
      end

    # A pull request every 35ms to avoid 429 error codes
    :timer.sleep(35)
    schedule_pull_updates()

    {:noreply, %{state | offset: offset}}
  end

  # Send pull messages to the service itself
  defp schedule_pull_updates do
    send(self(), :pull)
  end
end
