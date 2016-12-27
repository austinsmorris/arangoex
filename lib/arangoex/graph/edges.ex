defmodule Arangoex.Graph.Edges do
  @moduledoc false

  use Arangoex, base_url: ["/", "_api", "/", "edges"]

  # GET /_api/edges/{collection-id}
  # Returns an array of edges in the collection identified by collection-id to or
  # from the vertex identified by vertex-handle.
  def list(collection_id, vertex_handle, opts \\ []) do
    # todo - direction parameter
    [collection_id, "?", "vertex=", vertex_handle]
      |> build_url(opts)
      |> Arangoex.get(opts)
  end
end
