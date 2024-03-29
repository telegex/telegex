defmodule Telegex.Chain.HandlerTest do
  use ExUnit.Case

  use Telegex.Chain.Handler

  defmodule Context do
    use Telegex.Chain.Context

    defcontext([
      {:chat_id, integer},
      {:user_id, integer}
    ])
  end

  defmodule InitSendSourceChain do
    use Telegex.Chain

    @impl true
    def handle(%{message: message} = _update, state) do
      case message do
        %{chat: chat} -> {:ok, %{state | chat_id: chat.id}}
        _ -> {:ok, state}
      end
    end

    @impl true
    def handle(_update, state) do
      {:ok, state}
    end
  end

  defmodule InitCallSourceChain do
    use Telegex.Chain

    @impl true
    def handle(%{callback_query: callback_query} = _update, state) do
      case callback_query.message do
        %{from: user} -> {:ok, %{state | user_id: user.id}}
        _ -> {:ok, state}
      end
    end

    @impl true
    def handle(_update, state) do
      {:ok, state}
    end
  end

  defmodule SendHelloChain do
    use Telegex.Chain

    @impl true
    def handle(_update, %{chat_id: chat_id} = state) when chat_id != nil do
      payload = %{method: "sendMessage", params: %{chat_id: state.chat_id, text: "Hello"}}

      {:done, %{state | payload: payload}}
    end

    @impl true
    def handle(_update, state) do
      {:ok, state}
    end
  end

  pipeline([InitSendSourceChain, InitCallSourceChain, SendHelloChain])

  test "handle/2" do
    chat_id = -1_001_486_769_003
    bot = %{username: "telegex_dev_bot"}

    r = call(%{message: %{chat: %{id: chat_id}}}, %__MODULE__.Context{bot: bot})

    assert {:done,
            %Context{
              chat_id: chat_id,
              user_id: nil,
              bot: bot,
              payload: %{
                params: %{text: "Hello", chat_id: chat_id},
                method: "sendMessage"
              },
              reason: nil
            }} == r

    bot = %{username: "telegex_dev_bot"}

    r =
      call(%{callback_query: %{message: %{from: %{id: chat_id}}}}, %__MODULE__.Context{
        bot: bot
      })

    assert {:ok,
            %Context{
              chat_id: nil,
              user_id: chat_id,
              bot: bot,
              payload: nil,
              reason: nil
            }} == r
  end
end
