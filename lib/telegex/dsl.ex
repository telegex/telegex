defmodule Telegex.DSL do
  @moduledoc false
  defmacro __using__(_) do
    quote do
      require Telegex.DSL
      import Telegex.DSL
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

  @type arraytypes :: true | :array_of_array | nil
  @type genopts :: [{:optional, boolean()}, {:array, arraytypes()}]

  @spec gen_struct_field_ast(atom(), [atom()], genopts()) :: tuple()
  defp gen_struct_field_ast(key, type, options \\ []) do
    optional? = options |> Keyword.get(:optional, false)
    array = options |> Keyword.get(:array)

    aliases = completion_type(type)
    aliases_ast = {{:., [], [{:__aliases__, [alias: false], aliases}, :t]}, [], []}

    args =
      case array do
        nil -> [key, aliases_ast]
        true -> [key, [aliases_ast]]
        :array_of_array -> [key, [[aliases_ast]]]
      end

    args = if optional?, do: args, else: args ++ [[enforce: true]]

    {:field, [], args}
  end

  defp gen_normal_field_ast(key, type, options \\ []) do
    optional? = options |> Keyword.get(:optional, false)
    array = options |> Keyword.get(:array)

    types_ast = {type, [], []}

    args =
      case array do
        nil -> [key, types_ast]
        true -> [key, [types_ast]]
        :array_of_array -> [key, [[types_ast]]]
      end

    args = if optional?, do: args, else: args ++ [[enforce: true]]

    {:field, [], args}
  end

  # 结构类型可选
  defp gen_field_ast({:{}, [_], [key, {:__aliases__, [_], type}, :optional]} = _ast),
    do: gen_struct_field_ast(key, type, optional: true)

  # 结构类型不可选
  defp gen_field_ast({key, {:__aliases__, [_], type}} = _ast),
    do: gen_struct_field_ast(key, type)

  # 数组结构类型可选
  defp gen_field_ast({:{}, [_], [key, [{:__aliases__, [_], type}], :optional]} = _ast),
    do: gen_struct_field_ast(key, type, optional: true, array: true)

  # 数组结构类型不可选
  defp gen_field_ast({key, [{:__aliases__, [_], type}]} = _ast),
    do: gen_struct_field_ast(key, type, array: true)

  # 二维数组结构类型不可选
  defp gen_field_ast({key, [[{:__aliases__, [_], type}]]} = _ast),
    do: gen_struct_field_ast(key, type, array: :array_of_array)

  # 带有或关系的多种类型可选
  # TODO: 此处表明 AST 的构造操作还需要独立细分以达到最大程度的复用
  defp gen_field_ast({:{}, [_], [key, {:|, [_], types_ast}, :optional]} = _ast) do
    typespecs_ast =
      types_ast
      |> Enum.map(fn type_ast ->
        case type_ast do
          {:__aliases__, _, type} ->
            {{:., [], [{:__aliases__, [alias: false], completion_type(type)}, :t]}, [], []}

          type ->
            {{:., [], [{:__aliases__, [alias: false], [:Telegex, :Model]}, type]}, [], []}
        end
      end)

    {:field, [], [key, {:|, [], typespecs_ast}]}
  end

  # 普通类型可选
  defp gen_field_ast({:{}, [_], [key, type, :optional]} = _ast),
    do: gen_normal_field_ast(key, type, optional: true)

  # 数组普通类型不可选
  defp gen_field_ast({key, [type]}),
    do: gen_normal_field_ast(key, type, array: true)

  # 普通类型不可选
  defp gen_field_ast({key, type} = _ast),
    do: gen_normal_field_ast(key, type)

  @spec completion_type([atom()]) :: [atom(), ...]
  defp completion_type(type) do
    case type do
      [:String] ->
        [:String]

      [name] ->
        [:Telegex, :Model, name]
    end
  end
end
