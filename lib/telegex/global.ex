defmodule Telegex.Global do
  @moduledoc false

  @spec base_url :: String.t()
  def base_url, do: Application.get_env(:telegex, :base_url, "https://api.telegram.org/bot")
end
