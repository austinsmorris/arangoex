defmodule Arangoex.Graph.Edges do
  @moduledoc false

  @base_url "/_api/edges"

  # GET /_api/edges/{collection-id}
  # Returns an array of edges in the collection identified by collection-id to or
  # from the vertex identified by vertex-handle.
  def list(collection_id, vertex_handle) do
    # todo - direction parameter
    [collection_id, "?", "vertex=", vertex_handle] |> build_url() |> Arangoex.get()
  end

  defp build_url([]), do: [Arangoex.add_base_url(@base_url)]
  defp build_url(url_part), do: [Arangoex.add_base_url(@base_url), "/", url_part]
end
