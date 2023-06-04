defmodule Telegex.RequestError do
  @moduledoc false

  use TypedStruct

  typedstruct do
    field :reason, atom, enforce: true
  end
end
