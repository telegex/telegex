if Code.ensure_loaded?(Plug) do
  defmodule Telegex.Hook.Server do
    @moduledoc false

    use Plug.Router

    alias Telegex.Helper

    @secret_token_hander String.downcase("X-Telegram-Bot-Api-Secret-Token")

    if Code.ensure_loaded?(RemoteIp) do
      plug RemoteIp
    end

    plug :match
    plug Plug.Parsers, parsers: [:json], json_decoder: {Jason, :decode!, [[keys: :atoms]]}
    plug :dispatch

    require Logger

    @impl true
    def init(%{handler_module: handler_module, secret_token: secret_token}) do
      %{handler_module: handler_module, secret_token: secret_token}
    end

    @impl true
    def call(conn, %{handler_module: handler_module, secret_token: secret_token} = args) do
      conn
      |> put_private(:handler_module, handler_module)
      |> put_private(:secret_token, secret_token)
      |> super(args)
    end

    post "/updates_hook" do
      r =
        if authorized?(conn) do
          update = Helper.typedmap(conn.body_params, Telegex.Type.Update)

          handler_module = conn.private[:handler_module]

          try do
            handler_module.on_update(update)
          rescue
            e -> handler_module.on_failure(update, {e, __STACKTRACE__})
          end
        else
          # 没有通过 secret_token 验证，响应无意义数据
          Logger.warning("Unauthorized webhook request from `#{remote_ip(conn)}`")

          :unauthorized
        end

      case r do
        {:done, %{payload: payload}} ->
          resp_json(conn, payload)

        _ ->
          resp_json(conn, %{})
      end
    end

    # 验证 secret_token 是否与配置中的一致
    defp authorized?(conn) do
      secret_token =
        case get_req_header(conn, @secret_token_hander) do
          [] -> nil
          [secret_token] -> secret_token
          secret_tokens -> List.last(secret_tokens)
        end

      secret_token == conn.private[:secret_token]
    end

    defp remote_ip(%{remote_ip: ip_tuple} = _conn) when ip_tuple != nil do
      :inet.ntoa(ip_tuple)
    end

    defp remote_ip(_conn) do
      "[not_found_client_ip]"
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
end
