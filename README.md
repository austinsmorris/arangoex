# Arangoex

[![Build Status](https://travis-ci.org/austinsmorris/arangoex.svg?branch=master)](https://travis-ci.org/austinsmorris/arangoex)

An elixir driver for ArangoDB.

## Installation

The package can be installed from [Hex](https://hex.pm/packages/arangoex):

  1. Add `arangoex` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:arangoex, "~> 0.1.0"}]
    end
    ```

  2. Ensure `arangoex` is started before your application:

    ```elixir
    def application do
      [applications: [:arangoex]]
    end
    ```

