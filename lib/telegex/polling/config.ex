defmodule Telegex.Polling.Config do
  @moduledoc false

  use TypedStruct

  # 此处有关 `get_update/1` 函数可选参数的默认值应参考 https://core.telegram.org/bots/api#getupdates
  typedstruct do
    field :interval, non_neg_integer, default: 35
    field :offset, integer, default: 0
    field :limit, non_neg_integer, default: 100
    field :timeout, non_neg_integer, default: 0
    field :allowed_updates, [String.t()], default: []
  end
end
