defmodule EchoBotTest do
  use ExUnit.Case
  doctest EchoBot

  test "greets the world" do
    assert EchoBot.hello() == :world
  end
end
