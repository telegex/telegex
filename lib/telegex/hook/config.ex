defmodule Telegex.Hook.Config do
  @moduledoc false

  use TypedStruct

  typedstruct do
    field :server_port, non_neg_integer, default: 4000
    field :on_update, (Telegex.Type.Update.t() -> Telegex.Hook.Handler.handle_result())
  end
end
