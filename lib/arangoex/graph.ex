defmodule Arangoex.Graph do
  @moduledoc """
  This module contains functions used to manage graph structures, vertex document collections, and edge document
  collections.
  """

  @doc """
  Add an edge definition to the given graph.

  The `conn` parameter is an ArangoDB connection PID.  The `graph_name` paramter is the string name of the graph to
  which the edge definition is added.  The `edges` parameter is a map containing the edge definition.

  ## Endpoint

  POST /_api/gharial/{graph_name}/edge

  ## Options

  See the "Shared Options" in the `Arangoex` module documentation for additional options.

  ## Examples

      {:ok, conn} = Arangoex.start_link()
      edge_def = %{collection: "my_edges", from: ["foo", "bar"], to: ["baz"]}
      {:ok, resp} = Arangoex.Graph.add_edges(conn, "my_graph", edge_def)
  """
  def add_edges(conn, graph_name, edges, opts \\ []) do
    Arangoex.request(conn, :post, "/_api/gharial/#{graph_name}/edge", %{}, %{}, edges, opts)
  end

  @doc """
  Add a vertex collection to the given graph.  Create the collection if it does not exist.

  The `conn` parameter is an ArangoDB connection PID.  The `graph_name` paramter is the string name of the graph to
  which the vertex collection is added.  The `vertices` parameter is a map containing a `:collection` property with the
  string name of the collection.

  ## Endpoint

  POST /_api/gharial/{graph_name}/vertex

  ## Options

  See the "Shared Options" in the `Arangoex` module documentation for additional options.

  ## Examples

      {:ok, conn} = Arangoex.start_link()
      {:ok, resp} = Arangoex.Graph.add_vertices(conn, "my_graph", %{collection: "my_vertices"}

  """
  def add_vertices(conn, graph_name, vertices, opts \\ []) do
    Arangoex.request(conn, :post, "/_api/gharial/#{graph_name}/vertex", %{}, %{}, vertices, opts)
  end

  @doc """
  Create a new graph.

  The `conn` parameter is an ArangoDB connection PID.  The `graph` parameter is a map containing the graph definition.

  ## Endpoint

  POST /_api/gharial

  ## Options

  See the "Shared Options" in the `Arangoex` module documentation for additional options.

  ## Examples

      {:ok, conn} = Arangoex.start_link()
      edge_def = %{collection: "my_edges", from: ["my_vertices"], to: ["my_other_vertices"]}
      graph_def = %{name: "my_graph", edgeDefinitions: [edge_def]}
      Arangoex.Graph.create(graph_def)
  """
  def create(conn, graph, opts \\ []) do
    Arangoex.request(conn, :post, "/_api/gharial", %{}, %{}, graph, opts)
  end

  @doc """
  Create an edge in the given edge collection for the given graph.

  The `conn` parameter is an ArangoDB connection PID.  The `graph_name` paramter is the string name of the graph to
  which the edge is added.  The `collection_name` parameter is the string name of the edge collection to which the new
  edge is added.  The `edge` parameter is a map containing the edge document.

  ## Endpoint

  POST  /_api/gharial/{graph_name}/edge/{collection_name}

  ## Options

  See the "Shared Options" in the `Arangoex` module documentation for additional options.

  ## Examples

      {:ok, conn} = Arangoex.start_link()
      {:ok, resp} = Arangoex.Graph.create_edge(conn, "my_graph", "my_edges, %{my_key: "my_value"})
  """
  def create_edge(conn, graph_name, collection_name, edge, opts \\ []) do
    Arangoex.request(conn, :post, "/_api/gharial/#{graph_name}/edge/#{collection_name}", %{}, %{}, edge, opts)
  end

  @doc """
  Create a vertex in the given vertex collection for the given graph.

  The `conn` parameter is an ArangoDB connection PID.  The `graph_name` paramter is the string name of the graph to
  which the vertex is added.  The `collection_name` parameter is the string name of the vertex collection to which the
  new vertex is added.  The `vertex` parameter is a map containing the vertex document.

  ## Endpoint

  POST  /_api/gharial/{graph_name}/vertex/{collection_name}

  ## Options

  See the "Shared Options" in the `Arangoex` module documentation for additional options.

  ## Examples

      {:ok, conn} = Arangoex.start_link()
      {:ok, resp} = Arangoex.Graph.create_vertex(conn, "my_graph", "my_vertices, %{my_key: "my_value"})
  """
  def create_vertex(conn, graph_name, collection_name, vertex, opts \\ []) do
    Arangoex.request(conn, :post, "/_api/gharial/#{graph_name}/vertex/#{collection_name}", %{}, %{}, vertex, opts)
  end

  @doc """
  Return information about the given graph.

  The `conn` parameter is an ArangoDB connection PID.  The `graph_name` parameter is the string name of the requested
  graph.

  ## Endpoint

  GET /_api/gharial/{graph_name}

  ## Options

  See the "Shared Options" in the `Arangoex` module documentation for additional options.

  ## Examples

      {:ok, conn} = Arangoex.start_link()
      {:ok, resp} = Arangoex.Graph.get(conn, "foo")
  """
  def get(conn, graph_name, opts \\ []) do
    Arangoex.request(conn, :get, "/_api/gharial/#{graph_name}", %{}, %{}, nil, opts)
  end

  @doc """
  Return the given edge.

  The `conn` parameter is an ArangoDB connection PID.  The `graph_name` paramter is the string name of the graph
  containing the edge.  The `document_handle` parameter is the string `_id` of the edge document.

  ## Endpoint

  GET /_api/gharial/{graph_name}/edge/{collection_name}/{edge_key}

  ## Options

  See the "Shared Options" in the `Arangoex` module documentation for additional options.

  ## Examples

      {:ok, conn} = Arangoex.start_link()
      {:ok, resp} = Arangoex.Graph.get_edge(conn, "my_graph", "my_edges/edge_key")
  """
  def get_edge(conn, graph_name, document_handle, opts \\ []) do
    Arangoex.request(conn, :get, "/_api/gharial/#{graph_name}/edge/#{document_handle}", %{}, %{}, nil, opts)
  end

  @doc """
  Return the given vertex.

  The `conn` parameter is an ArangoDB connection PID.  The `graph_name` paramter is the string name of the graph
  containing the vertex.  The `document_handle` parameter is the string `_id` of the vertex document.

  ## Endpoint

  GET /_api/gharial/{graph_name}/vertex/{collection_name}/{vetex_key}

  ## Options

  See the "Shared Options" in the `Arangoex` module documentation for additional options.

  ## Examples

      {:ok, conn} = Arangoex.start_link()
      {:ok, resp} = Arangoex.Graph.get_vertex(conn, "my_graph", "my_vertices/vertex_key")
  """
  def get_vertex(conn, graph_name, document_handle, opts \\ []) do
    Arangoex.request(conn, :get, "/_api/gharial/#{graph_name}/vertex/#{document_handle}", %{}, %{}, nil, opts)
  end

  @doc """
  Return information about all graphs in the current database.

  The `conn` parameter is an ArangoDB connection PID.

  ## Endpoint

  GET /_api/gharial

  ## Options

  See the "Shared Options" in the `Arangoex` module documentation for additional options.

  ## Examples

      {:ok, conn} = Arangoex.start_link()
      {:ok, resp} = Arangoex.Graph.list(conn)
  """
  def list(conn, opts \\ []) do
    Arangoex.request(conn, :get, "/_api/gharial", %{}, %{}, nil, opts)
  end

  @doc """
  Return a list of edge collections in a graph.

  The `conn` parameter is an ArangoDB connection PID.  The `graph_name` paramter is the string name of the graph
  containing the edge collections.

  ## Endpoint

  GET /_api/gharial/{graph_name}/edge

  ## Options

  See the "Shared Options" in the `Arangoex` module documentation for additional options.

  ## Examples

      {:ok, conn} = Arangoex.start_link()
      {:ok, resp} = Arangoex.Graph.list_edges(conn)
  """
  def list_edges(conn, graph_name, opts \\ []) do
    Arangoex.request(conn, :get, "/_api/gharial/#{graph_name}/edge", %{}, %{}, nil, opts)
  end

  @doc """
  Return a list of vertex collections in a graph.

  The `conn` parameter is an ArangoDB connection PID.  The `graph_name` paramter is the string name of the graph
  containing the vertex collections.

  ## Endpoint

  GET /_api/gharial/{graph_name}/vertex

  ## Options

  See the "Shared Options" in the `Arangoex` module documentation for additional options.

  ## Examples

      {:ok, conn} = Arangoex.start_link()
      {:ok, resp} = Arangoex.Graph.list_vertices(conn)
  """
  def list_vertices(conn, graph_name, opts \\ []) do
    Arangoex.request(conn, :get, "/_api/gharial/#{graph_name}/vertex", %{}, %{}, nil, opts)
  end

  @doc """
  Remove the given graph.

  The `conn` parameter is an ArangoDB connection PID.  The `graph_name` parameter is the string name of the graph to be
  removed.

  ## Endpoint

  DELETE /_api/gharial/{graph_name}

  ## Options

  See the "Shared Options" in the `Arangoex` module documentation for additional options.

  ## Examples

      {:ok, conn} = Arangoex.start_link()
      {:ok, resp} = Arangoex.Graph.remove(conn, "foo")
  """
  def remove(conn, graph_name, opts \\ []) do
    Arangoex.request(conn, :delete, "/_api/gharial/#{graph_name}", %{}, %{}, nil, opts)
  end

  @doc """
  Remove the given edge from the graph.

  The `conn` parameter is an ArangoDB connection PID.  The `graph_name` parameter is the string name of the graph
  containing the edge to be removed.  The `document_handle` parameter is the string `_id` of the edge document.

  ## Endpoint

  DELETE /_api/gharial/{graph_name}/edge/{document_handle}

  ## Options

  See the "Shared Options" in the `Arangoex` module documentation for additional options.

  ## Examples

      {:ok, conn} = Arangoex.start_link()
      {:ok, resp} = Arangoex.Graph.remove_edge(conn, "foo", "my_edges/edge_key")
  """
  def remove_edge(conn, graph_name, document_handle, opts \\ []) do
    Arangoex.request(conn, :delete, "/_api/gharial/#{graph_name}/edge/#{document_handle}", %{}, %{}, nil, opts)
  end

  @doc """
  Remove the given edge definition from the graph.

  The `conn` parameter is an ArangoDB connection PID.  The `graph_name` parameter is the string name of the graph
  containing the edge definition to be removed.  The `defninition_name` parameter is the string name of the edge
  definition.

  ## Endpoint

  DELETE /_api/gharial/{graph_name}/edge/{defnition_name}

  ## Options

  See the "Shared Options" in the `Arangoex` module documentation for additional options.

  ## Examples

      {:ok, conn} = Arangoex.start_link()
      {:ok, resp} = Arangoex.Graph.remove_edges(conn, "foo", "my_edges")
  """
  def remove_edges(conn, graph_name, definition_name, opts \\ []) do
    Arangoex.request(conn, :delete, "/_api/gharial/#{graph_name}/edge/#{definition_name}", %{}, %{}, nil, opts)
  end

  @doc """
  Remove the given vertex from the graph.

  The `conn` parameter is an ArangoDB connection PID.  The `graph_name` parameter is the string name of the graph
  containing the vertex to be removed.  The `document_handle` parameter is the string `_id` of the vertex document.

  ## Endpoint

  DELETE /_api/gharial/{graph_name}/vertex/{document_handle}

  ## Options

  See the "Shared Options" in the `Arangoex` module documentation for additional options.

  ## Examples

      {:ok, conn} = Arangoex.start_link()
      {:ok, resp} = Arangoex.Graph.remove_vertex(conn, "foo", "my_vertices/vertex_key")
  """
  def remove_vertex(conn, graph_name, document_handle, opts \\ []) do
    Arangoex.request(conn, :delete, "/_api/gharial/#{graph_name}/vertex/#{document_handle}", %{}, %{}, nil, opts)
  end

  @doc """
  Remove the given vertex collection from the graph.

  The `conn` parameter is an ArangoDB connection PID.  The `graph_name` parameter is the string name of the graph
  containing the vertex collection to be removed.  The `collection_name` parameter is the string name of the vertex
  collection.

  ## Endpoint

  DELETE /_api/gharial/{graph_name}/vertex/{collection_name}

  ## Options

  See the "Shared Options" in the `Arangoex` module documentation for additional options.

  ## Examples

      {:ok, conn} = Arangoex.start_link()
      {:ok, resp} = Arangoex.Graph.remove_vertices(conn, "foo", "my_edges")
  """
  def remove_vertices(conn, graph_name, collection_name, opts \\ []) do
    Arangoex.request(conn, :delete, "/_api/gharial/#{graph_name}/vertex/#{collection_name}", %{}, %{}, nil, opts)
  end

  @doc """
  Replace the given edge in the graph.

  The `conn` parameter is an ArangoDB connection PID.  The `graph_name` parameter is the string name of the graph
  containing the edge to be replaced.  The `document_handle` parameter is the string `_id` of the edge document.

  ## Endpoint

  PUT /_api/gharial/{graph_name}/edge/{document_handle}

  ## Options

  See the "Shared Options" in the `Arangoex` module documentation for additional options.

  ## Examples

      {:ok, conn} = Arangoex.start_link()
      edge = %{_from: "vertices/vertex1", _to: "vertices/vertex2", new_key: "new_value"}
      {:ok, resp} = Arangoex.Graph.replace_edge(conn, "foo", "my_edges/edge_key", edge)
  """
  def replace_edge(conn, graph_name, document_handle, edge, opts \\ []) do
    Arangoex.request(conn, :put, "/_api/gharial/#{graph_name}/edge/#{document_handle}", %{}, %{}, edge, opts)
  end

  @doc """
  Replace the given edge definition in the graph.

  The `conn` parameter is an ArangoDB connection PID.  The `graph_name` parameter is the string name of the graph
  containing the edge definition to be replaced.  The `defninition_name` parameter is the string name of the edge
  definition.

  ## Endpoint

  PUT /_api/gharial/{graph_name}/edge/{defnition_name}

  ## Options

  See the "Shared Options" in the `Arangoex` module documentation for additional options.

  ## Examples

      {:ok, conn} = Arangoex.start_link()
      edge_def = %{collection: "my_edges", from: ["foo", "bar"], to: ["baz", "bat"]}
      {:ok, resp} = Arangoex.Graph.replace_edges(conn, "foo", "my_edges", edge_def)
  """
  def replace_edges(conn, graph_name, definition_name, edges, opts \\ []) do
    Arangoex.request(conn, :put, "/_api/gharial/#{graph_name}/edge/#{definition_name}", %{}, %{}, edges, opts)
  end

  @doc """
  Replace the given vertex in the graph.

  The `conn` parameter is an ArangoDB connection PID.  The `graph_name` parameter is the string name of the graph
  containing the vertex to be replaced.  The `document_handle` parameter is the string `_id` of the vertex document.

  ## Endpoint

  PUT /_api/gharial/{graph_name}/vertex/{document_handle}

  ## Options

  See the "Shared Options" in the `Arangoex` module documentation for additional options.

  ## Examples

      {:ok, conn} = Arangoex.start_link()
      {:ok, resp} = Arangoex.Graph.replace_vertex(conn, "foo", "my_vertices/vertex_key", %{new_key: "new_value"})
  """
  def replace_vertex(conn, graph_name, document_handle, vertex, opts \\ []) do
    Arangoex.request(conn, :put, "/_api/gharial/#{graph_name}/vertex/#{document_handle}", %{}, %{}, vertex, opts)
  end

  @doc """
  Update the given edge in the graph.

  The `conn` parameter is an ArangoDB connection PID.  The `graph_name` parameter is the string name of the graph
  containing the edge to be updated.  The `document_handle` parameter is the string `_id` of the edge document.

  ## Endpoint

  PATCH /_api/gharial/{graph_name}/edge/{document_handle}

  ## Options

  See the "Shared Options" in the `Arangoex` module documentation for additional options.

  ## Examples

      {:ok, conn} = Arangoex.start_link()
      {:ok, resp} = Arangoex.Graph.update_edge(conn, "foo", "my_edges/edge_key", %{new_key: "new_value})
  """
  def update_edge(conn, graph_name, document_handle, edge, opts \\ []) do
    Arangoex.request(conn, :patch, "/_api/gharial/#{graph_name}/edge/#{document_handle}", %{}, %{}, edge, opts)
  end

  @doc """
  Update the given vertex in the graph.

  The `conn` parameter is an ArangoDB connection PID.  The `graph_name` parameter is the string name of the graph
  containing the vertex to be updated.  The `document_handle` parameter is the string `_id` of the vertex document.

  ## Endpoint

  PATCH /_api/gharial/{graph_name}/vertex/{document_handle}

  ## Options

  See the "Shared Options" in the `Arangoex` module documentation for additional options.

  ## Examples

      {:ok, conn} = Arangoex.start_link()
      {:ok, resp} = Arangoex.Graph.update_vertex(conn, "foo", "my_vertices/vertex_key", %{new_key: "new_value"})
  """
  def update_vertex(conn, graph_name, document_handle, vertex, opts \\ []) do
    Arangoex.request(conn, :patch, "/_api/gharial/#{graph_name}/vertex/#{document_handle}", %{}, %{}, vertex, opts)
  end
end
