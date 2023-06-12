defmodule EchoBot.ChainHandler do
  @moduledoc false

  use Telegex.Chain.Handler

  pipeline([
    EchoBot.EchoTextChain
  ])
end
