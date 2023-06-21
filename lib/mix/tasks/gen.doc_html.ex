if Mix.env() in [:dev, :test] do
  defmodule Mix.Tasks.Gen.DocHtml do
    @moduledoc false

    def run(_args) do
      {:ok, _} = Application.ensure_all_started(:finch)
      Finch.start_link(name: MyFinch)

      {:ok, %{body: body}} =
        :get |> Finch.build("https://core.telegram.org/bots/api") |> Finch.request(MyFinch)

      Mix.Generator.create_file("priv/bot_api_doc.html", body, force: true)
    end
  end
end
