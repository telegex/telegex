defmodule Mix.Tasks.Gen.DocJson do
  @moduledoc false

  use TypedStruct

  # TODO: 从其它章节中生成剩余的类型。

  @section_titles [
    "Recent changes",
    "Authorizing your bot",
    "Making requests",
    "Using a Local Bot API Server",
    "Getting updates",
    "Available types",
    "Available methods",
    "Updating messages",
    "Stickers",
    "Inline mode",
    "Payments",
    "Telegram Passport",
    "Games"
  ]

  # 完全不需要且干扰解析的子章节
  @skip_sub_sections [
    "Sending files"
  ]

  typedstruct module: Section do
    field :title, String.t(), enforce: true
    field :node_beginning, enforce: true
    field :node_end, integer
    field :comment, atom
  end

  def run(_args) do
    # TODO: 将网页下载为一个自定义任务。
    # {:ok, _} = Application.ensure_all_started(:req)
    # %{body: body} = Req.get!("https://core.telegram.org/bots/api", @req_options)

    doc_html = File.read!("priv/bots_api_doc.html")

    {:ok, document} = Floki.parse_document(doc_html)

    doc_nodes = Floki.find(document, "#dev_page_content > *")

    doc_sections = parse_sections(doc_nodes, "h3")

    available_types_section = Enum.find(doc_sections, &(&1.title == "Available types"))

    types_sub_sections = parse_sub_sections(available_types_section, doc_nodes)

    types =
      types_sub_sections
      # 排除非类型的子章节
      |> Enum.filter(&(&1.comment == :type))
      |> Enum.map(fn s -> parse_type_section(s, doc_nodes) end)

    union_types =
      types_sub_sections
      # 排除非联合类型的子章节
      |> Enum.filter(&(&1.comment == :union_type))
      |> Enum.map(fn s -> parse_union_type(s, doc_nodes) end)

    json = Jason.encode!(%{types: types, union_types: union_types}, pretty: true)

    Mix.Generator.create_file("priv/bots_api_doc.json", json, force: true)
  end

  defp parse_sections(nodes, tag, i \\ 0, sections \\ []) do
    current = Enum.at(nodes, i)

    case current do
      {^tag, _, _} ->
        node_beginning = i
        title = Floki.text(current)

        # 验证标题是否合法，可以杜绝初级错误
        validate_section(tag, title)

        updated_sections = last_section_end(sections, i - 1)

        sections = updated_sections ++ [%Section{title: title, node_beginning: node_beginning}]

        parse_sections(nodes, tag, i + 1, sections)

      nil ->
        # 结束，返回
        last_section_end(sections, i - 1)

      _ ->
        parse_sections(nodes, tag, i + 1, sections)
    end
  end

  defp validate_section("h3", title) when title in @section_titles do
    :ok
  end

  defp validate_section("h3", title), do: raise("Invalid section title: #{title}")

  defp validate_section(_, _), do: :ok

  @spec last_section_end([Section.t()], integer) :: [Section.t()]
  defp last_section_end([], _i) do
    []
  end

  defp last_section_end(sections, i) do
    last_section = List.last(sections)

    List.replace_at(sections, -1, %{last_section | node_end: i})
  end

  defp parse_sub_sections(section, doc_nodes) do
    build_sub_section = fn {sub, i} ->
      # 偏移节点位置（加上父 sectin 的起始位置）
      sub = %{
        sub
        | node_beginning: sub.node_beginning + section.node_beginning,
          node_end: sub.node_end + section.node_beginning
      }

      sub_nodes = Enum.slice(doc_nodes, sub.node_beginning..sub.node_end)

      skip? = Enum.member?(@skip_sub_sections, sub.title)
      is_contains_table = !(sub_nodes |> Floki.find("table") |> Enum.empty?())

      # 注意，是否存在 table 并不能表示是否为类型，因为当前存在一些没有字段的类型。
      # 通过 ul > li > a 标签和是否包含表格共同判断是否为联合类型
      is_unino_type =
        !(sub_nodes |> Floki.find("ul > li > a") |> Enum.empty?()) &&
          !is_contains_table

      # 无效的类型名称，如 `Inline mode objects`，它通常不是直接的类型子章节
      invalid_tyep_name = String.contains?(sub.title, " ")

      sub =
        cond do
          skip? ->
            %{sub | comment: :skip}

          is_unino_type ->
            %{sub | comment: :union_type}

          invalid_tyep_name ->
            %{sub | comment: :invalid_type_name}

          true ->
            %{sub | comment: :type}
        end

      validate_section(section.title, i, sub)

      sub
    end

    doc_nodes
    |> Enum.slice(section.node_beginning..section.node_end)
    |> parse_sections("h4")
    |> Enum.with_index()
    |> Enum.map(build_sub_section)
  end

  # 检查第一个 type
  def validate_section("Available types", 0, sub) do
    if match?(%{title: "User"}, sub) do
      :ok
    else
      raise("Invalid sub section: #{inspect(index: 0, sub: sub)}")
    end
  end

  # TODO: 检所有的联合类型
  # def validate_section("Available types", _, %{title: title} = sub)  do
  #   if match?(%{title: "User"}, sub) do
  #     :ok
  #   else
  #     raise("Invalid sub section: #{inspect(index: 0, sub: sub)}")
  #   end
  # end

  def validate_section(_, _, _) do
    :ok
  end

  defp parse_type_section(section, doc_nodes) do
    nodes = Enum.slice(doc_nodes, section.node_beginning..section.node_end)

    description = nodes |> Floki.find("p") |> Floki.text()

    %{
      name: section.title,
      description: description,
      fields: parse_type_fields(nodes)
    }
  end

  defp parse_type_fields(type_nodes) do
    tr_nodes = Floki.find(type_nodes, "tbody > tr")

    tr_parse_run = fn n ->
      [name, type, description] = n |> Floki.find("td") |> Enum.map(&Floki.text/1)

      optional = String.starts_with?(description, "Optional")

      %{
        name: name,
        type: type,
        optional: optional,
        description: description
      }
    end

    Enum.map(tr_nodes, tr_parse_run)
  end

  defp parse_union_type(section, doc_nodes) do
    nodes = Enum.slice(doc_nodes, section.node_beginning..section.node_end)

    description = nodes |> Floki.find("p") |> Floki.text()

    types = nodes |> Floki.find("ul > li") |> Enum.map(&Floki.text/1)

    %{name: section.title, description: description, types: types}
  end
end
