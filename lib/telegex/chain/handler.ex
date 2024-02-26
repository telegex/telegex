defmodule Telegex.Chain.Handler do
  @moduledoc false

  defmacro __using__(_) do
    quote do
      import unquote(__MODULE__), only: [pipeline: 1]

      require unquote(__MODULE__)
    end
  end

  defmacro pipeline(modules) do
    clauses_ast =
      modules
      |> Enum.map(&build_with_clause_ast/1)
      |> Enum.to_list()

    quote do
      @spec call(Telegex.Type.Update.t(), Telegex.Chain.context()) :: Telegex.Chain.result()
      def call(update, context) do
        with unquote_splicing(clauses_ast) do
          {:ok, context}
        else
          {:stop, _} = stop_r ->
            stop_r

          {:done, _} = done_r ->
            done_r

          {state, context} when is_map(context) ->
            raise "Unknown chain state: #{inspect(state)}"

          other ->
            raise "Unknown chain result: #{inspect(other)}"
        end
      end
    end
  end

  defp build_with_clause_ast(module) do
    quote do
      {:ok, context} <- unquote(module).call(update, context)
    end
  end
end
