defmodule Mix.Tasks.Gen.Code do
  @moduledoc false

  require Mix.Generator

  alias Telegex.TypeDefiner.{Discriminator, ArrayType, UnionType}

  @base_module Telegex.Type

  def run(_args) do
    doc_json = Jason.decode!(File.read!("priv/bot_api_doc.json"), keys: :atoms)

    type_args =
      Enum.map(doc_json.types, fn type ->
        %{type | fields: build_fileds_string(type.fields)}
      end)

    union_types =
      Enum.map(doc_json.union_types, fn ut ->
        %{
          name: ut.name,
          description: ut.description,
          types: build_utypes_string(ut.types),
          discriminant: build_discriminant_string(ut.types, doc_json.types)
        }
      end)

    apis =
      Enum.map(doc_json.methods, fn a ->
        %{
          name: a.name,
          description: a.description,
          parameters: build_api_paramaters_string(a.parameters),
          result_type: build_ftype_string(a.result_type)
        }
      end)

    Mix.Generator.copy_template(
      "priv/type_template.ex.eex",
      "lib/telegex/type.ex",
      [union_types: union_types, type_args: type_args],
      force: true
    )

    Mix.Generator.copy_template(
      "priv/api_template.ex.eex",
      "lib/telegex.ex",
      [apis: apis],
      force: true
    )
  end

  def build_utypes_string(types) do
    types
    |> Enum.map(&build_ftype/1)
    |> Macro.escape()
    |> Macro.to_string()
  end

  def build_fileds_string(fields) do
    Enum.map(fields, fn f ->
      %{
        name: String.to_atom(f.name),
        type: build_ftype(f.type),
        optional: f.optional,
        description: f.description
      }
    end)
    |> Macro.escape()
    |> Macro.to_string()
  end

  def build_ftype("String") do
    :string
  end

  def build_ftype("Integer") do
    :integer
  end

  def build_ftype("Int") do
    :integer
  end

  def build_ftype("Float") do
    :float
  end

  def build_ftype("Float number") do
    :float
  end

  def build_ftype("Boolean") do
    :boolean
  end

  def build_ftype("True") do
    :boolean
  end

  def build_ftype(<<"Array of " <> type::binary>> = full_type) do
    if String.contains?(type, ",") && String.contains?(type, "and") do
      # 此处是为了转换 `media` 字段的类型，它是联合类型，且每一种类型都是数组，只是数组元素类型不同。文档中的描述是：
      # `Array of InputMediaAudio, InputMediaDocument, InputMediaPhoto and InputMediaVideo`
      # 将其转换为能被联合类型解析的字符串，如下：
      # `Array of InputMediaAudio or Array of InputMediaDocument or Array of InputMediaPhoto or Array of InputMediaVideo`

      full_type =
        full_type
        |> String.replace(",", " or Array of")
        |> String.replace("and", "or Array of")

      %UnionType{types: build_union_types(full_type)}
    else
      %ArrayType{elem_type: build_ftype(type)}
    end
  end

  # 部分方法文档的描述处使用了小写开头的 array of
  def build_ftype(<<"array of " <> type::binary>>) do
    %ArrayType{elem_type: build_ftype(type)}
  end

  # 方法 sendMediaGroup 的文档将 `Messages` 引用为 `Message`
  def build_ftype("Messages") do
    build_ftype("Message")
  end

  def build_ftype(other_type) do
    if String.contains?(other_type, " or ") do
      %UnionType{types: build_union_types(other_type)}
    else
      String.to_atom("#{@base_module}.#{other_type}")
    end
  end

  defp build_ftype_string(type) do
    type
    |> build_ftype()
    |> Macro.escape()
    |> Macro.to_string()
  end

  def build_union_types(union_types_text) do
    union_types_text |> String.split(" or ") |> Enum.map(&build_ftype/1)
  end

  defp build_api_paramaters_string(parameters) do
    Enum.map(parameters, fn p ->
      %{
        name: String.to_atom(p.name),
        type: build_api_ptype(p.type),
        required: p.required,
        description: p.description
      }
    end)
    |> Macro.escape()
    |> Macro.to_string()
  end

  defp build_api_ptype(type_string) do
    build_ftype(type_string)
  end

  @spec build_discriminant_string(list, list) :: String.t()
  defp build_discriminant_string(union_types, types) do
    discriminant =
      Enum.reduce(union_types, %Discriminator{mapping: %{}}, fn tname, discriminant ->
        case find_type(tname, types) do
          %{fixed: fixed} ->
            mapping = discriminant.mapping

            pointing_types = Map.get(mapping, fixed.value, []) ++ [build_ftype(tname)]
            mapping = Map.put(mapping, fixed.value, pointing_types)

            %{discriminant | field: String.to_atom(fixed.field), mapping: mapping}

          _ ->
            discriminant
        end
      end)

    if discriminant.field do
      [discriminant: Map.from_struct(discriminant)]
    else
      []
    end
    |> Macro.escape()
    |> Macro.to_string()
  end

  defp find_type(tname, types) do
    Enum.find(types, fn %{name: name} -> name == tname end)
  end
end
