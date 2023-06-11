defmodule Telegex.Tools do
  @moduledoc "Some utility functions."

  @type markdown_from :: :text | :inline_link | :pre | :code | :pre_or_code

  @spec safe_html(String.t()) :: String.t()
  def safe_html(html) do
    html
    |> String.replace("&", "&amp;")
    |> String.replace("<", "&lt;")
    |> String.replace(">", "&gt;")
    |> String.replace("\"", "&quot;")
  end

  @doc """
  Generate safe Markdown content.

  ## Examples
      iex> Telegex.Tools.safe_markdown("'_', '*', '[', ']', '(', ')', '~', '`', '>', '#', '+', '-', '=', '|', '{', '}', '.', '!'")
      ~S"'\\_', '\\*', '\\[', '\\]', '\\(', '\\)', '\\~', '\\`', '\\>', '\\#', '\\+', '\\-', '\\=', '\\|', '\\{', '\\}', '\\.', '\\!'"
      iex> Telegex.Tools.safe_markdown(~S{https://t.me\\)}, :inline_link)
      ~S|https://t.me\\\\\\)|
      iex> Telegex.Tools.safe_markdown(~S{IO.puts `Hello`}, :pre_or_code)
      ~S|IO.puts \\`Hello\\`|
  """
  @spec safe_markdown(String.t(), markdown_from) :: String.t()
  def safe_markdown(conetnt, from \\ :text),
    do: _safe_markdown(conetnt, from)

  defp _safe_markdown(conetnt, :text) do
    String.replace(
      conetnt,
      ~r/(\_|\*|\[|\]|\(|\)|\~|\`|\>|\#|\+|\-|\=|\||\{|\}|\.|\!)/,
      "\\\\\\g{1}"
    )
  end

  defp _safe_markdown(conetnt, :inline_link) do
    conetnt |> String.replace("\\", "\\\\") |> String.replace(")", "\\)")
  end

  defp _safe_markdown(conetnt, :pre), do: _safe_markdown(conetnt, :pre_or_code)
  defp _safe_markdown(conetnt, :code), do: _safe_markdown(conetnt, :pre_or_code)

  defp _safe_markdown(conetnt, :pre_or_code) do
    conetnt |> String.replace("\\", "\\\\") |> String.replace("`", "\\`")
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
