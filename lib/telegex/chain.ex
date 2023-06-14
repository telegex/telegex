defmodule Telegex.Chain do
  @moduledoc false

  alias Telegex.Type.Update

  @type state :: :ok | :stop | :done
  @type payload :: %{method: String.t()}
  @type context :: %{payload: payload | nil, reason: any}
  @type result :: {state, context}

  @callback call(update :: Update.t(), context :: context) :: result

  defmacro __using__(_) do
    quote do
      @behaviour unquote(__MODULE__)
    end
  end
end
