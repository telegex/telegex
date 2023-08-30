defmodule Telegex.Polling.Config do
  @moduledoc """
  Configure polling mode.

  Return the `%Telegex.Polling.Config{...}` struct for configuring the polling mode.

  ## Field descriptions

    * `interval` - Interval in milliseconds between pulling updates. Defaults to `35`.
    * `offset` - The `offset` parameter of the [`getUpdates`](https://core.telegram.org/bots/api#getupdates) method.
    * `limit` - The `limit` parameter of the [`getUpdates`](https://core.telegram.org/bots/api#getupdates) method. Defaults to `100`.
    * `timeout` - The `timeout` parameter of the [`getUpdates`](https://core.telegram.org/bots/api#getupdates) method. Defaults to `0`.
    * `allowed_updates` - The `allowed_updates` parameter of the [`getUpdates`](https://core.telegram.org/bots/api#getupdates) method.
  """

  use TypedStruct

  typedstruct do
    field :interval, non_neg_integer, default: 35
    field :offset, integer, default: 0
    field :limit, non_neg_integer, default: 100
    field :timeout, non_neg_integer, default: 0
    field :allowed_updates, [String.t()], default: []
  end
end
