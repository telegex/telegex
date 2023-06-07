defmodule Telegex.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  alias Telegex.Caller

  @impl true
  def start(_type, _args) do
    finch_serve? = Caller.impl() == Caller.FinchAdapter

    children =
      [
        # Starts a worker by calling: Telegex.Worker.start_link(arg)
        # {Telegex.Worker, arg}
      ]
      |> serve_children({Finch, name: Telegex.Finch}, finch_serve?)

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Telegex.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp serve_children(children, child, server?) do
    children ++
      if server? do
        [child]
      else
        []
      end
  end
end
