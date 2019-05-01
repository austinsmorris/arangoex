# Arangoex

[![Build Status](https://travis-ci.org/austinsmorris/arangoex.svg?branch=master)](https://travis-ci.org/austinsmorris/arangoex)

An elixir driver for ArangoDB.

## Installation

The package can be installed from [Hex](https://hex.pm/packages/arangoex):

  1. Add `arangoex` to your list of dependencies in `mix.exs`:

```elixir
  def deps do
    [{:arangoex, "~> 0.0.1"}]
  end
```

  2. Configure `arangoex` for your specific environment:

  ```elixir
  config :arangoex,
    host: "http://localhost:8529",
    database: "myDatabase",
    username: "myUsername",
    password: "myPassword"
  ```

  3. Ensure `arangoex` is started before your application:

  ```elixir
  def application do
    [applications: [:arangoex]]
  end
  ```

## Running Tests

You can run tests with `mix test`, but you must startup an instance of
arangodb without authentication. Using
the [official docker image](https://hub.docker.com/_/arangodb/) is
recommended.
