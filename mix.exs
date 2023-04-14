defmodule Telegex.MixProject do
  use Mix.Project
  @description "Telegram bot library for Elixir"

  @version "0.2.0-dev"

  def project do
    [
      app: :telegex,
      version: @version,
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: @description,
      package: package(),
      name: "Telegex",
      source_url: "https://github.com/Hentioe/telegex",
      docs: [
        main: "readme",
        extras: ["README.md"]
      ]
    ]
  end

  defp package do
    [
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/Hentioe/telegex"}
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:dialyxir, "~> 1.2", only: [:dev], runtime: false},
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.24", only: :dev, runtime: false},
      {:typed_struct, "~> 0.3"},
      {:httpoison, "~> 2.1", only: [:dev, :test, :prod]},
      {:jason, "~> 1.4"}
    ]
  end
end
