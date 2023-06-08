defmodule Telegex.Instance do
  @moduledoc false

  @spec token() :: String.t()
  def token, do: Application.get_env(:telegex, :token)
end
