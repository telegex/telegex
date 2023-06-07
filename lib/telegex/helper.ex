defmodule Telegex.Helper do
  @moduledoc "Some helper functions."

  alias Telegex.TypeDefiner.{ArrayType, UnionType}

  def typedmap(nil, _), do: nil

  def typedmap(map, %ArrayType{elem_type: type}) do
    Enum.map(map, fn item -> typedmap(item, type) end)
  end

  # 暂时不处理联合类型返回值转换，因为联合类型需要根据关键内容或结构来确定具体类型。
  # 一些联合类型返回值的例子：
  # - 更新消息相关的方法会返回 True 或 Message
  # - getChatAdministrators 方法或返回 ChatMember 的列表，而 ChatMember 自身就是联合类型
  def typedmap(map, %UnionType{types: _types}) do
    map
  end

  def typedmap(map, type) when type in [:integer, :string, :boolean, :float] do
    map
  end

  def typedmap(map, type) do
    _typedmap(type.__meta__(), map, type)
  end

  # 类型模块为联合类型，直接返回原始 map
  defp _typedmap(:union, map, _type) do
    map
  end

  defp _typedmap(:type, map, type) do
    references = type.__references__()

    map =
      Enum.reduce(references, map, fn {name, type}, map ->
        Map.put(map, name, typedmap(map[name], type))
      end)

    struct(type, map)
  end
end
