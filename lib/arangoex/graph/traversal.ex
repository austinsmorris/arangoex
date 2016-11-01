defmodule Arangoex.Graph.Traversal do
  @moduledoc false

  alias Arangoex.JSON

  @base_url "/_api/traversal"

  # POST /_api/traversal
  # Perform a graph traversal starting from a single vertex.
  def traverse(traversal) do
    {:ok, body} = JSON.encode(traversal)
    Arangoex.add_base_url(@base_url) |> Arangoex.post(body)
  end
end
