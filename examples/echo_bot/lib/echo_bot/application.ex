defmodule EchoBot.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    updates_fetcher =
      if EchoBot.work_mode() == :webhook do
        EchoBot.HookHandler
      else
        EchoBot.PollingHandler
      end

    children = [
      # Starts a worker by calling: EchoBot.Worker.start_link(arg)
      # {EchoBot.Worker, arg}

      updates_fetcher
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: EchoBot.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
