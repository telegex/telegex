defmodule Telegex.CallerTest do
  use ExUnit.Case

  import Telegex.Caller

  setup do
    on_exit(fn ->
      # 还原 `Caller` 配置
      Application.put_env(:telegex, Telegex.Caller, [])
    end)
  end

  test "HTTPoisonAdapter ok" do
    Application.put_env(:telegex, Telegex.Caller, adapter: Telegex.Caller.HTTPoisonAdapter)

    r = call("getMe")

    assert match?({:ok, %{is_bot: true}}, r)
  end

  test "HTTPoisonAdapter error" do
    Application.put_env(:telegex, Telegex.Caller,
      adapter: Telegex.Caller.HTTPoisonAdapter,
      options: [recv_timeout: 1]
    )

    r = call("getMe")

    assert match?({:error, %Telegex.RequestError{reason: :timeout}}, r)
  end

  test "ReqAdapter ok" do
    Application.put_env(:telegex, Telegex.Caller, adapter: Telegex.Caller.ReqAdapter)

    r = call("getMe")

    assert match?({:ok, %{is_bot: true}}, r)
  end

  test "ReqAdapter error" do
    # 传递选项测试超时错误
    Application.put_env(:telegex, Telegex.Caller,
      adapter: Telegex.Caller.ReqAdapter,
      options: [connect_options: [timeout: 1]]
    )

    r = call("getMe")

    assert match?({:error, %Telegex.RequestError{reason: :timeout}}, r)
  end

  test "FinchAdapter ok" do
    Application.put_env(:telegex, Telegex.Caller, adapter: Telegex.Caller.FinchAdapter)

    r = call("getMe")

    assert match?({:ok, %{is_bot: true}}, r)
  end

  test "FinchAdapter error" do
    # 传递选项测试超时错误
    Application.put_env(:telegex, Telegex.Caller,
      adapter: Telegex.Caller.FinchAdapter,
      options: [receive_timeout: 1]
    )

    r = call("getMe")

    assert match?({:error, %Telegex.RequestError{reason: :timeout}}, r)
  end
end
