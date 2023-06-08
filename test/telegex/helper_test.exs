defmodule Telegex.HelperTest do
  use ExUnit.Case

  import Telegex.Helper

  test "most_repeated_fields_type/2" do
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
end
