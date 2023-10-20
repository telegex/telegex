defmodule Telegex.Hook.Config do
  @moduledoc """
  Configure webhook mode.

  ## Field descriptions

    * `server_port` - Port for the webhook server. Defaults to `4000`.
    * `secret_token` - The `secret_token` parameter of the [`setWebhook`](https://core.telegram.org/bots/api#setwebhook) method.
    Use `Telegex.Tools.gen_secret_token/1` to generate a reliable token.
  """

  use TypedStruct

  typedstruct do
    field :server_port, non_neg_integer, default: 4000
    field :secret_token, String.t()
  end
end
