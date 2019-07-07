defmodule Primelix.MixProject do
  use Mix.Project

  def project do
    [
      app: :primelix,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases()
    ]
  end

  defp aliases do
    [
      benchmark: ["deps.get", "compile", "goprimes", "cprimes", "rustyprimes", "jprimes", "crystalprimes", "swiftprimes", "run benchmark.exs"]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Primelix.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:bitmap, "~> 1.0"},
      {:benchee, "~> 1.0"}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
