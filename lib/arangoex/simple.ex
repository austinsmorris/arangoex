defmodule Arangoex.Simple do
  @moduledoc """
  ArangoDB HTTP Interface for Simple Queries

  ## TODO

  * Implement function for `PUT /_api/simple/within-rectangle`
  * Specify typespecs

  """

#  use Arangoex, base_url: ["/", "_api", "/", "simple"]
#  alias Arangoex.{JSON,Response}

  @doc """
  Returns the first document in the collection identified by
  `collection_name` that matches the example document.

  The HTTP requests looks like:

      PUT /_api/simple/first-example

  ## Arguments

  * `collection_name` - a string representing the collection name
  * `example` - a map representing an example for the query to use
  * `opts` - a keyword list of options on how to make the query

  ## Options

  * `query_params` - a keyword list of query params to build into the
    request url
  * `headers` - a list of 2-length tuples for HTTP headers
    (e.g. [{"Connection", "close"}] used in request

  ## Example

      iex> Arangoex.Simple.get_first_document_by_example("exotic_cars", %{brand: "lamborghini"})

  """
  @spec get_first_document_by_example(binary, map, keyword) :: {:ok, Response.t}
  def get_first_document_by_example(collection_name, example, opts \\ []) do
#    {:ok, body} = JSON.encode(%{collection: collection_name, example: example})
#
#    "first-example"
#    |> build_url(opts)
#    |> Arangoex.put(body, opts)
  end

  @doc """
  Return a random document from the collection identified by `collection_name`.

  The HTTP requests looks like:

      PUT /_api/simple/any

  ## Arguments

  * `collection_name` - a string representing the collection name
  * `opts` - a keyword list of options on how to make the query

  ## Options

  * `query_params` - a keyword list of query params to build into the
    request url
  * `headers` - a list of 2-length tuples for HTTP headers
    (e.g. [{"Connection", "close"}] used in request

  ## Example

      iex> Arangoex.Simple.get_random_document("exotic_cars")

  """
  def get_random_document(collection_name, opts \\ []) do
#    {:ok, body} = JSON.encode(%{collection: collection_name})
#
#    "any"
#      |> build_url(opts)
#      |> Arangoex.put(body, opts)
  end

  @doc """
  Returns all documents in a collection.

  The HTTP requests looks like:

      PUT /_api/simple/all

  ## Arguments

  * `collection_name` - a string representing the collection name
  * `attrs` - a keyword list of attributes specific to this type of query
  * `opts` - a keyword list of options on how to make the query

  ## Attributes (optional)

  * `skip` - the number of documents to skip in the query
  * `limit` - the maximum number of documents to return in the query

  ## Options

  * `query_params` - a keyword list of query params to build into the
    request url
  * `headers` - a list of 2-length tuples for HTTP headers
    (e.g. [{"Connection", "close"}] used in request

  ## Example

      iex> Arangoex.Simple.list_documents("exotic_cars")

  """
  def list_documents(collection_name, attrs \\ [], opts \\ []) do
#    {:ok, body} = attrs
#      |> Enum.into(%{collection: collection_name})
#      |> JSON.encode
#
#    "all"
#      |> build_url(opts)
#      |> Arangoex.put(body, opts)
  end

  @doc """
  Return all documents in the collection identified by `collection_name`
  that match the example document.

  The HTTP requests looks like:

      PUT /_api/simple/by-example

  ## Arguments

  * `collection_name` - a string representing the collection name
  * `example` - a map representing the structure of an example document
  * `attrs` - a keyword list of attributes specific to this type of query
  * `opts` - a keyword list of options on how to make the query

  ## Attributes (optional)

  * `skip` - the number of documents to skip in the query
  * `limit` - the maximum number of documents to return in the query
  * `batchSize` - the maximum number of results returned in single query

  ## Options

  * `query_params` - a keyword list of query params to build into the
    request url
  * `headers` - a list of 2-length tuples for HTTP headers
    (e.g. [{"Connection", "close"}] used in request

  ## Example

      iex> Arangoex.Simple.list_documents_by_example("exotic_cars", %{continent: "european"})

  """
  def list_documents_by_example(collection_name, example, attrs \\ [], opts \\ []) do
#    {:ok, body} = attrs
#      |> Enum.into(%{collection: collection_name, example: example})
#      |> JSON.encode
#
#    "by-example"
#      |> build_url(opts)
#      |> Arangoex.put(body, opts)
  end

  @doc """
  Return all documents in the collection identified by `collection_name`
  for the given keys.

  The HTTP requests looks like:

      PUT /_api/simple/lookup-by-keys

  ## Arguments

  * `collection_name` - a string representing the collection name
  * `keys` - a list of keys of documents to retrieve
  * `opts` - a keyword list of options on how to make the query

  ## Options

  * `query_params` - a keyword list of query params to build into the
    request url
  * `headers` - a list of 2-length tuples for HTTP headers
    (e.g. [{"Connection", "close"}] used in request

  ## Example

      iex> Arangoex.Simple.list_documents_for_keys("exotic_cars", ["car1", "car2"]})

  """
  def list_documents_for_keys(collection_name, keys \\ [], opts \\ []) do
#    {:ok, body} = JSON.encode(%{collection: collection_name, keys: keys})
#
#    "lookup-by-keys"
#      |> build_url(opts)
#      |> Arangoex.put(body, opts)
  end

  @doc """
  Returns a list of keys/ids/paths for documents in a collection.

  The HTTP requests looks like:

      PUT /_api/simple/all-keys

  ## Arguments

  * `collection_name` - a string representing the collection name
  * `type` - a string representing the type of result (defaults to `path`)
  * `opts` - a keyword list of options on how to make the query

  ## Supported Types

  * `id` - returns a list of document ids (`_id` attributes)
  * `key` - returns a list of document keys (`_key` attributes)
  * `path` - returns a list of document URI paths (`_path` attributes)

  ## Options

  * `query_params` - a keyword list of query params to build into the
    request url
  * `headers` - a list of 2-length tuples for HTTP headers
    (e.g. [{"Connection", "close"}] used in request

  ## Example

      iex> Arangoex.Simple.list_keys("exotic_cars", "key")

  """
  def list_keys(collection, type \\ "path", opts \\ []) do
#    {:ok, body} = JSON.encode(%{collection: collection, type: type})
#
#    "all-keys"
#      |> build_url(opts)
#      |> Arangoex.put(body, opts)
  end

  @doc """
  Remove documents in the collection identified by `collection_name`
  that match the example document.

  The HTTP requests looks like:

      PUT /_api/simple/remove-by-example

  ## Arguments

  * `collection_name` - a string representing the collection name
  * `example` - a document to compare documents against for matching
  * `attrs` - a keyword list of attributes specific to this type of query
  * `opts` - a keyword list of options on how to make the query

  ## Attributes

  * `limit` - the maximum number of documents to delete in the query
  * `waitForSync` - if `true`, remove operations will be instantly
    synced to disk, otherwise normal sync behavior will occur

  ## Options

  * `query_params` - a keyword list of query params to build into the
    request url
  * `headers` - a list of 2-length tuples for HTTP headers
    (e.g. [{"Connection", "close"}] used in request

  ## Example

      iex> Arangoex.Simple.remove_documents_by_example("movies", %{category: "comedy"}])

  """
  def remove_documents_by_example(collection_name, example, attrs \\ [], opts \\ []) do
#    {:ok, body} = attrs
#      |> Enum.into(%{collection: collection_name, example: example})
#      |> JSON.encode
#
#    "remove-by-example"
#      |> build_url(opts)
#      |> Arangoex.put(body, opts)
  end

  @doc """
  Remove all documents in the collection identified by `collection_name`
  for the given keys.

  The HTTP requests looks like:

      PUT /_api/simple/remove-by-keys

  ## Arguments

  * `collection_name` - a string representing the collection name
  * `keys` - a list of the `_keys` of documents to remove
  * `attrs` - a keyword list of attributes specific to this type of query
  * `opts` - a keyword list of options on how to make the query

  ## Attributes

  * `returnOld` - if `true` and `silent` is `false`, then it returns
    the complete documents that were removed
  * `silent` - if `false`, then returns list with removed documents
    (default: returns `_id`, `_key`, `_rev`)
  * `waitForSync` - if `true`, remove operations will be instantly
    synced to disk, otherwise normal sync behavior will occur

  ## Options

  * `query_params` - a keyword list of query params to build into the
    request url
  * `headers` - a list of 2-length tuples for HTTP headers
    (e.g. [{"Connection", "close"}] used in request

  ## Example

      iex> Arangoex.Simple.remove_documents_for_keys("movies", ["movie1", "movie2"])

  """
  def remove_documents_for_keys(collection_name, keys \\ [], attrs \\ [], opts \\ []) do
#    {:ok, body} = attrs
#      |> Enum.into(%{collection: collection_name, keys: keys})
#      |> JSON.encode
#
#    "remove-by-keys"
#      |> build_url(opts)
#      |> Arangoex.put(body, opts)
  end

  @doc """
  Replace all documents in the collection identified by
  `collection_name` that match the example document.

  The HTTP requests looks like:

      PUT /_api/simple/replace-by-example

  ## Arguments

  * `collection_name` - a string representing the collection name
  * `example` - a document to compare documents against for matching
  * `document` - a document to replace the matched documents with
  * `attrs` - a keyword list of attributes specific to this type of query
  * `opts` - a keyword list of options on how to make the query

  ## Attributes

  * `limit` - the maximum number of documents to delete in the query
  * `waitForSync` - if `true`, remove operations will be instantly
    synced to disk, otherwise normal sync behavior will occur

  ## Options

  * `query_params` - a keyword list of query params to build into the
    request url
  * `headers` - a list of 2-length tuples for HTTP headers
    (e.g. [{"Connection", "close"}] used in request

  ## Example

      iex> Arangoex.Simple.replace_documents_by_example("soda-inventory", %{brand: "coke"}, %{brand: "pepsi"})

  """
  def replace_documents_by_example(collection_name, example, document, attrs \\ [], opts \\ []) do
#    {:ok, body} = attrs
#      |> Enum.into(%{collection: collection_name, example: example, newValue: document})
#      |> JSON.encode
#
#    "replace-by-example"
#      |> build_url(opts)
#      |> Arangoex.put(body, opts)
  end

  @doc """
  Update all documents in the collection identified by
  `collection_name` that match the example document.

  The HTTP requests looks like:

      PUT /_api/simple/update-by-example

  ## Arguments

  * `collection_name` - a string representing the collection name
  * `example` - a document to compare documents against for matching
  * `document` - a document to update/patch the matched documents with
  * `attrs` - a keyword list of attributes specific to this type of query
  * `opts` - a keyword list of options on how to make the query

  ## Attributes

  * `keepNull` - if `false`, all attributes in data with null values
    will be removed from updated document.
  * `mergeObjects` - if `false`, the value in the patch document will
    overwrite the existing value, otherwise, objects will be
    merged. (default: true)
  * `limit` - the maximum number of documents to delete in the query
  * `waitForSync` - if `true`, remove operations will be instantly
    synced to disk, otherwise normal sync behavior will occur

  ## Options

  * `query_params` - a keyword list of query params to build into the
    request url
  * `headers` - a list of 2-length tuples for HTTP headers
    (e.g. [{"Connection", "close"}] used in request

  ## Example

      iex> Arangoex.Simple.update_documents_by_example("soda-inventory", %{brand: "coke"}, %{brand: "pepsi"})

  """
  def update_documents_by_example(collection_name, example, document, attrs \\ [], opts \\ []) do
#    {:ok, body} = attrs
#      |> Enum.into(%{collection: collection_name, example: example, newValue: document})
#      |> JSON.encode
#
#    "update-by-example"
#      |> build_url(opts)
#      |> Arangoex.put(body, opts)
  end
end
