defmodule TelegexTest do
  use ExUnit.Case
  doctest Telegex

  test "greets the world" do
    assert Telegex.hello() == :world
  end
end
