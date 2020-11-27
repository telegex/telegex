defmodule Telegex.Tools do
  @moduledoc false

  @spec safe_html(binary) :: binary
  def safe_html(html) do
    html
    |> String.replace("&", "&amp;")
    |> String.replace("<", "&lt;")
    |> String.replace(">", "&gt;")
    |> String.replace("\"", "&quot;")
  end
end
