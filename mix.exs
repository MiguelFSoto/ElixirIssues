defmodule Issues.MixProject do
  use Mix.Project

  def project do
    [
      app: :issues,
      version: "0.1.0",
      elixir: "~> 1.10.3",
      start_permanent: Mix.env() == :prod,
      escript: escript_config,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :httpoison, :jason]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
        {:httpoison, "~> 2.1"},
        {:jason, "~> 1.4"}
    ]
  end
  defp escript_config do
    [main_module: Issues.CLI]
  end
end
