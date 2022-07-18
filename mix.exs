defmodule Arangoex.Mixfile do
  use Mix.Project

  def project do
    [
      app: :arangoex,
      version: "0.1.0",
      elixir: "~> 1.4",
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
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger]]
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
      {:connection, "~> 1.0"},
      {:credo, "~> 1.6", only: [:dev, :test]},
      {:ex_doc, "~> 0.16", only: :dev},
      {:velocy_pack, "~> 0.1"},
      {:velocy_stream, "~> 0.0"},
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


