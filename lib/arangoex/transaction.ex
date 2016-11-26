defmodule Arangoex.Transaction do
  @moduledoc false

  alias Arangoex.JSON

  @base_url ["/", "_api", "/", "transaction"]

  # POST /_api/transaction
  # Execute a transaction.
  def execute(%{} = transaction) do
    {:ok, body} = JSON.encode(transaction)
    [] |> build_url() |> Arangoex.post(body)
  end

  defp build_url([]), do: [Arangoex.add_base_url(@base_url)]
  defp build_url(url_part), do: [Arangoex.add_base_url(@base_url), "/", url_part]
end
