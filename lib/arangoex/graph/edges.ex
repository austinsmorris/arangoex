defmodule Arangoex.Graph.Edges do
  @moduledoc """
  This module is for reading inbound and/or outbound edges from a vertex in a graph.
  """

  use Arangoex, base_url: ["/", "_api", "/", "edges"]

  @doc """
  `GET /_api/edges/{collection-id}`

  Returns an array of edges in the collection identified by collection_name to or from the vertex identified by
  vertex_handle.  If the direction is not specified, "any" edges are returned.

  ## Options

    * `:direction` - Filters the resulting edges by the direction to or from the given vertex.  It may be one of
      `"in"', `"out"`, or `"any"`.

  ## Examples

      {:ok, resp} = Arangoex.Graph.Edges.list("my_edges", "my_vertex/12345", direction: "in")
  """
  def list(collection_name, vertex_handle, opts \\ []) do
    query_params = [:vertex, :direction]
    opts = Keyword.put_new(opts, :vertex, vertex_handle)

    collection_name
      |> build_url(Keyword.put_new(opts, :query_params, query_params))
      |> Arangoex.get(opts)
  end
end
