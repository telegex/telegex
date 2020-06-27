defmodule Telegex.DSL do
  @moduledoc false

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

        # 自定义编码过程，去掉所有的 nil 字段
        defimpl Jason.Encoder, for: unquote(name) do
          def encode(struct, opts) do
            struct
            |> Map.from_struct()
            |> Enum.filter(fn {_, v} -> v != nil end)
            |> Enum.into(%{})
            |> Jason.encode!()
          end
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

  # 补全结构类型的模块名
  @spec completion_type([atom()]) :: [atom(), ...]
  defp completion_type(type) do
    case type do
      [:String] ->
        [:String]

      [name] ->
        [:Telegex, :Model, name]
    end
  end

  @optionals_arg_ast {:\\, [], [{:optionals, [], Elixir}, []]}
  @request_call_ast {:., [], [{:__aliases__, [alias: false], [:Telegex, :Request]}, :call]}
  @keyword_merge_ast {:., [], [{:__aliases__, [alias: false], [:Keyword]}, :merge]}

  @doc """
  构造 Telegram bot API 调用函数
  """
  defmacro method(name, params, returns) do
    # 转换方法名称得到函数名称
    fun_name = name |> Macro.underscore() |> String.to_atom()
    # 初始化参数 ast
    args_ast = []
    # 获取不可选参数类别
    require_params = params |> Enum.filter(&require?/1)
    # 获取可选参数列表
    optional_params = params |> Enum.filter(&optional?/1)

    # 1. 构建必要参数 ast
    require_args_ast = require_params |> Enum.map(&build_arg_ast/1)
    args_ast = args_ast ++ require_args_ast

    # 2. 构建可选参数 ast
    args_ast =
      if length(optional_params) > 0, do: args_ast ++ [@optionals_arg_ast], else: args_ast

    # 构造函数签名 ast
    fun_sign_ast = {fun_name, [], args_ast}

    # 3. 构造 call 调用的 ast
    require_args_keyword_list_ast = require_params |> Enum.map(&build_arg_keyword_ast/1)

    keyword_merge_args_ast =
      if length(optional_params) > 0,
        do: [require_args_keyword_list_ast, {:optionals, [], Elixir}],
        # 不存在可选，和空列表 merge
        else: [require_args_keyword_list_ast, []]

    call_ast = {@request_call_ast, [], [name, {@keyword_merge_ast, [], keyword_merge_args_ast}]}

    # 4. 构造必要参数的 typespecs ast
    args_typespecs_ast = require_params |> Enum.map(&build_arg_typespec_ast/1)

    # 5. 构造可选参数的 typespecs ast
    optionals_arg_typespecs_ast = optional_params |> Enum.map(&build_named_arg_typespec_ast/1)

    args_typespecs_ast =
      if length(optionals_arg_typespecs_ast) > 0,
        do: args_typespecs_ast ++ [optionals_arg_typespecs_ast],
        else: args_typespecs_ast

    typespecs_ast = {fun_name, [], args_typespecs_ast}

    # 6. 构造返回模型的 ast
    return_typespecs_ast = build_arg_typespec_ast({:_placeholder, returns})

    quote do
      @spec unquote(typespecs_ast) ::
              {:ok, unquote(return_typespecs_ast)}
              | {:error, Telegex.Model.errors()}
      def unquote(fun_sign_ast), do: unquote(call_ast)
    end
  end

  # 检测参数是否为可选
  defp optional?({:{}, _, [_, _, :optional]}), do: true
  defp optional?(_), do: false
  # 检测参数是否必要
  defp require?(ast), do: !optional?(ast)

  # 构建单个参数的 ast
  defp build_arg_ast({name, _type}), do: {name, [], Elixir}

  # 将参数构造为关键字 ast
  defp build_arg_keyword_ast({name, _type}), do: {name, {name, [], Elixir}}

  # 将存在或关系的多种类型构造为 typespec ast
  defp build_arg_typespec_ast({_name, {:|, _, types}}) do
    {:|, [],
     Enum.map(types, fn type_ast -> build_arg_typespec_ast({:_placeholder, type_ast}) end)}
  end

  # 将数组结构类型参数构造为 typespec ast
  defp build_arg_typespec_ast({_name, [{:__aliases__, _, type}]}),
    do: [build_arg_typespec_ast({:_placeholder, {:__aliases__, :_placeholder, type}})]

  # 将结构类型参数构造为 typespec ast
  defp build_arg_typespec_ast({_name, {:__aliases__, _, type}}) do
    {{:., [], [{:__aliases__, [alias: false], completion_type(type)}, :t]}, [], []}
  end

  # 将数据普通类型参数构造为 typespec ast
  defp build_arg_typespec_ast({_name, [type]}),
    do: [build_arg_typespec_ast({:_placeholder, type})]

  # 将普通类型参数构造为 typespec ast
  defp build_arg_typespec_ast({_name, type}), do: {type, [], []}

  defp build_named_arg_typespec_ast({:{}, _, [name, type_ast, :optional]} = _ast),
    do: {name, build_arg_typespec_ast({:_placeholder, type_ast})}
end
