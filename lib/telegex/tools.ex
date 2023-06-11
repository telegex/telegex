defmodule Telegex.Tools do
  @moduledoc "Some utility functions."

  @spec safe_html(String.t()) :: binary
  def safe_html(html) do
    html
    |> String.replace("&", "&amp;")
    |> String.replace("<", "&lt;")
    |> String.replace(">", "&gt;")
    |> String.replace("\"", "&quot;")
  end

  @doc """
  Generate a secret token string.

  By default, it generates 16 bytes of data and converts it to a 16-digit hexadecimal string (32 characters long).
  The `bytes_count` parameter can be passed to control the length of the generated string.
  """
  @spec gen_secret_token(non_neg_integer) :: String.t()
  def gen_secret_token(bytes_count \\ 16) do
    bytes_count |> :crypto.strong_rand_bytes() |> Base.encode16()
  end
end
