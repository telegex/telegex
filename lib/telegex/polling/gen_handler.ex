defmodule Telegex.Polling.GenHandler do
  @moduledoc """
  Generate your polling handler, which includes a supervisor with poller and consumer children.
  """

  require Logger

  defmacro __using__(_) do
    quote do
      @behaviour unquote(__MODULE__)

      use Supervisor

      require Logger

      def start_link(opts \\ []) do
        if Keyword.get(opts, :serve, true) do
          children = [
            unquote(__CALLER__.module).UpdatesConsumer,
            unquote(__CALLER__.module).UpdatesProvider
          ]

          opts = [strategy: :one_for_one, name: __MODULE__.Supervisor]
          Supervisor.start_link(children, opts)
        else
          Logger.warning("Polling handler is not serving")

          :ignore
        end
      end

      @impl Supervisor
      def init(state) do
        {:ok, state}
      end

      @impl unquote(__MODULE__)
      def on_boot do
        Logger.error("Polling mode is not configured, use `on_boot/0` to configure it")

        %Telegex.Polling.Config{}
      end

      @impl unquote(__MODULE__)
      def on_update(_update) do
        Logger.warning(
          "New update from Telegram Bot API Server, but `on_update/1` is not implemented"
        )

        :ok
      end

      @impl unquote(__MODULE__)
      def on_init(_init_arg) do
        Logger.info("Updates poller started")

        :ok
      end

      @impl unquote(__MODULE__)
      def on_failure(_update, reason) do
        Logger.error("An error occurs, override `on_failure/2` to catch it: #{inspect(reason)}")
      end

      defoverridable on_boot: 0, on_init: 1, on_update: 1, on_failure: 2

      defmodule UpdatesProvider do
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
                # Return old offset value.
                state.offset

              {:ok, updates} ->
                # Consume each message.
                _ =
                  updates
                  |> Stream.each(&unquote(__CALLER__.module).UpdatesConsumer.receive/1)
                  |> Stream.run()

                # Calculate and return new offset value.
                List.last(updates).update_id + 1

              {:error, reason} ->
                # 获取更新失败了
                Logger.warning("Getting updates failed: #{inspect(reason)}")

                # Return old offset value.
                state.offset
            end

          # Schedule the next delay based on the interval
          schedule_pull_updates(state.interval)

          {:noreply, %{state | offset: offset}}
        end

        @impl true
        def handle_info({:ssl_closed, _} = message, state) do
          Logger.warning("Captured network failure: #{inspect(message)}")

          {:noreply, state}
        end

        defp schedule_pull_updates(delay_millis \\ 35) do
          Process.send_after(self(), :pull, delay_millis)
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
          try do
            update |> unquote(__CALLER__.module).on_update() |> consume_context()
          rescue
            e -> unquote(__CALLER__.module).on_failure(update, {e, __STACKTRACE__})
          end
        end

        defp consume_context({:done, %{payload: payload}}) do
          unquote(__MODULE__).handle_payload(payload)
        end

        defp consume_context(_) do
          :ignore
        end
      end
    end
  end

  def handle_payload(%{method: method} = payload) do
    params = Map.drop(payload, [:method])

    case Telegex.Caller.call(method, Enum.into(params, [])) do
      {:error, reason} ->
        Logger.error("Calling payload failed: #{inspect(reason: reason, payload: payload)}")

        :error

      _ ->
        :ok
    end
  end

  def handle_payload(payload) do
    Logger.warning("Invalid payload called: #{inspect(payload: payload)}")

    :error
  end

  @callback on_boot :: Telegex.Polling.Config.t()
  @callback on_init(init_arg :: map) :: :ok
  @callback on_update(update :: Telegex.Type.Update.t()) :: :ok | Telegex.Chain.result()
  @callback on_failure(update :: Telegex.Type.Update.t(), {e :: any, stacktrace :: any}) ::
              no_return
end
