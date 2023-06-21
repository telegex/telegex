defmodule Telegex.MethodDefiner do
  @moduledoc false

  alias Telegex.TypeDefiner
  alias Telegex.TypeDefiner.{ArrayType, UnionType}

  @type paramater_type :: TypeDefiner.field_type()

  defmacro __using__(_) do
    quote do
      require Telegex.MethodDefiner
      import Telegex.MethodDefiner

      alias Telegex.TypeDefiner.{ArrayType, UnionType}
    end
  end

  defp quoted(ast, caller) do
    {quoted, []} = Code.eval_quoted(ast, [], caller)

    quoted
  end

  defmacro defmethod(name, description, paramaters, returned_type) do
    quoted_paramaters = quoted(paramaters, __CALLER__)

    method_name = name |> Macro.underscore() |> String.to_atom()
    required_arg_names = required_arg_names(quoted_paramaters)
    optional_arg_names = optional_arg_names(quoted_paramaters)

    required_arg_types = required_types(quoted_paramaters)
    optional_arg_names_types = optional_names_types(quoted_paramaters)

    has_optional = !Enum.empty?(optional_arg_names)

    rtype_ast = TypeDefiner.field_type_ast(quoted(returned_type, __CALLER__))

    # 扫描包含附件的字段列表
    attachment_param_names = attachment_param_names(quoted_paramaters)

    ast =
      quote do
        @spec unquote(
                def_spec_name_args(method_name, required_arg_types, optional_arg_names_types)
              ) :: {:ok, unquote(rtype_ast)} | {:error, Telegex.Type.error()}
        @doc unquote(description)
        def unquote(def_fun_name_args(method_name, required_arg_names, optional_arg_names)) do
          required_opts = unquote(build_required_opts(required_arg_names))

          params =
            Keyword.merge(
              required_opts,
              unquote(if has_optional, do: defident(:optional), else: [])
            )

          opts = [attachment_fields: unquote(attachment_param_names)]

          case Telegex.Caller.call(unquote(name), params, opts) do
            {:ok, result} ->
              # TODO: 可以在编译器确定返回值是基础类型还是引用类型，进而避免调用转换代码
              {:ok, Telegex.Helper.typedmap(result, unquote(returned_type))}

            e ->
              e
          end
        end
      end

    # ast |> Macro.to_string() |> IO.puts()

    ast
  end

  defp required_arg_names(paramaters) do
    paramaters
    |> Enum.filter(fn paramater -> paramater.required end)
    |> Enum.map(fn paramater -> paramater.name end)
  end

  defp optional_arg_names(paramaters) do
    paramaters
    |> Enum.filter(fn paramater -> !paramater.required end)
    |> Enum.map(fn paramater -> paramater.name end)
  end

  # code: [chat_id: chat_id]
  # ast: [chat_id: {:chat_id, [], Elixir}]
  defp build_required_opts(required_arg_names) do
    Enum.map(required_arg_names, fn name ->
      {name, defident(name)}
    end)
  end

  # code: send_message(chat_id)
  # ast: {:def, [context: Elixir, imports: [{1, Kernel}, {2, Kernel}]],
  #  [
  #    {:send_message, [context: Elixir], [{:chat_id_, [], Elixir}]}
  #  ]}

  defp def_fun_name_args(fun_name, required_args, optional_args) do
    args_ast = []

    args_ast =
      args_ast ++
        if Enum.empty?(required_args) do
          []
        else
          Enum.map(required_args, &defident/1)
        end

    args_ast =
      args_ast ++
        if Enum.empty?(optional_args) do
          []
        else
          [default_arg(:optional)]
        end

    {fun_name, [], args_ast}
  end

  defp required_types(paramaters) do
    paramaters
    |> Enum.filter(fn paramater -> paramater.required end)
    |> Enum.map(fn paramater -> paramater.type end)
  end

  defp optional_names_types(paramaters) do
    paramaters
    |> Enum.filter(fn paramater -> !paramater.required end)
    |> Enum.map(fn paramater -> {paramater.name, paramater.type} end)
  end

  defp def_spec_name_args(fun_name, required_types, optional_names_types) do
    required_types_ast = Enum.map(required_types, fn type -> TypeDefiner.field_type_ast(type) end)

    optional_type_ast =
      Enum.map(optional_names_types, fn {name, type} ->
        {name, TypeDefiner.field_type_ast(type)}
      end)

    optional_type_ast =
      if Enum.empty?(optional_type_ast) do
        []
      else
        # 可选参数类型是一个关键字列表，需要套一层 `[]` 避免列表追加时被剥离出来
        [optional_type_ast]
      end

    types_ast = required_types_ast ++ optional_type_ast

    {fun_name, [], types_ast}
  end

  defp attachment_param_names(paramaters) do
    paramaters
    |> Enum.filter(fn paramater -> include_attachment?(paramater.type) end)
    |> Enum.map(fn paramater -> paramater.name end)
  end

  @spec include_attachment?(TypeDefiner.field_type()) :: boolean
  def include_attachment?(Telegex.Type.InputFile), do: true

  def include_attachment?(type) when is_atom(type) do
    Code.ensure_loaded(type)

    if function_exported?(type, :__attachments__, 0) && !Enum.empty?(type.__attachments__()) do
      true
    else
      TypeDefiner.attachment_type?(type)
    end
  end

  def include_attachment?(%UnionType{types: types}) do
    Enum.find(types, &include_attachment?/1) != nil
  end

  def include_attachment?(%ArrayType{elem_type: type}) do
    include_attachment?(type)
  end

  defp defident(atom_text), do: {atom_text, [], Elixir}

  # code: optional \\ []
  # ast: {:\\, [], [{:optional, [], Elixir}, []]}
  defp default_arg(arg_name), do: quote(do: unquote(defident(arg_name)) \\ [])
end
