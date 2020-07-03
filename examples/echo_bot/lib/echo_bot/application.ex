defmodule EchoBot.Application do
  @moduledoc false

  use Application

  def start(_tuple, _args) do
    opts = [strategy: :one_for_one, name: EchoBot.Supervisor]

    Supervisor.start_link([EchoBot], opts)
  end
end
