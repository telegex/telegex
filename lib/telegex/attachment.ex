defmodule Telegex.Attachment do
  use TypedStruct

  typedstruct do
    field :field, atom() | [atom()], enforce: true
    field :supports_attach_syntax, boolean(), default: false
  end

  # 所有方法中支持 attach 语法的附件
  @support_attach_syntax_mapping %{
    "sendAnimation" => [:thumb],
    "sendAudio" => [:thumb],
    "sendDocument" => [:thumb],
    "sendVideo" => [:thumb],
    "sendVideoNote" => [:thumb]
  }

  # 根据 `@support_attach_syntax_mapping` 属性的值，修正所有的 `supports_attach_syntax` 字段。
  # 此方法被 `Telegex` 模块调用，为 `@include_attachment_methods_mapping` 属性的值补充 attach 语法支持情况。
  @doc false
  def supplement_attach_syntax_support(attachment_mapping) do
    @support_attach_syntax_mapping
    |> Enum.reduce(attachment_mapping, fn {method, supports_fields}, mapping ->
      if attachments = attachment_mapping[method] do
        attachments =
          attachments
          |> Enum.map(fn %{field: field} = attachment ->
            if Enum.member?(supports_fields, field),
              do: Map.put(attachment, :supports_attach_syntax, true),
              else: attachment
          end)

        mapping |> Map.put(method, attachments)
      else
        mapping
      end
    end)
  end

  @doc false
  def __attach_syntax_supports__ do
    @support_attach_syntax_mapping
  end
end
