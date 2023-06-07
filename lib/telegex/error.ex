defmodule Telegex.Error do
  @moduledoc "Error result in API response."

  use TypedStruct

  typedstruct do
    field :error_code, integer, enforce: true
    field :description, String.t(), enforce: true
  end
end
