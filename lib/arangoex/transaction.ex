defmodule Arangoex.Transaction do
  @moduledoc false

#  alias Arangoex.JSON

#  use Arangoex, base_url: ["/", "_api", "/", "transaction"]

  # POST /_api/transaction
  # Execute a transaction.
  def execute(%{} = transaction, opts \\ []) do
#    {:ok, body} = JSON.encode(transaction)
#
#    []
#      |> build_url(opts)
#      |> Arangoex.post(body, opts)
  end
end
