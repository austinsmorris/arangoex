defmodule Arangoex.User do
  @moduledoc """
  This module contains functions used to manage users.
  """

  @doc """
  Create a new user.

  The `conn` parameter is an ArangoDB connection PID.  The `user` parameter is a map describing the user to be created.

  ## Endpoint

  POST /_api/user

  ## Options

  See the "Shared Options" in the `Arangoex` module documentation for additional options.

  ## Examples

      {:ok, conn} = Arangoex.start_link()
      {:ok, resp} = Arangoex.User.create(conn, %{user: "foo"})
  """
  def create(conn, %{} = user, opts \\ []) do
    Arangoex.request(conn, :post, "/_api/user", %{}, %{}, user, opts)
  end

  @doc """
  Return information about the databases available to a user.

  The `conn` parameter is an ArangoDB connection PID.  The `user_name` parameter is a string name of the user whose
  database information should be returned.

  ## Endpoint

   GET /_api/user/{user_name}/database

  ## Options

  See the "Shared Options" in the `Arangoex` module documentation for additional options.

  ## Examples

     {:ok, conn} = Arangoex.start_link()
     {:ok, resp} = Arangoex.User.database(conn, "foo")
  """
  def database(conn, user_name, opts \\ []) do
    Arangoex.request(conn, :get, "/_api/user/#{user_name}/database", %{}, %{}, nil, opts)
  end

  @doc """
  Return information about a user.

  The `conn` parameter is an ArangoDB connection PID.  The `user_name` parameter is a string name of the user whose
  information should be returned.

  ## Endpoint

   GET /_api/user/{user_name}

  ## Options

  See the "Shared Options" in the `Arangoex` module documentation for additional options.

  ## Examples

     {:ok, conn} = Arangoex.start_link()
     {:ok, resp} = Arangoex.User.get(conn, "foo")
  """
  def get(conn, user_name, opts \\ []) do
    Arangoex.request(conn, :get, "/_api/user/#{user_name}", %{}, %{}, nil, opts)
  end

  @doc """
  Grant database access to a user.

  The `conn` parameter is an ArangoDB connection PID.  The `user_name` parameter is a string name of the user who will
  be granted database access.  The `database_name` parameter is the string name of the database to which the user will
  be granted access.

  ## Endpoint

  PUT /_api/user/{user}/database/{dbname}

  ## Options

  See the "Shared Options" in the `Arangoex` module documentation for additional options.

  ## Examples

      {:ok, conn} = Arangoex.start_link()
      {:ok, resp} = Arangoex.User.grant(conn, "foo", "bar")
  """
  def grant(conn, user_name, database_name, opts \\ []) do
    Arangoex.request(conn, :put, "/_api/user/#{user_name}/database/#{database_name}", %{}, %{}, %{grant: "rw"}, opts)
  end

  @doc """
  Return information about all users the current user has access to.

  The `conn` parameter is an ArangoDB connection PID.

  ## Endpoint

  GET /_api/user

  ## Options

  See the "Shared Options" in the `Arangoex` module documentation for additional options.

  ## Examples

      {:ok, conn} = Arangoex.start_link()
      {:ok, resp} = Arangoex.User.list(conn)
  """
  def list(conn, opts \\ []) do
    Arangoex.request(conn, :get, "/_api/user", %{}, %{}, nil, opts)
  end

  @doc """
  Remove a user from the system.

  The `conn` parameter is an ArangoDB connection PID.  The `user_name` parameter is a string name of the user to be
  removed.

  ## Endpoint

  DELETE /_api/user/{user_name}

  ## Options

  See the "Shared Options" in the `Arangoex` module documentation for additional options.

  ## Examples

      {:ok, conn} = Arangoex.start_link()
      {:ok, resp} = Arangoex.User.remove(conn, "foo")
  """
  def remove(conn, user_name, opts \\ []) do
    Arangoex.request(conn, :delete, "/_api/user/#{user_name}", %{}, %{}, nil, opts)
  end

  @doc """
  Replace the properties of a user.

  The `conn` parameter is an ArangoDB connection PID.  The `user_name` parameter is the string name of the user whose
  properties should be replaced.  The `user` parameter is a map describing the replacement user properties.

  ## Endpoint

  PUT /_api/user/{user_name}

  ## Options

  See the "Shared Options" in the `Arangoex` module documentation for additional options.

  ## Examples

      {:ok, conn} = Arangoex.start_link()
      {:ok, resp} = Arangoex.User.replace(conn, "foo", %{password: "bar")
  """
  def replace(conn, user_name, %{} = user, opts \\ []) do
    Arangoex.request(conn, :put, "/_api/user/#{user_name}", %{}, %{}, user, opts)
  end

  @doc """
  Revoke database access from a user.

  The `conn` parameter is an ArangoDB connection PID.  The `user_name` parameter is a string name of the user whose
  access will be revoked. The `database_name` parameter is the string name of the database to which the user's access
  will be revoked.

  ## Endpoint

  PUT /_api/user/{user}/database/{dbname}

  ## Options

  See the "Shared Options" in the `Arangoex` module documentation for additional options.

  ## Examples

      {:ok, conn} = Arangoex.start_link()
      {:ok, resp} = Arangoex.User.revoke(conn, "foo", "bar")
  """
  def revoke(conn, user_name, database_name, opts \\ []) do
    Arangoex.request(conn, :put, "/_api/user/#{user_name}/database/#{database_name}", %{}, %{}, %{grant: "none"}, opts)
  end

  @doc """
  Update the properties of a user.

  The `conn` parameter is an ArangoDB connection PID.  The `user_name` parameter is the string name of the user whose
  properties should be updated.  The `user` parameter is a map describing the updated user properties.

  ## Endpoint

  PATCH /_api/user/{user_name}

  ## Options

  See the "Shared Options" in the `Arangoex` module documentation for additional options.

  ## Examples

      {:ok, conn} = Arangoex.start_link()
      {:ok, resp} = Arangoex.User.update(conn, "foo", %{password: "bar")
  """
  def update(conn, user_name, %{} = user, opts \\ []) do
    Arangoex.request(conn, :patch, "/_api/user/#{user_name}", %{}, %{}, user, opts)
  end
end
