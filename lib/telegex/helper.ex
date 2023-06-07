defmodule Telegex.Helper do
  @moduledoc "Some helper functions."

  alias Telegex.TypeDefiner.{ArrayType, UnionType}

  def typedmap(nil, _), do: nil

  def typedmap(map, %ArrayType{elem_type: type}) do
    Enum.map(map, fn item -> typedmap(item, type) end)
  end

  # 暂时不处理联合类型转换
  # 联合类型需要根据关键内容或结构来确定具体类型
  def typedmap(map, %UnionType{types: _types}) do
    map
  end

  def typedmap(map, type) when type in [:integer, :string, :boolean, :float] do
    map
  end

  def typedmap(map, type) do
    references = type.__references__()

    map =
      Enum.reduce(references, map, fn {name, type}, map ->
        Map.put(map, name, typedmap(map[name], type))
      end)

    struct(type, map)
  end
end
