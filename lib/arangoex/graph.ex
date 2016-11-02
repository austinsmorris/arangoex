defmodule Arangoex.Graph do
  @moduledoc false

  alias Arangoex.JSON

  @base_url "/_api/gharial"

  # POST /_api/gharial/{graph-name}/vertex
  # DELETE /_api/gharial/{graph-name}/vertex/{collection-name}
  # POST /_api/gharial/{graph-name}/vertex/{collection-name}
  # PATCH /_api/gharial/{graph-name}/vertex/{collection-name}/{vertex-key}
  # PUT /_api/gharial/{graph-name}/vertex/{collection-name}/{vertex-key}
  # DELETE /_api/gharial/{graph-name}/vertex/{collection-name}/{vertex-key}

  # POST /_api/gharial/{graph-name}/edge
  # PUT /_api/gharial/{graph-name}/edge/{definition-name}
  # DELETE /_api/gharial/{graph-name}/edge/{definition-name}
  # POST /_api/gharial/{graph-name}/edge/{collection-name}
  # PATCH /_api/gharial/{graph-name}/edge/{collection-name}/{edge-key}
  # PUT /_api/gharial/{graph-name}/edge/{collection-name}/{edge-key}
  # DELETE /_api/gharial/{graph-name}/edge/{collection-name}/{edge-key}

  # POST /_api/gharial
  # Create a new graph.
  def create(graph) do
    {:ok, body} = JSON.encode(graph)
    [] |> build_url() |> Arangoex.post(body)
  end

  # GET /_api/gharial/{graph-name}
  # Return the graph identified by graph-name.
  def get(graph_name) do
    graph_name |> build_url |> Arangoex.get()
  end

  # GET /_api/gharial/{graph-name}/edge/{collection-name}/{edge-key}
  # Return the edge identified by document-handle in the graph identified by graph-name
  def get_edge(graph_name, document_handle) do
    [graph_name, "/", "edge", "/", document_handle] |> build_url() |> Arangoex.get()
  end

  # GET /_api/gharial/{graph-name}/vertex/{collection-name}/{vertex-key}
  # Return the vertex identified by document-handle in the graph identified by graph-name
  def get_vertex(graph_name, document_handle) do
    [graph_name, "/", "vertex", "/", document_handle] |> build_url() |> Arangoex.get()
  end

  # GET /_api/gharial
  # List all graphs in the database.
  def list() do
    [] |> build_url() |> Arangoex.get()
  end

  # GET /_api/gharial/{graph-name}/edge
  # List all edge collection in the graph identified by graph-name
  def list_edges(graph_name) do
    [graph_name, "/", "edge"] |> build_url() |> Arangoex.get()
  end

  # GET /_api/gharial/{graph-name}/vertex
  # List all vertex collection in the graph identified by graph-name
  def list_vertices(graph_name) do
    [graph_name, "/", "vertex"] |> build_url() |> Arangoex.get()
  end

  # DELETE /_api/gharial/{graph-name}
  # Remove the graph identified by graph-name from the database.
  def remove(graph_name) do
    # todo - dropCollections parameter
    graph_name |> build_url() |> Arangoex.delete()
  end

  defp build_url(url_part) do
    IO.inspect [Arangoex.add_base_url(@base_url), "/", url_part]
  end
end
