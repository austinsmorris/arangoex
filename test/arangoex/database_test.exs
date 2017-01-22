defmodule Arangoex.DatabaseTest do
  alias Arangoex.Database
  alias Arangoex.JSON

  use ExUnit.Case, async: true

  test "create() creates a new database" do
    {:ok, response} = Database.create(%{name: "foo"})
    body = JSON.decode!(response.body, keys: :atoms)

    assert body.code == 201
    assert body.error === false
    assert body.result === true

    {:ok, response} =Database.list()
    body = JSON.decode!(response.body, keys: :atoms)

    assert Enum.member?(body.result, "foo")


  end

  test "get_current() returns info about current database" do
    {:ok, response} = Database.get_current()
    body = JSON.decode!(response.body, keys: :atoms)

    assert body.code == 200
    assert body.error === false
    assert is_binary(body.result.id)
    assert body.result.isSystem === false
    assert body.result.name === "test"
    assert is_binary(body.result.path)
  end

  test "list()" do
    {:ok, response} = Database.list()
    body = JSON.decode!(response.body, keys: :atoms)

    assert body.code == 200
    assert body.error === false
    assert is_list(body.result)
    assert Enum.member?(body.result, "test")
    assert Enum.member?(body.result, "_system")
  end

#  test "list_for_current_user()" do
#    # todo - create the databse for a different user
#    Database.create(%{name: "foo"})
#
#    # todo - list databases for that different user
#    {:ok, response} = Database.list_for_current_user()
#    body = JSON.decode!(response.body, keys: :atoms)
#    IO.inspect body
#
#    Database.remove("foo")
#  end

  test "remove() deletes the given database" do
    Database.create(%{name: "foo"})
    {:ok, response} = Database.remove("foo")
    body = JSON.decode!(response.body, keys: :atoms)
    assert body.code == 200
    assert body.result === true
    assert body.error === false

    {:ok, response} =Database.list()
    body = JSON.decode!(response.body, keys: :atoms)

    refute Enum.member?(body.result, "foo")
  end
end
