defmodule Telegex.Response do
  @moduledoc false

  use TypedStruct

  typedstruct do
    field :ok, boolean, enforce: true
    field :result, any
    field :error_code, integer
    field :description, String.t()
  end
end
