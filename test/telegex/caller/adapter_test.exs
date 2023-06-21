defmodule Telegex.Caller.AdapterTest do
  use ExUnit.Case

  import Telegex.Caller

  setup do
    on_exit(fn ->
      # 还原 `Caller` 配置
      Application.put_env(:telegex, :caller_adapter, nil)
    end)
  end

  test "Adapter.HTTPoison ok" do
    Application.put_env(:telegex, :caller_adapter, HTTPoison)

    r = call("getMe")

    assert match?({:ok, %{is_bot: true}}, r)
  end

  test "Adapter.HTTPoison error" do
    Application.put_env(:telegex, :caller_adapter, {HTTPoison, [recv_timeout: 1]})

    r = call("getMe")

    assert match?({:error, %Telegex.RequestError{reason: :timeout}}, r)
  end

  test "Adapter.Finch ok" do
    Application.put_env(:telegex, :caller_adapter, Finch)

    r = call("getMe")

    assert match?({:ok, %{is_bot: true}}, r)
  end

  test "Adapter.Finch error" do
    # 传递选项测试超时错误
    Application.put_env(:telegex, :caller_adapter, {Finch, [receive_timeout: 1]})

    r = call("getMe")

    assert match?({:error, %Telegex.RequestError{reason: :timeout}}, r)
  end
end
