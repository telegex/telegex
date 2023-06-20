defmodule EchoBot.CallHelloChain do
  @moduledoc false

  use Telegex.Chain, {:callback_query, prefix: "hello:"}

  @impl true
  def handle(callback_query, context) do
    context = %{
      context
      | payload: %{
          method: "answerCallbackQuery",
          callback_query_id: callback_query.id,
          text: "Hello 😀",
          show_alert: true
        }
    }

    {:done, context}
  end
end
