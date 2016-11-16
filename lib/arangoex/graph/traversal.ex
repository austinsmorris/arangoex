defmodule Arangoex.Graph.Traversal do
  @moduledoc false

  alias Arangoex.JSON

  @base_url "/_api/traversal"

  # POST /_api/traversal
  # Perform a graph traversal starting from a single vertex.
  def traverse(traversal) do
    {:ok, body} = JSON.encode(traversal)
    [] |> build_url() |> Arangoex.post(body)
  end

  defp build_url([]), do: [Arangoex.add_base_url(@base_url)]
  defp build_url(url_part), do: [Arangoex.add_base_url(@base_url), "/", url_part]
end
