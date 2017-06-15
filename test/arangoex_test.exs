defmodule ArangoexTest do
  use ExUnit.Case, async: true

  test "start_link() connects to the database" do
    {:ok, conn} = Arangoex.start_link()
    assert is_pid(conn)
  end

  # todo - test start_link() with opts
  # todo - test request
end
