defmodule Telegex.Caller.Adapter.FinchTest do
  use ExUnit.Case

  import Telegex.Caller.Adapter.Finch

  test "attach_param/4" do
    input_media = %Telegex.Type.InputMediaDocument{
      type: "document",
      media: "mix.exs",
      thumbnail: "mix.lock"
    }

    params = [media: [input_media]]

    {_multipart, params} = attach_param(:media, [input_media], Multipart.new(), params)

    assert params == [
             media: [
               %Telegex.Type.InputMediaDocument{
                 type: "document",
                 media: "attach://mix.exs",
                 thumbnail: "attach://mix.lock"
               }
             ]
           ]
  end
end
