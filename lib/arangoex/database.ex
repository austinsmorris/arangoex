defmodule Arangoex.Database do
  @moduledoc """
  This module contains functions used to manage databases.
  """

  @doc """
  Create a new database.

  The `conn` parameter is an ArangoDB connection PID.  The `database` parameter is a map describing the database to be
  created.

  ## Endpoint

  POST /_api/database

  ## Options

  See the "Shared Options" in the `Arangoex` module documentation for additional options.

  ## Examples

      {:ok, conn} = Arangoex.start_link()
      {:ok, resp} = Arangoex.Database.create(conn, %{name: "foo"})
  """
  def create(conn, %{} = database, opts \\ []) do
    Arangoex.request(conn, :post, "/_api/database", %{}, %{}, database, opts)
  end

  @doc """
  Return information about the current database.

  The `conn` parameter is an ArangoDB connection PID.

  ## Endpoint

  GET /_api/database/current

  ## Options

  See the "Shared Options" in the `Arangoex` module documentation for additional options.

  ## Examples

      {:ok, conn} = Arangoex.start_link()
      {:ok, resp} = Arangoex.Database.current(conn)
  """
  def current(conn, opts \\ []) do
    Arangoex.request(conn, :get, "/_api/database/current", %{}, %{}, nil, opts)
  end

  @doc """
  Return a list of databases on the system.

  The `conn` parameter is an ArangoDB connection PID.

  ## Endpoint

  GET /_api/database

  ## Options

  See the "Shared Options" in the `Arangoex` module documentation for additional options.

  ## Examples

      {:ok, conn} = Arangoex.start_link()
      {:ok, resp} = Arangoex.Database.list(conn)
  """
  def list(conn, opts \\ []) do
    Arangoex.request(conn, :get, "/_api/database", %{}, %{}, nil, opts)
  end

  @doc """
  Return a list of databases on the system for the current user.

  The `conn` parameter is an ArangoDB connection PID.

  ## Endpoint

  GET /_api/database/user

  ## Options

  See the "Shared Options" in the `Arangoex` module documentation for additional options.

  ## Examples

      {:ok, conn} = Arangoex.start_link()
      {:ok, resp} = Arangoex.Database.list_for_current_user(conn)
  """
  def list_for_current_user(conn, opts \\ []) do
    Arangoex.request(conn, :get, "/_api/database/user", %{}, %{}, nil, opts)
  end

  @doc """
  Remove the given database from the system.

  The `conn` parameter is an ArangoDB connection PID.  The `database_name` parameter is the database to be removed.

  ## Endpoint

  DELETE /_api/database/{database_name}

  ## Options

  See the "Shared Options" in the `Arangoex` module documentation for additional options.

  ## Examples

      {:ok, conn} = Arangoex.start_link()
      {:ok, resp} = Arangoex.Database.remove(conn, "foo")
  """
  def remove(conn, database_name, opts \\ []) do
    Arangoex.request(conn, :delete, "/_api/database/#{database_name}", %{}, %{}, nil, opts)
  end
end
