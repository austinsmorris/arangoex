defmodule Arangoex.Graph do
  @moduledoc false

  alias Arangoex.JSON

  use Arangoex, base_url: ["/", "_api", "/", "gharial"]

  # POST /_api/gharial/{graph-name}/edge
  # Add an edge definition to the graph identified by graph-name.
  def add_edges(graph_name, edges, opts \\ []) do
    {:ok, body} = JSON.encode(edges)

    [graph_name, "/", "edge"]
      |> build_url(opts)
      |> Arangoex.post(body, Keyword.get(opts, :headers, []), opts)
  end

  # POST /_api/gharial/{graph-name}/vertex
  # Add a vertex collection to the graph identified by graph-name.  Create the collection if it does not exist.
  def add_vertices(graph_name, vertices, opts \\ []) do
    {:ok, body} = JSON.encode(vertices)

    [graph_name, "/", "vertex"]
      |> build_url(opts)
      |> Arangoex.post(body, Keyword.get(opts, :headers, []), opts)
  end

  # POST /_api/gharial
  # Create a new graph.
  def create(graph, opts \\ []) do
    {:ok, body} = JSON.encode(graph)

    []
      |> build_url(opts)
      |> Arangoex.post(body, Keyword.get(opts, :headers, []), opts)
  end

  # POST /_api/gharial/{graph-name}/edge/{collection-name}
  # Create an edge in the collection identified by collection-name in the graph identified by graph-name.
  def create_edge(graph_name, collection_name, edge, opts \\ []) do
    {:ok, body} = JSON.encode(edge)

    [graph_name, "/", "edge", "/", collection_name]
      |> build_url(opts)
      |> Arangoex.post(body, Keyword.get(opts, :headers, []), opts)
  end

  # POST /_api/gharial/{graph-name}/vertex/{collection-name}
  # Create a vertex in the collection identified by collection-name in the graph identified by graph-name.
  def create_vertex(graph_name, collection_name, vertex, opts \\ []) do
    {:ok, body} = JSON.encode(vertex)

    [graph_name, "/", "vertex", "/", collection_name]
      |> build_url(opts)
      |> Arangoex.post(body, Keyword.get(opts, :headers, []), opts)
  end

  # GET /_api/gharial/{graph-name}
  # Return the graph identified by graph-name.
  def get(graph_name, opts \\ []) do
    graph_name
      |> build_url(opts)
      |> Arangoex.get(Keyword.get(opts, :headers, []), opts)
  end

  # GET /_api/gharial/{graph-name}/edge/{collection-name}/{edge-key}
  # Return the edge identified by document-handle in the graph identified by graph-name
  def get_edge(graph_name, document_handle, opts \\ []) do
    [graph_name, "/", "edge", "/", document_handle]
      |> build_url(opts)
      |> Arangoex.get(Keyword.get(opts, :headers, []), opts)
  end

  # GET /_api/gharial/{graph-name}/vertex/{collection-name}/{vertex-key}
  # Return the vertex identified by document-handle in the graph identified by graph-name
  def get_vertex(graph_name, document_handle, opts \\ []) do
    [graph_name, "/", "vertex", "/", document_handle]
      |> build_url(opts)
      |> Arangoex.get(Keyword.get(opts, :headers, []), opts)
  end

  # GET /_api/gharial
  # List all graphs in the database.
  def list(opts \\ []) do
    []
      |> build_url(opts)
      |> Arangoex.get(Keyword.get(opts, :headers, []), opts)
  end

  # GET /_api/gharial/{graph-name}/edge
  # List all edge collection in the graph identified by graph-name
  def list_edges(graph_name, opts \\ []) do
    [graph_name, "/", "edge"]
      |> build_url(opts)
      |> Arangoex.get(Keyword.get(opts, :headers, []), opts)
  end

  # GET /_api/gharial/{graph-name}/vertex
  # List all vertex collection in the graph identified by graph-name
  def list_vertices(graph_name, opts \\ []) do
    [graph_name, "/", "vertex"]
      |> build_url(opts)
      |> Arangoex.get(Keyword.get(opts, :headers, []), opts)
  end

  # DELETE /_api/gharial/{graph-name}
  # Remove the graph identified by graph-name from the database.
  def remove(graph_name, opts \\ []) do
    # todo - dropCollections parameter
    graph_name
      |> build_url(opts)
      |> Arangoex.delete(Keyword.get(opts, :headers, []), opts)
  end

  # DELETE /_api/gharial/{graph-name}/edge/{document-handle}
  # Remove the edge identified by document-handle in the graph identified by graph-name
  def remove_edge(graph_name, document_handle, opts \\ []) do
    [graph_name, "/", "edge", "/", document_handle]
      |> build_url(opts)
      |> Arangoex.delete(Keyword.get(opts, :headers, []), opts)
  end

  # DELETE /_api/gharial/{graph-name}/edge/{definition-name}
  # Remove the edge definition identified by definition-name from the graph identified by graph-name.
  def remove_edges(graph_name, definition_name, opts \\ []) do
    [graph_name, "/", "edge", "/", definition_name]
      |> build_url(opts)
      |> Arangoex.delete(Keyword.get(opts, :headers, []), opts)
  end

  # DELETE /_api/gharial/{graph-name}/vertex/{collection-name}
  # Remove the vertex collection identified by collection-name from the graph identified by graph-name.
  def remove_vertices(graph_name, collection_name, opts \\ []) do
    [graph_name, "/", "vertex", "/", collection_name]
      |> build_url(opts)
      |> Arangoex.delete(Keyword.get(opts, :headers, []), opts)
  end

  # DELETE /_api/gharial/{graph-name}/vertex/{document-handle}
  # Remove the vertex identified by document-handle in the graph identified by graph-name
  def remove_vertex(graph_name, document_handle, opts \\ []) do
    [graph_name, "/", "vertex", "/", document_handle]
      |> build_url(opts)
      |> Arangoex.delete(Keyword.get(opts, :headers, []), opts)
  end

  # PUT /_api/gharial/{graph-name}/edge/{document-handle}
  # Replace the edge identified by document-handle in the graph identified by graph-name
  def replace_edge(graph_name, document_handle, edge, opts \\ []) do
    {:ok, body} = JSON.encode(edge)

    [graph_name, "/", "edge", "/", document_handle]
      |> build_url(opts)
      |> Arangoex.put(body, Keyword.get(opts, :headers, []), opts)
  end

  # PUT /_api/gharial/{graph-name}/edge/{definition-name}
  # Replace the edge definition identified by definition-name in the graph identified by graph-name.
  def replace_edges(graph_name, definition_name, edges, opts \\ []) do
    {:ok, body} = JSON.encode(edges)

    [graph_name, "/", "edge", "/", definition_name]
      |> build_url(opts)
      |> Arangoex.put(body, Keyword.get(opts, :headers, []), opts)
  end

  # PUT /_api/gharial/{graph-name}/vertex/{document-handle}
  # Replace the vertex identified by document-handle in the graph identified by graph-name
  def replace_vertex(graph_name, document_handle, vertex, opts \\ []) do
    {:ok, body} = JSON.encode(vertex)

    [graph_name, "/", "vertex", "/", document_handle]
      |> build_url(opts)
      |> Arangoex.put(body, Keyword.get(opts, :headers, []), opts)
  end

  # PATCH /_api/gharial/{graph-name}/edge/{document-handle}
  # Update the edge identified by document-handle at the graph identified by graph-name.
  def update_edge(graph_name, document_handle, edge, opts \\ []) do
    {:ok, body} = JSON.encode(edge)

    [graph_name, "/", "edge", "/", document_handle]
      |> build_url(opts)
      |> Arangoex.patch(body, Keyword.get(opts, :headers, []), opts)
  end

  # PATCH /_api/gharial/{graph-name}/vertex/{document-handle}
  # Update the vertex identified by document-handle in the graph identified by graph-name.
  def update_vertex(graph_name, document_handle, vertex, opts \\ []) do
    {:ok, body} = JSON.encode(vertex)

    [graph_name, "/", "vertex", "/", document_handle]
      |> build_url(opts)
      |> Arangoex.patch(body, Keyword.get(opts, :headers, []), opts)
  end
end
