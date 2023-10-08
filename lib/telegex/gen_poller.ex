defmodule Telegex.GenPoller do
  @moduledoc """
  `use Telegex.GenPoller` is an alias of `use Telegex.Polling.GenHandler`.
  """

  defmacro __using__(opts) do
    quote do
      use Telegex.Polling.GenHandler, unquote(opts)
    end
  end
end
