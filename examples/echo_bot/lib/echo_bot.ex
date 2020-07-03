defmodule EchoBot do
  @moduledoc false

  use GenServer

  require Logger

  @impl true
  def init(state) do
    # Start scheduling updates
    schedule_pull_updates()

    {:ok, state}
  end

  def start_link(_) do
    # Save the offset value in the state and give it an initial value of -1
    GenServer.start_link(__MODULE__, %{offset: -1}, name: __MODULE__)
  end

  @impl true
  def handle_info(:pull, state = %{offset: last_offset}) do
    offset =
      case Telegex.get_updates(offset: last_offset) do
        {:ok, updates} ->
          # Consumer updates
          updates |> Enum.each(&EchoBot.Consumer.receive/1)
          # Calculate the value of the next offset
          if length(updates) > 0,
            do: List.last(updates).update_id + 1,
            else: last_offset

        e ->
          Logger.error(
            "An error occurred while pulling the updates, keeping the last offset value"
          )

          Logger.error(inspect(e))

          last_offset
      end

    # If updates are obtained, pause for 200 milliseconds.
    # If the offset has not changed (no update or an error has occurred), then pause for 500 milliseconds.
    if offset == last_offset, do: :timer.sleep(500), else: :timer.sleep(200)
    # Schedule the next pull updates
    schedule_pull_updates()

    {:noreply, %{state | offset: offset}}
  end

  # Schedule the GenServer to pull updates
  defp schedule_pull_updates do
    send(self(), :pull)
  end
end
