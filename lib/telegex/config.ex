defmodule Telegex.Config do
  @moduledoc false

  @spec token :: String.t() | nil
  def token, do: get(:token)

  @spec get(atom(), any()) :: any()
  defp get(key, default \\ nil) do
    Application.get_env(:telegex, key, default)
  end
end
