defmodule Arangoex.DatabaseTest do
  alias Arangoex.Database

  use ExUnit.Case, async: false

  setup do
    # make sure "foo" database does not exist for tests
    Database.remove(:arango, "foo", database: "_system")

    on_exit fn ->
      # make sure "foo" database is removed from any test
      Database.remove(:arango, "foo", database: "_system")
    end
  end

  test "create() creates a new database." do
    {:ok, resp} = Database.create(:arango, %{name: "foo"}, database: "_system")

    assert resp.status_code == 201
    assert resp.body["code"] == 201
    assert resp.body["error"] === false
    assert resp.body["result"] === true

    {:ok, list_resp} = Database.list(:arango)

    assert Enum.member?(list_resp.body["result"], "foo")
  end

  test "current() returns info about current database." do
    {:ok, resp} = Database.current(:arango)

    assert resp.status_code == 200
    assert resp.body["code"] == 200
    assert resp.body["error"] === false
    assert is_binary(resp.body["result"]["id"])
    assert resp.body["result"]["isSystem"] === false
    assert resp.body["result"]["name"] === "test"
    assert is_binary(resp.body["result"]["path"])
  end

  test "list() returns information about databases in the system." do
    {:ok, resp} = Database.list(:arango)

    assert resp.status_code == 200
    assert resp.body["code"] == 200
    assert resp.body["error"] === false
    assert is_list(resp.body["result"])
    assert Enum.member?(resp.body["result"], "test")
    assert Enum.member?(resp.body["result"], "_system")
  end

  test "list_for_current_user() returns information about databases for the current user." do
    {:ok, resp} = Database.list_for_current_user(:arango)

    assert resp.status_code == 200
    assert resp.body["code"] == 200
    assert resp.body["error"] === false
    assert is_list(resp.body["result"])
    assert Enum.member?(resp.body["result"], "test")
    assert Enum.member?(resp.body["result"], "_system")
  end

  test "remove() deletes the given database." do
    Database.create(:arango, %{name: "foo"}, database: "_system")
    {:ok, resp} = Database.remove(:arango, "foo", database: "_system")

    assert resp.status_code == 200
    assert resp.body["code"] == 200
    assert resp.body["result"] === true
    assert resp.body["error"] === false

    {:ok, list_resp} = Database.list(:arango)

    refute Enum.member?(list_resp.body["result"], "foo")
  end
end
