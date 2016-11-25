defmodule Arangoex.Simple do
  @moduledoc false

  alias Arangoex.JSON

  @base_url "/_api/simple"

  # todo or not (deprecated):
  # PUT /_api/simple/fulltext
  # PUT /_api/simple/near
  # PUT /_api/simple/range
  # PUT /_api/simple/within
  # PUT /_api/simple/within-rectangle

  # PUT /_api/simple/first-example
  # Return the first document in the collection identified by colleciton-name that matches the example document.
  def get_first_document_by_example(collection_name, example) do
    {:ok, body} = JSON.encode(%{collection: collection_name, example: example})
    ["first-example"] |> build_url() |> Arangoex.put(body)
  end

  # PUT /_api/simple/any
  # Return a random document from the collection identified by collection-name.
  def get_random_document(collection_name) do
    {:ok, body} = JSON.encode(%{collection: collection_name})
    ["any"] |> build_url() |> Arangoex.put(body)
  end

  # PUT /_api/simple/all
  # Returns all documents in a collection.
  def list_documents(collection_name) do
    # todo - implement skip, limit and batchsize? options
    {:ok, body} = JSON.encode(%{collection: collection_name})
    ["all"] |> build_url() |> Arangoex.put(body)
  end

  # PUT /_api/simple/by-example
  # Return all documents in the collection identified by colleciton-name that match the example document.
  def list_documents_by_example(collection_name, example) do
    # todo - implement skip and limit options
    {:ok, body} = JSON.encode(%{collection: collection_name, example: example})
    ["by-example"] |> build_url() |> Arangoex.put(body)
  end

  # PUT /_api/simple/lookup-by-keys
  # Return all documents in the collection identified by collection-name for the given keys.
  def list_documents_for_keys(collection_name, keys \\ []) do
    {:ok, body} = JSON.encode(%{collection: collection_name, keys: keys})
    ["lookup-by-keys"] |> build_url() |> Arangoex.put(body)
  end

  # PUT /_api/simple/all-keys
  # Returns a list of keys/ids/paths for documents in a collection.
  # todo - refactor to make type an option parameter
  def list_keys(collection, type \\ "path") do
    {:ok, body} = JSON.encode(%{collection: collection, type: type})
    ["all-keys"] |> build_url() |> Arangoex.put(body)
  end

  # PUT /_api/simple/remove-by-example
  # Remove documents in the collection identified by collection-name that match the example document.
  def remove_documents_by_example(collection_name, example) do
    # todo - implement limit and waitForSync options
    {:ok, body} = JSON.encode(%{collection: collection_name, example: example})
    ["remove-by-example"] |> build_url() |> Arangoex.put(body)
  end

  # PUT /_api/simple/remove-by-keys
  # Remove all documents in the collection identified by collection-name for the given keys.
  def remove_documents_for_keys(collection_name, keys \\ []) do
    # todo - implement returnOld, silent, and waitForSync options
    {:ok, body} = JSON.encode(%{collection: collection_name, keys: keys})
    ["remove-by-keys"] |> build_url() |> Arangoex.put(body)
  end

  # PUT /_api/simple/replace-by-example
  # Replace all documents in the collection identified by collection-name that match the example document.
  def replace_documents_by_example(collection_name, example, document) do
    # todo - implement limit and waitForSync options
    {:ok, body} = JSON.encode(%{collection: collection_name, example: example, newValue: document})
    ["replace-by-example"] |> build_url() |> Arangoex.put(body)
  end

  # PUT /_api/simple/update-by-example
  # Update all documents in the collection identified by collection-name that match the example document.
  def update_documents_by_example(collection_name, example, document) do
    # todo - implement keepNull, mergeObjects, limit, and waitForSync options
    {:ok, body} = JSON.encode(%{collection: collection_name, example: example, newValue: document})
    ["update-by-example"] |> build_url() |> Arangoex.put(body)
  end

  defp build_url([]), do: [Arangoex.add_base_url(@base_url)]
  defp build_url(url_part), do: [Arangoex.add_base_url(@base_url), "/", url_part]
end
