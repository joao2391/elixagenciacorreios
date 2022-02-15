defmodule Elixagenciacorreios.MixProject do
  use Mix.Project

  @version "0.1.0"

  def project do
    [
      app: :elixagenciacorreios,
      version: "0.1.0",
      elixir: "~> 1.12",
      description: "Library to get information about brazilian's mail agencies",
      source_url: "https://github.com/joao2391/elixagenciacorreios",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      docs: [source_ref: "#{@version}", extras: ["README.md"], main: "readme"]
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
      {:httpoison, "~> 1.8"},
      {:floki, "~> 0.32.0"},
      {:ex_doc, "~> 0.24", only: :dev, runtime: false},
    ]
  end

  defp package do
    [
      maintainers: ["Joao Paulo de C. Lima"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/joao2391/elixagenciacorreios",
      }
    ]
  end
end
