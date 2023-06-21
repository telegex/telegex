defmodule Telegex.TypeTest do
  use ExUnit.Case

  test "attachment fields in struct type" do
    assert Telegex.Type.InputMediaPhoto.__attachments__() == [:media]
    assert Telegex.Type.InputMediaVideo.__attachments__() == [:media, :thumbnail]
    assert Telegex.Type.InputMediaAnimation.__attachments__() == [:media, :thumbnail]
    assert Telegex.Type.InputMediaAudio.__attachments__() == [:media, :thumbnail]
    assert Telegex.Type.InputMediaDocument.__attachments__() == [:media, :thumbnail]
  end
end
