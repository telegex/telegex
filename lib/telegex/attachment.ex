defmodule Telegex.Attachment do
  @moduledoc false

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

  @spec supplement_attach_syntax_support(%{String.t() => [Telegex.Attachment.t()]}) :: %{
          String.t() => [Telegex.Attachment.t()]
        }
  # 根据 `@support_attach_syntax_mapping` 属性的值，修正所有的 `supports_attach_syntax` 字段。
  # 此方法被 `Telegex` 模块调用，为 `@include_attachment_methods_mapping` 属性的值补充 attach 语法支持情况。
  @doc false
  def supplement_attach_syntax_support(attachment_mapping) do
    supplement_fun = fn {method, supports_fields}, mapping ->
      if attachments = attachment_mapping[method] do
        attachments = attachments |> Enum.map(fix_supports_attach_syntax(supports_fields))

        mapping |> Map.put(method, attachments)
      else
        mapping
      end
    end

    @support_attach_syntax_mapping
    |> Enum.reduce(attachment_mapping, supplement_fun)
  end

  @spec fix_supports_attach_syntax([atom()]) :: (Attachment.t() -> Attachment.t())
  @doc """
  生成一个修正 `Attachment` 中的 `supports_attach_syntax` 字段的函数。
  需要提供支持 attach 语法的字段列表。
  """
  def fix_supports_attach_syntax(supports_fields) do
    fn %{field: field} = attachment ->
      if Enum.member?(supports_fields, field),
        do: Map.put(attachment, :supports_attach_syntax, true),
        else: attachment
    end
  end

  @doc false
  def __attach_syntax_supports__ do
    @support_attach_syntax_mapping
  end
end
