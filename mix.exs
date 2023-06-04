defmodule Telegex.MixProject do
  use Mix.Project

  def project do
    [
      app: :telegex,
      version: "1.0.0-dev",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger] ++ extra_applications(),
      mod: {Telegex.Application, []}
    ]
  end

  def extra_applications do
    if Mix.env() in [:dev, :test] do
      [:httpoison, :req]
    else
      []
    end
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:dialyxir, "~> 1.3", only: [:dev], runtime: false},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:httpoison, "~> 2.1", optional: true, only: [:dev, :test]},
      {:req, "~> 0.3", optional: true, only: [:dev, :test]},
      {:typed_struct, "~> 0.3.0"},
      {:jason, "~> 1.4"}
    ]
  end
end
