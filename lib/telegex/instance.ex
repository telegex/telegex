defmodule Telegex.Instance do
  @moduledoc """
  Independent configuration and information for bot instances.

  **Note: This module is not officially implemented at the moment, reserved for multi-instance support.**
  """

  use GenServer

  require Logger

  use TypedStruct

  typedstruct module: State do
    field :bot, Telegex.Type.User.t()
  end

  def start_link(_) do
    GenServer.start_link(__MODULE__, %State{}, name: __MODULE__)
  end

  @spec token() :: String.t()
  def token, do: Telegex.Global.token()

  @impl true
  def init(state) do
    {:ok, state}
  end

  @doc """
  Call the `Telegex.get_me/0` function to get and cache the bot's own user information.
  """
  @spec cache_me :: {:ok, Telegex.Type.User.t()} | {:error, Telegex.Type.error()}
  def cache_me do
    GenServer.call(__MODULE__, :cache_me, :infinity)
  end

  @doc """
  Call the `Telegex.get_me/0` function to get and cache the bot's own user information.
  """
  @deprecated "Use `cache_me/0` instead."
  @spec fetch_me :: {:ok, Telegex.Type.User.t()} | {:error, Telegex.Type.error()}
  def fetch_me do
    cache_me()
  end

  @doc """
  Get the cached bot's own user information.
  """
  @spec bot :: Telegex.Type.User.t()
  def bot do
    GenServer.call(__MODULE__, :bot)
  end

  @impl true
  def handle_call(:cache_me, _from, state) do
    case Telegex.get_me() do
      {:ok, bot} = r ->
        {:reply, r, %{state | bot: bot}}

      {:error, _} = r ->
        {:reply, r, state}
    end
  end

  @impl true
  def handle_call(:bot, _from, %{bot: bot} = state) do
    {:reply, bot, state}
  end
end
