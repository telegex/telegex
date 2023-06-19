defmodule EchoBot.ChainHandler do
  @moduledoc false

  use Telegex.Chain.Handler

  pipeline([
    EchoBot.RespStartChain,
    EchoBot.RespPingChain,
    EchoBot.EchoTextChain
  ])
end
