defmodule Telegex.Polling.Handler do
  @moduledoc """
  Generate your polling handler, which includes a supervisor with poller and consumer children.
  """

  require Logger

  defmacro __using__(_) do
    quote do
      @behaviour unquote(__MODULE__)

      use Supervisor

      require Logger

      def start_link(_) do
        children = [
          unquote(__CALLER__.module).UpdatesConsumer,
          unquote(__CALLER__.module).UpdatesPoller
        ]

        opts = [strategy: :one_for_one, name: __MODULE__.Supervisor]
        Supervisor.start_link(children, opts)
      end

      @impl Supervisor
      def init(state) do
        {:ok, state}
      end

      @impl unquote(__MODULE__)
      def on_boot, do: %{}

      @impl unquote(__MODULE__)
      def on_update(_update) do
        Logger.warning(
          "New update from Telegram Bot API Server, but `on_update/1` is not implemented"
        )
      end

      @impl unquote(__MODULE__)
      def on_init(_init_arg) do
        Logger.info("Updates poller started")
      end

      @impl unquote(__MODULE__)
      def on_failure(reason) do
        Logger.error("Polling error occurred, use on_failure/1 to capture it: #{inspect(reason)}")
      end

      defoverridable on_boot: 0, on_init: 1, on_update: 1, on_failure: 1

      defmodule UpdatesPoller do
        @moduledoc false

        use GenServer

        alias unquote(__CALLER__.module).Consumer

        require Logger

        def start_link(_) do
          # 回调启动函数获取配置
          config = unquote(__CALLER__.module).on_boot()

          GenServer.start_link(__MODULE__, Map.from_struct(config), name: __MODULE__)
        end

        @impl true
        def init(state) do
          # 回调初始化函数
          :ok = unquote(__CALLER__.module).on_init(state)

          schedule_pull_updates()

          {:ok, state}
        end

        @impl true
        def handle_info(:pull, state) do
          updates_opts = [
            offset: state.offset,
            limit: state.limit,
            timeout: state.timeout,
            allowed_updates: state.allowed_updates
          ]

          offset =
            case Telegex.get_updates(updates_opts) do
              {:ok, []} ->
                # 返回旧的 offset
                state.offset

              {:ok, updates} ->
                # 消费消息
                _ =
                  updates
                  |> Stream.each(&unquote(__CALLER__.module).UpdatesConsumer.receive/1)
                  |> Stream.run()

                # 计算新的 offset
                List.last(updates).update_id + 1

              {:error, reason} ->
                unquote(__CALLER__.module).on_failure(reason)

                # 返回旧的 offset
                state.offset
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

      defmodule UpdatesConsumer do
        @moduledoc false

        use DynamicSupervisor

        def start_link(_) do
          DynamicSupervisor.start_link(__MODULE__, %{}, name: __MODULE__)
        end

        @impl true
        def init(_) do
          DynamicSupervisor.init(strategy: :one_for_one)
        end

        def receive(update) when is_struct(update, Telegex.Type.Update) do
          DynamicSupervisor.start_child(
            __MODULE__,
            {Task, fn -> consume(update) end}
          )
        end

        defp consume(update) do
          case unquote(__CALLER__.module).on_update(update) do
            {:done, %{payload: payload}} ->
              unquote(__MODULE__).handle_payload(payload)

            _ ->
              :ok
          end
        end
      end
    end
  end

  def handle_payload(%{method: method} = payload) do
    params = Map.drop(payload, [:method])

    case Telegex.Caller.call(method, Enum.into(params, [])) do
      {:error, error} ->
        # 根据 done 的荷载调用失败
        Logger.error(
          "Call the method fails with a payload: #{inspect(reason: error, payload: payload)}"
        )

      _ ->
        :ok
    end
  end

  def handle_payload(payload) do
    Logger.warning("The payload is not a valid method call: #{inspect(payload: payload)}")
  end

  @callback on_boot :: Telegex.Polling.Config.t()
  @callback on_init(init_arg :: map) :: :ok
  @callback on_update(update :: Telegex.Type.Update.t()) :: :ok | Telegex.Chain.result()
  @callback on_failure(reason :: Telegex.Type.error()) :: no_return
end
