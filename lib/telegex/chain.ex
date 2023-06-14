defmodule Telegex.Chain do
  @moduledoc false

  alias Telegex.Type.Update

  @type state :: :ok | :stop | :done
  @type payload :: %{method: String.t()}
  # TODO: 恢复此处更具体的上下文规范，并解决 dialyzer 中的错误
  # @type context :: %{payload: payload | nil, reason: any}
  @type context :: map
  @type result :: {state, context}

  @callback call(update :: Update.t(), context :: context) :: result

  defmacro __using__(_) do
    quote do
      @behaviour unquote(__MODULE__)
    end
  end
end
