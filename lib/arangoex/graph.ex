defmodule Arangoex.Graph do
  @moduledoc """
  This module contains functions used to manage graph structures, vertex document collections, and
  edge document collections.
  """

  alias Arangoex.JSON

  use Arangoex, base_url: ["/", "_api", "/", "gharial"]

  @doc """
  Add an edge definition to the graph identified by graph_name.

  The `edges` parameter is a map containing the edge definition according to the ArangoDB documentation.

  ## Endpoint

  POST /_api/gharial/{graph-name}/edge

  ## Options

  See the "Shared Options" in the `Arangoex` module documentation for additional options.

  ## Examples

      edge_def = %{collection: "my_edges", from: ["foo", "bar"], to: ["baz"]}
      {:ok, resp} = Arangoex.Graph.add_edges("my_graph", edge_def)
  """
  def add_edges(graph_name, edges, opts \\ []) do
    {:ok, body} = JSON.encode(edges)

    [graph_name, "/", "edge"]
      |> build_url(opts)
      |> Arangoex.post(body, opts)
  end

  @doc """
  Add a vertex collection to the graph identified by graph_name.  Create the collection if it does not exist.

  The `vertices` parameter is a map containing a `:collection` property with the name of the collection, according
  to the ArangoDB documentation.

  ## Endpoint

  POST /_api/gharial/{graph-name}/vertex

  ## Options

  See the "Shared Options" in the `Arangoex` module documentation for additional options.

  ## Examples

      {:ok, resp} = Arangoex.Graph.add_vertices("my_graph", %{collection: "my_vertices"}

  """
  def add_vertices(graph_name, vertices, opts \\ []) do
    {:ok, body} = JSON.encode(vertices)

    [graph_name, "/", "vertex"]
      |> build_url(opts)
      |> Arangoex.post(body, opts)
  end

  @doc """
  Create a new graph.

  The `graph` parameter is a map containing the graph definition according to the ArangoDB documentation.

  ## Endpoint

  POST /_api/gharial

  ## Options

  See the "Shared Options" in the `Arangoex` module documentation for additional options.

  ## Examples

      edge_def = %{collection: "my_edges", from: ["my_vertices"], to: ["my_other_vertices"]}
      graph_def = %{name: "my_graph", edgeDefinitions: [edge_def]}
      Arangoex.Graph.create(graph_def)
  """
  def create(graph, opts \\ []) do
    {:ok, body} = JSON.encode(graph)

    []
      |> build_url(opts)
      |> Arangoex.post(body, opts)
  end

  # POST /_api/gharial/{graph-name}/edge/{collection-name}
  # Create an edge in the collection identified by collection-name in the graph identified by graph-name.
  def create_edge(graph_name, collection_name, edge, opts \\ []) do
    {:ok, body} = JSON.encode(edge)

    [graph_name, "/", "edge", "/", collection_name]
      |> build_url(opts)
      |> Arangoex.post(body, opts)
  end

  # POST /_api/gharial/{graph-name}/vertex/{collection-name}
  # Create a vertex in the collection identified by collection-name in the graph identified by graph-name.
  def create_vertex(graph_name, collection_name, vertex, opts \\ []) do
    {:ok, body} = JSON.encode(vertex)

    [graph_name, "/", "vertex", "/", collection_name]
      |> build_url(opts)
      |> Arangoex.post(body, opts)
  end

  # GET /_api/gharial/{graph-name}
  # Return the graph identified by graph-name.
  def get(graph_name, opts \\ []) do
    graph_name
      |> build_url(opts)
      |> Arangoex.get(opts)
  end

  # GET /_api/gharial/{graph-name}/edge/{collection-name}/{edge-key}
  # Return the edge identified by document-handle in the graph identified by graph-name
  def get_edge(graph_name, document_handle, opts \\ []) do
    [graph_name, "/", "edge", "/", document_handle]
      |> build_url(opts)
      |> Arangoex.get(opts)
  end

  # GET /_api/gharial/{graph-name}/vertex/{collection-name}/{vertex-key}
  # Return the vertex identified by document-handle in the graph identified by graph-name
  def get_vertex(graph_name, document_handle, opts \\ []) do
    [graph_name, "/", "vertex", "/", document_handle]
      |> build_url(opts)
      |> Arangoex.get(opts)
  end

  # GET /_api/gharial
  # List all graphs in the database.
  def list(opts \\ []) do
    []
      |> build_url(opts)
      |> Arangoex.get(opts)
  end

  # GET /_api/gharial/{graph-name}/edge
  # List all edge collection in the graph identified by graph-name
  def list_edges(graph_name, opts \\ []) do
    [graph_name, "/", "edge"]
      |> build_url(opts)
      |> Arangoex.get(opts)
  end

  # GET /_api/gharial/{graph-name}/vertex
  # List all vertex collection in the graph identified by graph-name
  def list_vertices(graph_name, opts \\ []) do
    [graph_name, "/", "vertex"]
      |> build_url(opts)
      |> Arangoex.get(opts)
  end

  # DELETE /_api/gharial/{graph-name}
  # Remove the graph identified by graph-name from the database.
  def remove(graph_name, opts \\ []) do
    query_params = [:dropCollections]

    graph_name
      |> build_url(Keyword.put_new(opts, :query_params, query_params))
      |> Arangoex.delete(opts)
  end

  # DELETE /_api/gharial/{graph-name}/edge/{document-handle}
  # Remove the edge identified by document-handle in the graph identified by graph-name
  def remove_edge(graph_name, document_handle, opts \\ []) do
    [graph_name, "/", "edge", "/", document_handle]
      |> build_url(opts)
      |> Arangoex.delete(opts)
  end

  # DELETE /_api/gharial/{graph-name}/edge/{definition-name}
  # Remove the edge definition identified by definition-name from the graph identified by graph-name.
  def remove_edges(graph_name, definition_name, opts \\ []) do
    [graph_name, "/", "edge", "/", definition_name]
      |> build_url(opts)
      |> Arangoex.delete(opts)
  end

  # DELETE /_api/gharial/{graph-name}/vertex/{collection-name}
  # Remove the vertex collection identified by collection-name from the graph identified by graph-name.
  def remove_vertices(graph_name, collection_name, opts \\ []) do
    [graph_name, "/", "vertex", "/", collection_name]
      |> build_url(opts)
      |> Arangoex.delete(opts)
  end

  # DELETE /_api/gharial/{graph-name}/vertex/{document-handle}
  # Remove the vertex identified by document-handle in the graph identified by graph-name
  def remove_vertex(graph_name, document_handle, opts \\ []) do
    [graph_name, "/", "vertex", "/", document_handle]
      |> build_url(opts)
      |> Arangoex.delete(opts)
  end

  # PUT /_api/gharial/{graph-name}/edge/{document-handle}
  # Replace the edge identified by document-handle in the graph identified by graph-name
  def replace_edge(graph_name, document_handle, edge, opts \\ []) do
    {:ok, body} = JSON.encode(edge)

    [graph_name, "/", "edge", "/", document_handle]
      |> build_url(opts)
      |> Arangoex.put(body, opts)
  end

  # PUT /_api/gharial/{graph-name}/edge/{definition-name}
  # Replace the edge definition identified by definition-name in the graph identified by graph-name.
  def replace_edges(graph_name, definition_name, edges, opts \\ []) do
    {:ok, body} = JSON.encode(edges)

    [graph_name, "/", "edge", "/", definition_name]
      |> build_url(opts)
      |> Arangoex.put(body, opts)
  end

  # PUT /_api/gharial/{graph-name}/vertex/{document-handle}
  # Replace the vertex identified by document-handle in the graph identified by graph-name
  def replace_vertex(graph_name, document_handle, vertex, opts \\ []) do
    {:ok, body} = JSON.encode(vertex)

    [graph_name, "/", "vertex", "/", document_handle]
      |> build_url(opts)
      |> Arangoex.put(body, opts)
  end

  # PATCH /_api/gharial/{graph-name}/edge/{document-handle}
  # Update the edge identified by document-handle at the graph identified by graph-name.
  def update_edge(graph_name, document_handle, edge, opts \\ []) do
    {:ok, body} = JSON.encode(edge)

    [graph_name, "/", "edge", "/", document_handle]
      |> build_url(opts)
      |> Arangoex.patch(body, opts)
  end

  # PATCH /_api/gharial/{graph-name}/vertex/{document-handle}
  # Update the vertex identified by document-handle in the graph identified by graph-name.
  def update_vertex(graph_name, document_handle, vertex, opts \\ []) do
    {:ok, body} = JSON.encode(vertex)

    [graph_name, "/", "vertex", "/", document_handle]
      |> build_url(opts)
      |> Arangoex.patch(body, opts)
  end
end
