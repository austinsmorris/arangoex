defmodule Arangoex.Collection do
  @moduledoc false

  alias Arangoex.JSON

  @base_url ["/", "_api", "/", "collection"]

  # POST /_api/collection
  # Create a new collection.
  def create(%{} = collection) do
    {:ok, body} = JSON.encode(collection)
    [] |> build_url() |> Arangoex.post(body)
  end

  # GET /_api/collection/{collection-name}
  # Return information about the collection identified by collection-name
  def get(collection_name) do
    collection_name |> build_url() |> Arangoex.get()
  end

  # GET /_api/collection/{collection-name}/checksum
  # Return the checksum for the collection identified by collection-name.
  def get_checksum(collection_name) do
    # todo - implement withRevisions and withData query parameters
    [collection_name, "/", "checksum"] |> build_url() |> Arangoex.get()
  end

  # GET /_api/collection/{collection-name}/count
  # Return the document count in the collection identified by collection-name
  def get_count(collection_name) do
    [collection_name, "/", "count"] |> build_url() |> Arangoex.get()
  end

  # GET /_api/collection/{collection-name}/figures
  # Return statistical figures for the collection identified by collection-name
  def get_figures(collection_name) do
    [collection_name, "/", "figures"] |> build_url() |> Arangoex.get()
  end

  # GET /_api/collection/{collection-name}/properties
  # Return properties of the collection identtified by collection-name
  def get_properties(collection_name) do
    [collection_name, "/", "properties"] |> build_url() |> Arangoex.get()
  end

  # GET /_api/collection/{collection-name}/revision
  # Return the revision of the collection identified by collection-name
  def get_revision(collection_name) do
    [collection_name, "/", "revision"] |> build_url() |> Arangoex.get()
  end

  # GET /_api/collection
  # List all collections in the database.
  def list() do
    # todo - implement excludeSystem query parameter
    [] |> build_url() |> Arangoex.get()
  end

  # PUT /_api/collection/{collection-name}/load
  # Load the collection identified by collection-name into memory.
  def load(collection_name) do
    [collection_name, "/", "load"] |> build_url() |> Arangoex.put()
  end

  # DELETE /_api/collection/{collection-name}
  # Remove the collection identified by collection-name from the database.
  def remove(collection_name) do
    # todo - implement isSystem query parameter
    collection_name |> build_url() |> Arangoex.delete()
  end

  # PUT /_api/collection/{collection-name}/rename
  # Rename the collection identified by collection-name.
  def rename(collection_name, collection) do
    {:ok, body} = JSON.encode(collection)
    [collection_name, "/", "rename"] |> build_url() |> Arangoex.put(body)
  end

  # PUT /_api/collection/{collection-name}/rotate
  # Rotate the journal of the collection identified by collection-name
  def rotate(collection_name) do
    [collection_name, "/", "rotate"] |> build_url() |> Arangoex.put
  end

  # PUT /_api/collection/{collection-name}/properties
  # Change the properties of the collection identified by collection-name.
  def set_properties(collection_name, properties) do
    {:ok, body} = JSON.encode(properties)
    [collection_name, "/", "properties"] |> build_url() |> Arangoex.put(body)
  end

  # PUT /_api/collection/{collection-name}/truncate
  # Remove all documents from the collection identified by collection-name
  def truncate(collection_name) do
    [collection_name, "/", "truncate"] |> build_url() |> Arangoex.put()
  end

  # PUT /_api/collection/{collection-name}/unload
  # Unload the collection identified by collection-name from memory.
  def unload(collection_name) do
    [collection_name, "/", "unload"] |> build_url() |> Arangoex.put()
  end

  defp build_url([]), do: [Arangoex.add_base_url(@base_url)]
  defp build_url(url_part), do: [Arangoex.add_base_url(@base_url), "/", url_part]
end
