if Mix.env() in [:dev, :test] do
  defmodule Mix.Tasks.Gen.DocJson do
    @moduledoc false

    use TypedStruct

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
    @skip_sub_sections []

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

      types_section = Enum.find(doc_sections, &(&1.title == "Available types"))
      updates_section = Enum.find(doc_sections, &(&1.title == "Getting updates"))
      inline_section = Enum.find(doc_sections, &(&1.title == "Inline mode"))
      methods_section = Enum.find(doc_sections, &(&1.title == "Available methods"))

      types_sub_sections = parse_sub_sections(types_section, doc_nodes)
      updates_sub_sections = parse_sub_sections(updates_section, doc_nodes)
      inline_sub_sections = parse_sub_sections(inline_section, doc_nodes)

      updates_types =
        updates_sub_sections
        # 排除非类型的子章节
        |> Enum.filter(&(&1.comment == :type))
        |> Enum.map(fn s -> parse_type(s, doc_nodes) end)

      types =
        types_sub_sections
        # 排除非类型的子章节
        |> Enum.filter(&(&1.comment == :type))
        |> Enum.map(fn s -> parse_type(s, doc_nodes) end)

      stickers_types =
        doc_sections
        |> Enum.find(&(&1.title == "Stickers"))
        |> parse_sub_sections(doc_nodes)
        # 排除非类型的子章节
        |> Enum.filter(&(&1.comment == :type))
        |> Enum.map(fn s -> parse_type(s, doc_nodes) end)

      inline_types =
        inline_sub_sections
        # 排除非类型的子章节
        |> Enum.filter(&(&1.comment == :type))
        |> Enum.map(fn s -> parse_type(s, doc_nodes) end)

      payments_types =
        doc_sections
        |> Enum.find(&(&1.title == "Payments"))
        |> parse_sub_sections(doc_nodes)
        # 排除非类型的子章节
        |> Enum.filter(&(&1.comment == :type))
        |> Enum.map(fn s -> parse_type(s, doc_nodes) end)

      passport_types =
        doc_sections
        |> Enum.find(&(&1.title == "Telegram Passport"))
        |> parse_sub_sections(doc_nodes)
        # 排除非类型的子章节
        |> Enum.filter(&(&1.comment == :type))
        |> Enum.map(fn s -> parse_type(s, doc_nodes) end)

      game_types =
        doc_sections
        |> Enum.find(&(&1.title == "Games"))
        |> parse_sub_sections(doc_nodes)
        # 排除非类型的子章节
        |> Enum.filter(&(&1.comment == :type))
        |> Enum.map(fn s -> parse_type(s, doc_nodes) end)

      union_types =
        types_sub_sections
        # 排除非联合类型的子章节
        |> Enum.filter(&(&1.comment == :union_type))
        |> Enum.map(fn s -> parse_union_type(s, doc_nodes) end)

      inline_union_types =
        inline_sub_sections
        # 排除非联合类型的子章节
        |> Enum.filter(&(&1.comment == :union_type))
        |> Enum.map(fn s -> parse_union_type(s, doc_nodes) end)

      updates_methods =
        updates_sub_sections
        # 排除非方法的子章节
        |> Enum.filter(&(&1.comment == :method))
        |> Enum.map(fn s -> parse_method(s, doc_nodes) end)

      methods =
        methods_section
        |> parse_sub_sections(doc_nodes)
        # 排除非方法的子章节
        |> Enum.filter(&(&1.comment == :method))
        |> Enum.map(fn s -> parse_method(s, doc_nodes) end)

      all_types =
        updates_types ++
          types ++
          stickers_types ++ inline_types ++ payments_types ++ passport_types ++ game_types

      all_union_types = union_types ++ inline_union_types

      all_methods = updates_methods ++ methods

      doc_map = %{types: all_types, union_types: all_union_types, methods: all_methods}

      json = Jason.encode!(doc_map, pretty: true)

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

        sub = %{sub | comment: sub_comment(sub, doc_nodes)}

        validate_section(section.title, i, sub)

        sub
      end

      doc_nodes
      |> Enum.slice(section.node_beginning..section.node_end)
      |> parse_sections("h4")
      |> Enum.with_index()
      |> Enum.map(build_sub_section)
    end

    defp sub_comment(sub, doc_nodes) do
      sub_nodes = Enum.slice(doc_nodes, sub.node_beginning..sub.node_end)

      skip? = Enum.member?(@skip_sub_sections, sub.title)

      # 无效的类型名称，如 `Inline mode objects`，它通常不是直接的类型子章节
      invalid_type_name = !skip? && String.contains?(sub.title, " ")

      # 是否大写开头
      is_titlecase = is_titlecase?(sub.title)

      # 是否包含参数
      is_contains_parameter = is_contains_parameter(sub_nodes)

      is_contains_table =
        !skip? &&
          !invalid_type_name &&
          !(sub_nodes |> Floki.find("table") |> Enum.empty?())

      # 注意，是否存在 table 并不能表示是否为类型，因为当前存在一些没有字段的类型。
      # 通过 ul > li > a 标签和是否包含表格共同判断是否为联合类型
      is_unino_type =
        !skip? && is_titlecase &&
          !is_contains_parameter &&
          !invalid_type_name &&
          !is_contains_table &&
          !(sub_nodes |> Floki.find("ul > li > a") |> Enum.empty?())

      is_method =
        !skip? && !is_unino_type &&
          !invalid_type_name &&
          !is_titlecase

      cond do
        skip? ->
          :skip

        is_unino_type ->
          :union_type

        invalid_type_name ->
          :invalid_type_name

        is_method ->
          :method

        true ->
          :type
      end
    end

    defp is_titlecase?(str) do
      first_char = String.first(str)
      capitalized_char = String.upcase(first_char)
      first_char == capitalized_char
    end

    defp is_contains_parameter(nodes) do
      case Floki.find(nodes, "table > thead > tr > th") do
        [] ->
          false

        [first_th | _] ->
          first_th
          |> Floki.text()
          |> Kernel.==("Parameter")
      end
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

    defp parse_type(section, doc_nodes) do
      nodes = Enum.slice(doc_nodes, section.node_beginning..section.node_end)

      description = nodes |> Floki.find("p") |> hd() |> Floki.text()

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

      description = nodes |> Floki.find("p") |> hd() |> Floki.text()

      types = nodes |> Floki.find("ul > li") |> Enum.map(&Floki.text/1)

      %{name: section.title, description: description, types: types}
    end

    defp parse_method(section, doc_nodes) do
      nodes = Enum.slice(doc_nodes, section.node_beginning..section.node_end)

      description = nodes |> Floki.find("p") |> hd() |> Floki.text()

      %{
        name: section.title,
        description: description,
        parameters: parse_method_parameters(nodes),
        result_type: parse_method_returns(description)
      }
    end

    defp parse_method_parameters(method_nodes) do
      tr_nodes = Floki.find(method_nodes, "table > tbody > tr")

      tr_parse_run = fn n ->
        [name, type, required_text, description] =
          n |> Floki.find("td") |> Enum.map(&Floki.text/1)

        required =
          case required_text do
            "Yes" ->
              true

            "Optional" ->
              false

            other ->
              raise "Invalid required text: #{inspect(other)}"
          end

        %{
          name: name,
          type: type,
          required: required,
          description: description
        }
      end

      Enum.map(tr_nodes, tr_parse_run)
    end

    @result_type_re_list [
      ~r/Returns an (Array of \S+) objects/,
      ~r/On success, a (\S+) object is returned/,
      ~r/(array of \S+) .+is returned/,
      ~r/ (\S+) is returned/,
      ~r/of a (\S+) object.$/,
      ~r/Returns (\S+) on success/,
      ~r/Returns the (\S+) of/,
      ~r/Returns.+as (\S+) object/,
      ~r/Returns.+as a (\S+) object/,
      ~r/Returns.+as (\S+) on success/,
      ~r/Returns a (\S+) object/,
      ~r/returns a (\S+) object/
    ]

    defp parse_method_returns(description, i \\ 0) do
      re = Enum.at(@result_type_re_list, i)

      if re == nil do
        # 缺少结果类型
        raise "Missing result type: #{inspect(description: description)}"
      else
        case Regex.scan(re, description) do
          [[_, result_type]] ->
            :ok = valide_returns(result_type, description)
            result_type

          _ ->
            parse_method_returns(description, i + 1)
        end
      end
    end

    defp valide_returns(<<"array of " <> type::binary>>, description),
      do: validate_type_titlecase(type, description)

    defp valide_returns(<<"Array of " <> type::binary>>, description),
      do: validate_type_titlecase(type, description)

    defp valide_returns(type, description), do: validate_type_titlecase(type, description)

    defp validate_type_titlecase(type, description) do
      if is_titlecase?(type) do
        :ok
      else
        # 类型应该以大写开头
        raise "Type should be titlecase: #{inspect(type: type, description: description)}"
      end
    end
  end
end
