defmodule TelexTest do
  use ExUnit.Case
  doctest Telex

  test "greets the world" do
    assert Telex.hello() == :world
  end
end
