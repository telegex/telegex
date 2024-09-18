defmodule EchoBot.MixProject do
  use Mix.Project

  def project do
    [
      app: :echo_bot,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :observer, :wx, :runtime_tools],
      mod: {EchoBot.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:dialyxir, "~> 1.4", only: [:dev], runtime: false},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:telegex, path: "../../"},
      {:finch, "~> 0.19.0"},
      {:multipart, "~> 0.4.0"},
      {:plug, "~> 1.16"},
      {:plug_cowboy, "~> 2.7"},
      {:bandit, "~> 1.5"},
      {:remote_ip, "~> 1.2"}
    ]
  end
end
