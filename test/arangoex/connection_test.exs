defmodule Arangoex.ConnectionTest do
  alias Arangoex.Connection, as: AConnection

  use ExUnit.Case, async: true

  test "start_link() connects to the database" do
    args = [host: :localhost, port: 8529, database: "test", username: "root", password: ""]
    {:ok, conn} = AConnection.start_link(args)
    assert is_pid(conn)
  end

  # todo - thorough connection tests
end
