defmodule Telex.DSL do
  @moduledoc false
  defmacro __using__(_) do
    quote do
      require Telex.DSL
      import Telex.DSL
    end
  end

  @doc """
  Use this macro to simply construct a model.
  """
  defmacro model(name, fields) do
    fields_ast = fields |> Enum.map(&gen_field_ast/1)

    quote do
      defmodule unquote(name) do
        use TypedStruct

        typedstruct do
          unquote({:__block__, [], fields_ast})
        end
      end
    end
  end

  @type genopts :: [{:optional, boolean()}, {:array, boolean()}]

  @spec gen_field_ast(atom(), [atom()], genopts()) :: tuple()
  defp gen_field_ast(key, type, options) do
    optional? = options |> Keyword.get(:optional, false)
    array? = options |> Keyword.get(:array, false)

    aliases = completion_type(type)
    aliases_ast = {{:., [], [{:__aliases__, [alias: false], aliases}, :t]}, [], []}

    args =
      if array? do
        [key, [aliases_ast]]
      else
        [key, aliases_ast]
      end

    args = if optional?, do: args, else: args ++ [[enforce: true]]

    {:field, [], args}
  end

  # 结构类型可选
  defp gen_field_ast({:{}, [_], [key, {:__aliases__, [_], type}, :optional]} = _ast),
    do: gen_field_ast(key, type, optional: true)

  # 结构类型不可选
  defp gen_field_ast({key, {:__aliases__, [_], type}} = _ast),
    do: gen_field_ast(key, type, optional: false)

  # 数组结构类型可选
  defp gen_field_ast({:{}, [_], [key, [{:__aliases__, [_], type}], :optional]} = _ast),
    do: gen_field_ast(key, type, optional: true, array: true)

  # 普通类型可选
  defp gen_field_ast({:{}, [_], [key, type, :optional]} = _ast) do
    {:field, [], [key, {type, [], []}]}
  end

  # 普通类型不可选
  defp gen_field_ast({key, type} = _ast) do
    {:field, [], [key, {type, [], []}, [enforce: true]]}
  end

  @spec completion_type([atom()]) :: [atom(), ...]
  defp completion_type(type) do
    case type do
      [:String] -> [:String]
      [name] -> [:Telex, :Model, name]
    end
  end
end
