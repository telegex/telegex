defmodule Telegex.HelperTest do
  use ExUnit.Case

  import ExUnit.CaptureLog
  import Telegex.Helper

  alias Telegex.TypeDefiner.{ArrayType, UnionType}
  alias Telegex.Type.{Update, Message, ChatMemberOwner}

  test "most_repeated_fields_type/2" do
    # 测试找出与数据有最多字段重复的具体类型
    map = %{
      type: "audio",
      id: 1_231_032_181,
      audio_file_id: "CQACAgQAAxkBAAIBXV6ZQZ3Z33Z3Z3Z3Z3Z3Z3Z3Z3Z3AAEcBA",
      caption: "test audio",
      parse_mode: "MarkdownV2",
      caption_entities: []
    }

    assert most_repeated_fields_type(map, [
             Telegex.Type.InlineQueryResultCachedAudio,
             Telegex.Type.InlineQueryResultAudio
           ]) == {0, Telegex.Type.InlineQueryResultCachedAudio}

    map = %{
      message_id: 1001,
      date: 101,
      text: "Hello!"
    }

    assert most_repeated_fields_type(map, [:boolean, Telegex.Type.Message]) ==
             {0, Telegex.Type.Message}
  end

  test "typedmap/2" do
    # 测试基本类型
    assert typedmap(true, :boolean) == true
    assert typedmap(999, :integer) == 999
    assert typedmap("Hello", :string) == "Hello"
    assert typedmap(1.25, :float) == 1.25

    # 测试数组类型
    assert typedmap([%{update_id: 1}, %{update_id: 2}], %ArrayType{elem_type: Update}) ==
             [
               %Update{update_id: 1},
               %Update{update_id: 2}
             ]

    # 测试联合类型（无基础相关性的联合类型）
    typed_data =
      typedmap(
        %{
          message_id: 1001,
          date: 101,
          text: "Hello!"
        },
        %UnionType{types: [:boolean, Message]}
      )

    assert match?(%Message{}, typed_data)

    assert typedmap(true, %UnionType{types: [:boolean, Message]}) == true

    typed_data =
      typedmap(
        %{
          status: "creator",
          is_anonymous: false,
          user: %{id: 1001, is_bot: true, first_name: "Bob"}
        },
        Telegex.Type.ChatMember
      )

    # 测试联合类型模块（有基础相关性的联合类型）
    assert match?(%ChatMemberOwner{}, typed_data)
  end

  test "warning" do
    # 测试最终类型的字段列表不能完全抵消返回的数据的字段列表
    fun = fn ->
      map = %{
        unkown_field: :unkown_value,
        message_id: 1001,
        date: 101,
        text: "Hello!"
      }

      typed_data = typedmap(map, %UnionType{types: [:boolean, Telegex.Type.Message]})

      assert match?(%Message{}, typed_data)
    end

    assert capture_log(fun) =~
             "this may be caused by changes to the Telegram Bot API or a bug, the final type's field list did not fully offset the field list of the data: #{inspect(type: Telegex.Type.Message, left_fields_count: 1)}"

    # 测试未知的指向最终类型的值
    fun = fn ->
      typed_data =
        typedmap(
          %{
            status: "unkown_value",
            is_anonymous: false,
            user: %{id: 1001, is_bot: true, first_name: "Bob"}
          },
          Telegex.Type.ChatMember
        )

      assert match?(%{}, typed_data)
    end

    assert capture_log(fun) =~
             "this may be caused by changes to the Telegram Bot API or a bug, pointing to an unknown type: #{inspect(field: :status, value: "unkown_value")}"
  end
end
