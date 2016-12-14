defmodule Arangoex.Graph.Traversal do
  @moduledoc false

  alias Arangoex.JSON

  use Arangoex, base_url: ["/", "_api", "/", "traversal"]

  # POST /_api/traversal
  # Perform a graph traversal starting from a single vertex.
  def traverse(%{} = traversal, headers \\ [], opts \\ []) do
    {:ok, body} = JSON.encode(traversal)

    []
      |> build_url(opts)
      |> Arangoex.post(body, headers, opts)
  end
end
