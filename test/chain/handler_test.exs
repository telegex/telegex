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
    r = call(%{message: %{chat: %{id: 10001}}}, %__MODULE__.Context{})

    assert {:done,
            %Context{
              chat_id: 10001,
              user_id: nil,
              payload: %{params: %{text: "Hello", chat_id: 10001}, method: "sendMessage"},
              reason: nil
            }} == r

    r = call(%{callback_query: %{message: %{from: %{id: 10001}}}}, %__MODULE__.Context{})

    assert {:ok,
            %Context{
              chat_id: nil,
              user_id: 10001,
              payload: nil,
              reason: nil
            }} == r
  end
end
