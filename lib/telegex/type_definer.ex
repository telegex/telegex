defmodule Telegex.TypeDefiner do
  @moduledoc false

  use TypedStruct

  # TODO: 添加生成联合类型模块的宏，会按照原始名称生成模块以及类型数组生成 `@type t :: Model1.t | Model2.t`。目的是让联合类型可以直接被当作普通类型使用。

  defmacro __using__(_) do
    quote do
      require Telegex.TypeDefiner
      import Telegex.TypeDefiner

      alias Telegex.TypeDefiner.{FieldMeta, ArrayType, UnionType}
    end
  end

  typedstruct module: ArrayType do
    field :elem_type, Telegex.TypeDefiner.field_type()
  end

  typedstruct module: UnionType do
    field :types, [Telegex.TypeDefiner.field_type()]
  end

  @type field_type ::
          :integer | :string | :boolean | :float | module | ArrayType.t() | UnionType.t()

  typedstruct module: FieldMeta do
    field :name, atom
    field :type, Telegex.TypeDefiner.field_type()
    field :optional, boolean
    field :description, String.t()
  end

  def def_moduledoc_ast(comment) do
    quote do
      @moduledoc unquote(comment)
    end
  end

  def def_field_ast(field, caller) do
    {field_struct, []} = Code.eval_quoted(field, [], caller)

    type_spec = field_type_ast(field_struct.type)

    name = field_struct.name
    enforce = !field_struct.optional

    quote do
      field unquote(name), unquote(type_spec), enforce: unquote(enforce)
    end
  end

  def field_type_ast(:string), do: quote(do: String.t())
  def field_type_ast(:boolean), do: quote(do: boolean)
  def field_type_ast(:integer), do: quote(do: integer)
  def field_type_ast(:float), do: quote(do: float)

  def field_type_ast(%ArrayType{elem_type: elem_type}) do
    quote do
      [unquote(field_type_ast(elem_type))]
    end
  end

  def field_type_ast(%UnionType{types: types}) do
    type_list_ast = Enum.map(types, &field_type_ast/1)

    union_type_ast = types_to_union(type_list_ast)

    quote do
      unquote(union_type_ast)
    end
  end

  def types_to_union(ast_types) do
    _types_to_union(Enum.reverse(ast_types))
  end

  # 联合类型 AST 的例子，联合类型并不是一个平行的结构，而是一个深度嵌套结构。
  # 此处的联合类型指的是 `integer | String.t | boolean` 这种具有多种可能的 type 组合
  # {:|, [],
  #  [
  #    {:integer, [], Elixir},
  #    {:|, [],
  #     [
  #       {{:., [], [{:__aliases__, [alias: false], [:String]}, :t]},
  #        [no_parens: true], []},
  #       {:boolean, [], Elixir}
  #     ]}
  #  ]}

  def _types_to_union(reversed_ast_types, i \\ 0, ast \\ nil) do
    current = Enum.at(reversed_ast_types, i)

    cond do
      i == 0 ->
        # 将倒数第二个和最后一个组合成第一个 ast
        ast = {:|, [], [Enum.at(reversed_ast_types, i + 1), current]}

        _types_to_union(reversed_ast_types, i + 2, ast)

      current != nil ->
        # 不断的将当前的 ast 和之前的 ast 组合成新的嵌套 ast
        _types_to_union(reversed_ast_types, i + 1, {:|, [], [current, ast]})

      true ->
        ast
    end
  end

  def field_type_ast(module) do
    quote do
      unquote(module).t
    end
  end

  defmacro deftype(name, description, fields) do
    fields_ast = Enum.map(fields, fn field -> def_field_ast(field, __CALLER__) end)

    quote do
      unquote(def_moduledoc_ast(description))

      typedstruct module: __MODULE__.unquote(name) do
        unquote(fields_ast)
      end
    end
  end

  defmacro defunion(name, description, types) do
    types_ast = Enum.map(types, fn type -> field_type_ast(type) end)

    quote do
      unquote(def_moduledoc_ast(description))

      defmodule __MODULE__.unquote(name) do
        @type t :: unquote(types_to_union(types_ast))
      end
    end
  end
end
