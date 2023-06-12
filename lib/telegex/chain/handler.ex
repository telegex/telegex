defmodule Telegex.Chain.Handler do
  @moduledoc false

  # 以管道的形式调用多个 chain
  def call(chains, update, context \\ %{})
      when is_list(chains) and is_struct(update, Telegex.Type.Update) and is_map(context) do
    call_chain = fn chain, {_state, context} ->
      case chain.call(update, context) do
        {:ignore, context} -> {:cont, {:ignore, context}}
        {:stop, context} -> {:halt, {:stop, context}}
        {:done, context} -> {:halt, {:done, context}}
      end
    end

    Enum.reduce_while(chains, {:init, context}, call_chain)
  end

  defmacro __using__(_) do
    quote do
      import unquote(__MODULE__)

      require unquote(__MODULE__)
    end
  end

  defmacro pipeline(modules) do
    quote do
      def __chains__ do
        unquote(modules)
      end

      @spec call(Telegex.Type.Update.t(), Telegex.Chain.context()) :: Telegex.Chain.result()
      def call(update, context) do
        unquote(__MODULE__).call(__MODULE__.__chains__(), update, context)
      end
    end
  end
end
