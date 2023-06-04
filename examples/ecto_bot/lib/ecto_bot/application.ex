defmodule EctoBot.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: EctoBot.Worker.start_link(arg)
      # {EctoBot.Worker, arg}

      # Updates consumer
      EchoBot.Consumer,
      # Updates poller
      EchoBot.UpdatesPoller
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: EctoBot.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
