defmodule Arangoex.Simple do
  @moduledoc false

  alias Arangoex.JSON

  @base_url "/_api/simple"

  # todo:
  # PUT /_api/simple/by-example
  # PUT /_api/simple/first-example
  # PUT /_api/simple/lookup-by-keys
  # PUT /_api/simple/any
  # PUT /_api/simple/remove-by-keys
  # PUT /_api/simple/remove-by-example
  # PUT /_api/simple/replace-by-example
  # PUT /_api/simple/update-by-example
  # PUT /_api/simple/range
  # PUT /_api/simple/near
  # PUT /_api/simple/within
  # PUT /_api/simple/within-rectangle
  # PUT /_api/simple/fulltext

  # PUT /_api/simple/all
  # Returns all documents in a collection.
  def list_documents(collection) do
    {:ok, body} = JSON.encode(%{collection: collection})
    "all" |> build_url() |> Arangoex.put(body)
  end

  # PUT /_api/simple/all-keys
  # Returns a list of keys/ids/paths for documents in a collection.
  def list_keys(collection, type \\ "path") do
    {:ok, body} = JSON.encode(%{collection: collection, type: type})
    "all-keys" |> build_url() |> Arangoex.put(body)
  end

  defp build_url(url_part) do
    [Arangoex.add_base_url(@base_url), "/", url_part]
  end
end
