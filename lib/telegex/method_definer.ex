defmodule Telegex.MethodDefiner do
  @moduledoc false

  @type paramater_type :: Telegex.TypeDefiner.field_type()

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

  defmacro defmethod(name, description, paramaters, _returned_type) do
    method_name = name |> Macro.underscore() |> String.to_atom()
    required_arg_names = required_arg_names(quoted(paramaters, __CALLER__))
    optional_arg_names = optional_arg_names(quoted(paramaters, __CALLER__))

    has_optional = !Enum.empty?(optional_arg_names)

    ast =
      quote do
        @doc unquote(description)
        def unquote(def_fun_name_args(method_name, required_arg_names, optional_arg_names)) do
          required_opts = unquote(build_required_opts(required_arg_names))

          params =
            Keyword.merge(
              required_opts,
              unquote(if has_optional, do: defident(:optional), else: [])
            )

          Telegex.Caller.call(unquote(name), params)
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

  defp defident(atom_text), do: {atom_text, [], Elixir}

  # code: optional \\ []
  # ast: {:\\, [], [{:optional, [], Elixir}, []]}
  defp default_arg(arg_name), do: quote(do: unquote(defident(arg_name)) \\ [])
end
