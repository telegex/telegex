defmodule EctoBotTest do
  use ExUnit.Case
  doctest EctoBot

  test "greets the world" do
    assert EctoBot.hello() == :world
  end
end
