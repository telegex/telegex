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
end
