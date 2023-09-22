defmodule Telegex.Global do
  @moduledoc false

  @spec api_base_url :: String.t()
  def api_base_url,
    do: Application.get_env(:telegex, :api_base_url, "https://api.telegram.org/bot")
end
