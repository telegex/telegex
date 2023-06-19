defmodule Telegex.Chain.Context do
  @moduledoc false

  defmacro __using__(_) do
    quote do
      import unquote(__MODULE__)

      require unquote(__MODULE__)
    end
  end

  @bot_field_spec quote do: {:bot, Telegex.Type.User.t(), enforce: true}
  @payload_field_spec quote do: {:payload, %{method: String.t()}}
  @reason_field_spec quote do: {:reason, any}

  defmacro defcontext(sepcs) do
    fields_ast = Enum.map(sepcs, &gen_field_spec_ast/1)

    fields_ast =
      fields_ast ++
        [
          gen_field_spec_ast(@bot_field_spec),
          gen_field_spec_ast(@payload_field_spec),
          gen_field_spec_ast(@reason_field_spec)
        ]

    ast =
      quote do
        use TypedStruct

        typedstruct do
          unquote(fields_ast)
        end
      end

    # ast |> Macro.to_string() |> IO.puts()

    ast
  end

  # 将二元组转换为三元组
  # like: {:user_id, {:integer, [], nil}}
  defp gen_field_spec_ast({field, type}) do
    gen_field_spec_ast([field, type, []])
  end

  defp gen_field_spec_ast({:{}, _, spec_ast}) do
    gen_field_spec_ast(spec_ast)
  end

  defp gen_field_spec_ast(spec_ast) do
    {:field, [], spec_ast}
  end
end
