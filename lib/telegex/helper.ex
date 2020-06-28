defmodule Telegex.Helper do
  @moduledoc false

  @spec struct_model(atom(), map()) :: map()
  @doc """
  将 `map` 数据转换为内置的模型结构。
  当前此函数至多支持两层数组的子引用，且忽略存在引用可能是多种类型的字段。
  """
  def struct_model(module, data) when is_atom(module) and is_map(data) do
    references = module.__references__()

    struct_child = fn model_name, v -> :"Elixir.Telegex.Model.#{model_name}".struct(v) end

    structed_children =
      references
      |> Enum.filter(fn {field, _} -> data[field] != nil && data[field] != [] end)
      |> Enum.map(fn {field, type} ->
        value = data[field]

        case type do
          [[model_name]] ->
            {field,
             value
             |> Enum.map(fn sub_array ->
               sub_array |> Enum.map(fn v -> struct_child.(model_name, v) end)
             end)}

          [model_name] ->
            {field, value |> Enum.map(fn v -> struct_child.(model_name, v) end)}

          model_name ->
            {field, struct_child.(model_name, value)}
        end
      end)

    structed = struct(module, data)

    structed_children
    |> Enum.reduce(structed, fn {field, data}, updated_struct ->
      updated_struct |> Map.put(field, data)
    end)
  end

  @doc """
  以下 `struct_response/2` 函数子句负责处理 `Telegex.Request.call/2` 函数调用的返回值。
  """
  def struct_response(result, :any), do: result

  @doc false
  def struct_response({:ok, data}, [model_module]) when is_list(data) do
    {:ok, data |> Enum.map(fn child_data -> struct_model(model_module, child_data) end)}
  end

  @doc false
  def struct_response({:ok, data}, model_module) when is_map(data) do
    {:ok, struct_model(model_module, data)}
  end

  @doc false
  def struct_response({:ok, _data} = result, _), do: result

  @doc false
  def struct_response({:error, _error} = result, _), do: result
end
