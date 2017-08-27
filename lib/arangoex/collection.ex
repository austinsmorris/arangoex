defmodule Arangoex.Collection do
  @moduledoc """
  This module contains functions used to manage collections.
  """

  @doc """
  Return number of documents in the collection.

  The `conn` parameter is an ArangoDB connection PID.  The `collection_name` parameter is a string name of the
  collection whose count should be returned.

  ## Endpoint

    PUT /_api/collection/{collection_name}/count

  ## Options

  See the "Shared Options" in the `Arangoex` module documentation for additional options.

  ## Examples

      {:ok, conn} = Arangoex.start_link()
      {:ok, resp} = Arangoex.Collection.count(conn, "foo")
  """
  def count(conn, collection_name, opts \\ []) do
    Arangoex.request(conn, :get, "/_api/collection/#{collection_name}/count", %{}, %{}, nil, opts)
  end

  @doc """
  Create a new collection.

  The `conn` parameter is an ArangoDB connection PID.  The `collection` parameter is a map describing the collection to
  be created.

  ## Endpoint

  POST /_api/collection

  ## Options

  See the "Shared Options" in the `Arangoex` module documentation for additional options.

  ## Examples

      {:ok, conn} = Arangoex.start_link()
      {:ok, resp} = Arangoex.Collection.create(conn, %{name: "foo"})
  """
  def create(conn, %{} = collection, opts \\ []) do
    # todo - waitforsynch and all sorts of options?
    Arangoex.request(conn, :post, "/_api/collection", %{}, %{}, collection, opts)
  end

  @doc """
  Return information about a collections.

  The `conn` parameter is an ArangoDB connection PID.  The `collection_name` parameter is a string name of the
  collection whose information should be returned.

  ## Endpoint

    GET /_api/collection/{collection_name}

  ## Options

  See the "Shared Options" in the `Arangoex` module documentation for additional options.

  ## Examples

      {:ok, conn} = Arangoex.start_link()
      {:ok, resp} = Arangoex.Collection.get(conn, "foo")
  """
  def get(conn, collection_name, opts \\ []) do
    Arangoex.request(conn, :get, "/_api/collection/#{collection_name}", %{}, %{}, nil, opts)
  end

  @doc """
  Return the checksum for a collection.

  The `conn` parameter is an ArangoDB connection PID.  The `collection_name` parameter is a string name of the
  collection whose checksum should be returned.

  ## Endpoint

    PUT /_api/collection/{collection_name}/checksum

  ## Options

  See the "Shared Options" in the `Arangoex` module documentation for additional options.

  ## Examples

      {:ok, conn} = Arangoex.start_link()
      {:ok, resp} = Arangoex.Collection.checksum(conn, "foo")
  """
  def checksum(conn, collection_name, opts \\ []) do
    # todo - implement withRevisions and withData query parameters
    Arangoex.request(conn, :get, "/_api/collection/#{collection_name}/checksum", %{}, %{}, nil, opts)
  end

  @doc """
  Return the properties of a collection.

  The `conn` parameter is an ArangoDB connection PID.  The `collection_name` parameter is a string name of the
  collection whose properties should be returned.

  ## Endpoint

  PUT /_api/collection/{collection_name}/properties

  ## Options

  See the "Shared Options" in the `Arangoex` module documentation for additional options.

  ## Examples

      {:ok, conn} = Arangoex.start_link()
      {:ok, resp} = Arangoex.Collection.properties(conn, "foo")
  """
  def get_properties(conn, collection_name, opts \\ []) do
    Arangoex.request(conn, :get, "/_api/collection/#{collection_name}/properties", %{}, %{}, nil, opts)
  end

  @doc """
  Return information about all collections in the database

  The `conn` parameter is an ArangoDB connection PID.

  ## Endpoint

  GET /_api/collection

  ## Options

  See the "Shared Options" in the `Arangoex` module documentation for additional options.

  ## Examples

      {:ok, conn} = Arangoex.start_link()
      {:ok, resp} = Arangoex.Collection.list(conn)
  """
  def list(conn, opts \\ []) do
    # todo - implement excludeSystem query parameter
    Arangoex.request(conn, :get, "/_api/collection", %{}, %{}, nil, opts)
  end

  @doc """
  Load a collection into memory.

  The `conn` parameter is an ArangoDB connection PID.  The `collection_name` parameter is a string name of the
  collection to be loaded.

  ## Endpoint

  PUT /_api/collection/{collection_name}/load

  ## Options

  See the "Shared Options" in the `Arangoex` module documentation for additional options.

  ## Examples

      {:ok, conn} = Arangoex.start_link()
      {:ok, resp} = Arangoex.Collection.load(conn, "foo")
  """
  def load(conn, collection_name, opts \\ []) do
    Arangoex.request(conn, :put, "/_api/collection/#{collection_name}/load", %{}, %{}, nil, opts)
  end

  @doc """
  Remove a collection.

  The `conn` parameter is an ArangoDB connection PID.  The `collection_name` parameter is a string name of the
  collection to be removed.

  ## Endpoint

  DELETE /_api/collection/{collection_name}

  ## Options

  See the "Shared Options" in the `Arangoex` module documentation for additional options.

  ## Examples

      {:ok, conn} = Arangoex.start_link()
      {:ok, resp} = Arangoex.Collection.remove(conn, "foo")
  """
  def remove(conn, collection_name, opts \\ []) do
    # todo - implement isSystem query parameter
    Arangoex.request(conn, :delete, "/_api/collection/#{collection_name}", %{}, %{}, nil, opts)
  end

  # PUT /_api/collection/{collection-name}/rename
  # Rename the collection identified by collection-name.
  def rename(collection_name, collection, opts \\ []) do
    # todo
#    {:ok, body} = JSON.encode(collection)
#
#    [collection_name, "/", "rename"]
#      |> build_url(opts)
#      |> Arangoex.put(body, opts)
  end

  @doc """
  Return the revision id of a collection.

  The `conn` parameter is an ArangoDB connection PID.  The `collection_name` parameter is a string name of the
  collection from which to fetch the revision id.

  ## Endpoint

  GET /_api/collection/{collection_name}/revision

  ## Options

  See the "Shared Options" in the `Arangoex` module documentation for additional options.

  ## Examples

      {:ok, conn} = Arangoex.start_link()
      {:ok, resp} = Arangoex.Collection.revision(conn, "foo")
  """
  def revision(conn, collection_name, opts \\ []) do
    Arangoex.request(conn, :get, "/_api/collection/#{collection_name}/revision", %{}, %{}, nil, opts)
  end

  @doc """
  Rotate the journal of a collection

  The `conn` parameter is an ArangoDB connection PID.  The `collection_name` parameter is a string name of the
  collection to be rotated.

  ## Endpoint

  PUT /_api/collection/{collection_name}/rotate

  ## Options

  See the "Shared Options" in the `Arangoex` module documentation for additional options.

  ## Examples

      {:ok, conn} = Arangoex.start_link()
      {:ok, resp} = Arangoex.Collection.rotate(conn, "foo")
  """
  def rotate(conn, collection_name, opts \\ []) do
    Arangoex.request(conn, :put, "/_api/collection/#{collection_name}/rotate", %{}, %{}, nil, opts)
  end

  # PUT /_api/collection/{collection-name}/properties
  # Change the properties of the collection identified by collection-name.
  def set_properties(collection_name, properties, opts \\ []) do
    # todo
#    {:ok, body} = JSON.encode(properties)
#
#    [collection_name, "/", "properties"]
#      |> build_url(opts)
#      |> Arangoex.put(body, opts)
  end

  @doc """
  Return statistics about a collection.

  The `conn` parameter is an ArangoDB connection PID.  The `collection_name` parameter is a string name of the
  collection whose statistics should be returned.

  ## Endpoint

    PUT /_api/collection/{collection_name}/figures

  ## Options

  See the "Shared Options" in the `Arangoex` module documentation for additional options.

  ## Examples

      {:ok, conn} = Arangoex.start_link()
      {:ok, resp} = Arangoex.Collection.figures(conn, "foo")
  """
  def statistics(conn, collection_name, opts \\ []) do
    Arangoex.request(conn, :get, "/_api/collection/#{collection_name}/figures", %{}, %{}, nil, opts)
  end

  @doc """
  Remove all documents from a collection, leaving indexes intact.

  The `conn` parameter is an ArangoDB connection PID.  The `collection_name` parameter is a string name of the
  collection to be truncated.

  ## Endpoint

  PUT /_api/collection/{collection_name}/truncate

  ## Options

  See the "Shared Options" in the `Arangoex` module documentation for additional options.

  ## Examples

      {:ok, conn} = Arangoex.start_link()
      {:ok, resp} = Arangoex.Collection.truncate(conn, "foo")
  """
  def truncate(conn, collection_name, opts \\ []) do
    Arangoex.request(conn, :put, "/_api/collection/#{collection_name}/truncate", %{}, %{}, nil, opts)
  end

  @doc """
  Unload a collection from memory.

  The `conn` parameter is an ArangoDB connection PID.  The `collection_name` parameter is a string name of the
  collection to be unloaded.

  ## Endpoint

  PUT /_api/collection/{collection_name}/unload

  ## Options

  See the "Shared Options" in the `Arangoex` module documentation for additional options.

  ## Examples

      {:ok, conn} = Arangoex.start_link()
      {:ok, resp} = Arangoex.Collection.unload(conn, "foo")
  """
  def unload(conn, collection_name, opts \\ []) do
    Arangoex.request(conn, :put, "/_api/collection/#{collection_name}/unload", %{}, %{}, nil, opts)
  end
end
