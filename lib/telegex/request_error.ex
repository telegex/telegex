defmodule Telegex.RequestError do
  @moduledoc "Request sending errors, such as network issues such as timeouts, have nothing to do with API response data."

  use TypedStruct

  typedstruct do
    field :reason, atom, enforce: true
  end
end
