defmodule Telegex.Hook.Config do
  @moduledoc false

  use TypedStruct

  typedstruct do
    field :server_port, non_neg_integer, default: 4000
    field :on_update, (Telegex.Type.Update.t() -> :ok | Telegex.Chain.result())
    field :secret_token, String.t()
  end
end
