defmodule Telegex.GenAngler do
  @moduledoc """
  `use Telegex.GenAngler` is an alias of `use Telegex.Hook.GenHandler`.
  """

  defmacro __using__(opts) do
    quote do
      use Telegex.Hook.GenHandler, unquote(opts)
    end
  end
end
