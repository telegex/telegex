defmodule Telegex.Config do
  @moduledoc false

  @default_timeout 1000 * 15
  @default_recv_timeout 1000 * 10

  @spec token :: String.t() | nil
  def token, do: get(:token)

  @spec httposion_options :: [timeout: integer(), recv_timeout: integer()]
  def httposion_options,
    do: [
      timeout: get(:timeout, @default_timeout),
      recv_timeout: get(:recv_timeout, @default_recv_timeout),
      proxy: get(:proxy),
      proxy_auth: get(:proxy_auth)
    ]

  @spec get(atom(), any()) :: any()
  defp get(key, default \\ nil) do
    Application.get_env(:telegex, key, default)
  end
end
