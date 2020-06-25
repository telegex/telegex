defmodule Telex.MixProject do
  use Mix.Project

  def project do
    [
      app: :telex,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      # Docs
      name: "Telex",
      source_url: "https://github.com/Hentioe/telex",
      homepage_url: "https://github.com/Hentioe/telex",
      docs: [
        # The main page in the docs
        main: "Telex",
        extras: ["README.md"]
      ]
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
      {:dialyxir, "~> 1.0", only: [:dev], runtime: false},
      {:ex_check, ">= 0.0.0", only: :dev, runtime: false},
      {:credo, "~> 1.4", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.22", only: :dev, runtime: false},
      {:typed_struct, "~> 0.2.0"}
    ]
  end
end
