defmodule Telegex.Hook.Server do
  @moduledoc false

  use Plug.Router

  alias Telegex.Helper

  plug :match
  plug Plug.Parsers, parsers: [:json], json_decoder: {Jason, :decode!, [[keys: :atoms]]}
  plug :dispatch

  @impl true
  def init(%{on_update: on_update}) do
    %{on_update: on_update}
  end

  @impl true
  def call(conn, %{on_update: on_update} = args) do
    conn
    |> put_private(:on_update, on_update)
    |> super(args)
  end

  post "/updates_hook" do
    update = Helper.typedmap(conn.body_params, Telegex.Type.Update)

    on_update = conn.private[:on_update]

    try do
      on_update.(update)
    rescue
      _ -> :error
    end

    resp_json(conn, %{})
  end

  match _ do
    send_resp(conn, 200, "")
  end

  defp resp_json(conn, map) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(map))
  end
end
