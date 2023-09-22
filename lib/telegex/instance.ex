defmodule Telegex.Instance do
  @moduledoc """
  Independent configuration and information for bot instances.

  **Note: This module is not officially implemented at the moment, reserved for multi-instance support.**
  """

  use GenServer

  require Logger

  def start_link(_) do
    GenServer.start_link(__MODULE__, %{me: nil}, name: __MODULE__)
  end

  @spec token() :: String.t()
  def token, do: Telegex.Global.token()

  @impl true
  def init(state) do
    {:ok, state}
  end

  @spec get_me :: {:ok, Telegex.Type.User.t()} | {:error, Telegex.Type.error()}
  def get_me do
    GenServer.call(__MODULE__, :get_me, :infinity)
  end

  @spec me :: Telegex.Type.User.t()
  def me do
    GenServer.call(__MODULE__, :me)
  end

  @impl true
  def handle_call(:get_me, _from, state) do
    r = Telegex.get_me()

    case r do
      {:ok, bot} ->
        {:reply, r, %{state | me: bot}}

      {:error, _} ->
        {:reply, r, state}
    end
  end

  @impl true
  def handle_call(:me, _from, %{me: bot} = state) do
    {:reply, bot, state}
  end
end
