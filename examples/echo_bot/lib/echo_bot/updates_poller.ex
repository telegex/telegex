defmodule EchoBot.UpdatesPoller do
  @moduledoc false

  use GenServer

  alias EchoBot.Consumer

  require Logger

  def start_link(_) do
    {:ok, user} = Telegex.get_me()

    Logger.info("Bot (@#{user.username}) is working")

    GenServer.start_link(__MODULE__, %{user: user, offset: 0}, name: __MODULE__)
  end

  @impl true
  def init(state) do
    Logger.info("Updates poller has started")

    schedule_pull_updates()

    {:ok, state}
  end

  @doc """
  处理消息。

  每收到一次 `:pull` 消息，就获取下一次更新，并修改状态中的 `offset` 值。
  """
  @impl true
  def handle_info(:pull, %{offset: offset} = state) do
    offset =
      case Telegex.get_updates(offset: offset) do
        {:ok, updates} ->
          # 消费消息
          Enum.each(updates, &Consumer.receive/1)

          if Enum.empty?(updates) do
            offset
          else
            # 计算新的 offset
            List.last(updates).update_id + 1
          end

        {:error, %{description: "Bad Gateway"}} ->
          # TG 服务器故障，大幅度降低请求频率
          :timer.sleep(500)

          offset

        {:error, reason} ->
          Logger.warning("Pull updates failed: #{inspect(reason: reason)}")

          # 发生错误，降低请求频率
          :timer.sleep(200)

          offset
      end

    # 每 35ms 一个拉取请求，避免 429 错误
    :timer.sleep(35)

    schedule_pull_updates()

    {:noreply, %{state | offset: offset}}
  end

  @impl true
  def handle_info({:ssl_closed, _} = msg, state) do
    Logger.warning("Known network failure: #{inspect(msg: msg)}")

    {:noreply, state}
  end

  defp schedule_pull_updates do
    send(self(), :pull)
  end
end
