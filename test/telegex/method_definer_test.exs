defmodule Telegex.MethodDefinerTest do
  use ExUnit.Case

  import Telegex.MethodDefiner

  test "include_attachment?/1" do
    assert include_attachment?(Telegex.Type.InputMediaAudio) == true

    type = %{
      __struct__: Telegex.TypeDefiner.UnionType,
      types: [
        %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.InputMediaAudio},
        %{
          __struct__: Telegex.TypeDefiner.ArrayType,
          elem_type: Telegex.Type.InputMediaDocument
        },
        %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.InputMediaPhoto},
        %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.InputMediaVideo}
      ]
    }

    assert include_attachment?(type) == true
  end
end
