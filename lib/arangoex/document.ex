defmodule Arangoex.Document do
  @moduledoc false

  alias Arangoex.JSON
  alias Arangoex.Simple

  use Arangoex, base_url: ["/", "_api", "/", "document"]

  # POST /_api/document/{collection}
  # Create a new document.
  def create(collection, document, opts \\ []) do
    # todo - implement waitForSync, returnNew, silent, collection (< v3.0?)
    {:ok, body} = JSON.encode(document)

    collection
      |> build_url(opts)
      |> Arangoex.post(body, Keyword.get(opts, :headers, []), opts)
  end

  # GET /_api/document/{document-handle}
  # Returns the document identified by document-handle.
  def get(document_handle, opts \\ []) do
    # todo - implement If-None-Match and If-Match headers
    document_handle
      |> build_url(opts)
      |> Arangoex.get(Keyword.get(opts, :headers, []), opts)
  end

  # HEAD /_api/document/{document-handle}
  # Returns the header of the document identified by document-handle.
  def info(document_handle, opts \\ []) do
    # todo - implement If-None-Match and If-Match headers
    document_handle
      |> build_url(opts)
      |> Arangoex.head(Keyword.get(opts, :headers, []), opts)
  end

  # proxy to PUT /_api/simple/all
  def list(collection, opts \\ []), do: Simple.list_documents(collection, opts)

  # proxy to PUT /_api/simple/all-keys
  # todo - refactor to make type an option parameter
  def list_keys(collection, type \\ "path", opts \\ []) do
    Simple.list_keys(collection, type, opts)
  end

  # PUT /_api/document/{document-handle}
  # Replace the document identified by document-handle.
  def replace(document_handle, document, opts \\ []) do
    # todo - implement waitForSync, ignoreRevs, returnOld, returnNew, and silent query parameters
    # todo - If-Match header
    {:ok, body} = JSON.encode(document)

    document_handle
      |> build_url(opts)
      |> Arangoex.put(body, Keyword.get(opts, :headers, []), opts)
  end

  # PUT /_api/document/{collection}
  # Replace multiple documents in the collection.
  def replace_many(__opts \\ []) do
    # todo - implement - need documentation examples
    # todo - implement waitForSync, ignoreRevs, returnOld, and returnNew query parameters
  end

  # DELETE /_api/document/{document-handle}
  # Remove the document identified by document-handle.
  def remove(document_handle, opts \\ []) do
    # todo - implement waitForSync, returnOld, and silent query parameters
    # todo - implement If-Match header
    document_handle
      |> build_url(opts)
      |> Arangoex.delete(Keyword.get(opts, :headers, []), opts)
  end

  # DELETE /_api/document/{collection}
  # Remove multiple documents in the collection.
  def remove_many(__opts \\ []) do
    # todo - implement - documentation is inconsistent
    # todo - implement waitForSync, returnOld, and ignoreRevs query parameters
  end

  # PATCH /_api/document/{document-handle}
  # Update the document identified by document-handle.
  def update(__opts \\ []) do
    # todo - implement
    # todo - implement keepNull, mergeObjects, waitForSync, ignoreRevs, returnOld, returnNew, & silent query parameters
    # todo - implement If-Match header
  end

  # PATCH /_api/document/{collection}
  # Update multiple documents in the collection.
  def update_many(__opts \\ []) do
    # todo - implement - need documentation examples
    # todo - implement keepNull, mergeObjects, waitForSync, ingoreRevs, returnOld, and returnNew query parameters
  end
end
