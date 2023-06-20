defmodule Telegex.Helper do
  @moduledoc "Some helper functions."

  @type datatype :: Telegex.TypeDefiner.field_type()

  alias Telegex.TypeDefiner.{ArrayType, UnionType}

  require Logger

  @doc """
  Convert the map to a struct with type information, which is used in the internal implementation of this function.
  """
  @spec typedmap(any, datatype) :: any
  def typedmap(nil, _), do: nil

  def typedmap(map, %ArrayType{elem_type: type}) do
    Enum.map(map, fn item -> typedmap(item, type) end)
  end

  # 例子：更新消息相关的方法会返回 True 或 Message
  def typedmap(map, %UnionType{types: types}) do
    if is_map(map) do
      # 一个值指向多个可能的具体类型且没有字段值指向类型，此处转换为和 map 有最多重复字段的类型
      {_, type} = r = most_repeated_fields_type(map, types)

      conditional_warning(r)

      typedmap(map, type)
    else
      map
    end
  end

  def typedmap(map, type) when type in [:integer, :string, :boolean, :float] do
    map
  end

  def typedmap(map, type) do
    _typedmap(type.__meta__(), map, type)
  end

  # 联合类型根据 discriminant 中字段值执行转换
  defp _typedmap(:union, map, type) do
    case type.__discriminant__() do
      nil ->
        map

      discriminant ->
        value = map[discriminant.field]

        case discriminant.mapping[value] do
          nil ->
            Logger.warning(
              "this may be caused by changes to the Telegram Bot API or a bug, pointing to an unknown type: #{inspect(field: discriminant.field, value: value)}"
            )

            map

          [type] ->
            # 一个值只指向一个具体类型
            typedmap(map, type)

          types ->
            # 一个值指向多个可能的具体类型，此处转换为和 map 有最多重复字段的类型
            {_, type} = r = most_repeated_fields_type(map, types)

            conditional_warning(r)

            typedmap(map, type)
        end
    end
  end

  defp _typedmap(:type, map, type) do
    references = type.__references__()

    map =
      Enum.reduce(references, map, fn {name, type}, map ->
        Map.put(map, name, typedmap(map[name], type))
      end)

    struct(type, map)
  end

  @doc false
  @spec most_repeated_fields_type(map, [module]) :: {non_neg_integer, module}
  def most_repeated_fields_type(map, types) do
    map_keys = Map.keys(map)

    Enum.reduce_while(types, {999, nil}, fn t, {rleft, rt} ->
      # 剩余个数，越小越有可能是最终类型。理论上剩余个数应该为 0，但 API 变动的适配总不会那么即时（或者旧库不兼容 API 变化）。
      left = keys_left_count(map_keys, t)

      cond do
        left == 0 ->
          # 如果一个类型的字段在 map 都出现了（字段列表相减后为 0），那么这个类型就是最终的类型
          {:halt, {left, t}}

        left < rleft ->
          # 如果一个类型的字段在 map 尽可能都出现了，那么这个类型可能是最终的类型，更新返回值
          {:cont, {left, t}}

        true ->
          {:cont, {rleft, rt}}
      end
    end)
  end

  defp keys_left_count(_keys, type) when type in [:integer, :string, :boolean, :float] do
    # 当为基础类型时，直接返回尽可能大的安全值
    999
  end

  defp keys_left_count(keys, type) do
    length(keys -- type.__keys__())
  end

  defp conditional_warning({left_count, type}) when left_count > 0 do
    Logger.warning(
      "this may be caused by changes to the Telegram Bot API or a bug, the final type's field list did not fully offset the field list of the data: #{inspect(type: type, left_fields_count: left_count)}"
    )
  end

  defp conditional_warning(_), do: nil
end
