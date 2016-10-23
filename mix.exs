defmodule Arangoex.Mixfile do
  use Mix.Project

  def project do
    [
      app: :arangoex,
      version: "0.0.1",
      elixir: "~> 1.3",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      name: "Arangoex",
      deps: deps(),
      description: description(),
      package: package(),
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:httpoison, :logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:ex_doc, "~> 0.14", only: :dev},
      {:httpoison, "~> 0.9.0"},
      {:poison, "~> 3.0"},
    ]
  end

  defp description do
    """
    An Elixir driver for ArangoDB.
    """
  end

  defp package do
    [
      files: ["config", "lib", "test", ".gitignore", ".travis.yml", "LICENSE*", "mix.exs", "README*"],
      maintainers: ["Austin S. Morris"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/austinsmorris/arangoex"},
    ]
  end
end


