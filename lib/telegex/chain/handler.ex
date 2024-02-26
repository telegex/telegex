defmodule Telegex.Chain.Handler do
  @moduledoc false

  defmacro __using__(_) do
    quote do
      import unquote(__MODULE__), only: [pipeline: 1]

      require unquote(__MODULE__)
    end
  end

  defmacro pipeline(modules) do
    clauses =
      modules
      |> Enum.map(
        &quote do
          {:ok, context} <- unquote(&1).call(update, context)
        end
      )
      |> Enum.to_list

    quote do
      @spec call(Telegex.Type.Update.t(), Telegex.Chain.context()) :: Telegex.Chain.result()
      def call(update, context) do
        with unquote_splicing(clauses) do
          {:ok, context}
        else
          err -> err
        end
      end
    end
  end
end
