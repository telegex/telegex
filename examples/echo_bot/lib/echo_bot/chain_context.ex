defmodule EchoBot.ChainContext do
  @moduledoc false

  use Telegex.Chain.Context

  defcontext([
    {:chat_id, integer},
    {:user_id, integer},
    {:chat_title, String.t()}
  ])
end
