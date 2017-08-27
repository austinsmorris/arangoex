defmodule Arangoex.UserTest do
  alias Arangoex.User

  use ExUnit.Case, async: false

  setup do
    # make sure "foo" user does not exist for tests
    User.remove(:arango, "foo")

    on_exit fn ->
      # make sure "foo" is removed from any test
      User.remove(:arango, "foo")
    end
  end

  test "create() creates a new user." do
    {:ok, resp} = User.create(:arango, %{user: "foo"})

    assert resp.status_code === 201
    assert resp.body["code"] === 201
    assert resp.body["error"] === false
    assert resp.body["active"] === true
    assert resp.body["extra"] === %{}
    assert resp.body["user"] === "foo"

    foo = %{"active" => true, "extra" => %{}, "user" => "foo"}
    {:ok, resp} = User.list(:arango)

    assert Enum.member?(resp.body["result"], foo)
  end

  test "database() shows information about databases a user has access to." do
    User.create(:arango, %{user: "foo"})
    User.grant(:arango, "foo", "test")
    {:ok, resp} = Arangoex.User.database(:arango, "foo")

    assert resp.status_code === 200
    assert resp.body["code"] === 200
    assert resp.body["error"] === false
    assert resp.body["result"] === %{"test" => "rw"}
  end

  test "get() show information about a user." do
    User.create(:arango, %{user: "foo"})
    {:ok, resp} = User.get(:arango, "foo")

    assert resp.status_code === 200
    assert resp.body["code"] === 200
    assert resp.body["error"] === false
    assert resp.body["active"] === true
    assert resp.body["extra"] === %{}
    assert resp.body["user"] === "foo"
  end

  test "grant() grants database access to a user." do
    User.create(:arango, %{user: "foo"})
    User.grant(:arango, "foo", "test")
    {:ok, resp} = Arangoex.User.database(:arango, "foo")

    assert resp.status_code === 200
    assert resp.body["code"] === 200
    assert resp.body["error"] === false
    assert resp.body["result"] === %{"test" => "rw"}
  end

  test "list() shows users in the system." do
    User.create(:arango, %{user: "foo"})
    {:ok, resp} = User.list(:arango)

    assert resp.status_code === 200
    assert resp.body["code"] === 200
    assert resp.body["error"] === false

    foo = %{"active" => true, "extra" => %{}, "user" => "foo"}
    assert Enum.member?(resp.body["result"], foo)
  end

  test "remove() removes a user from the system." do
    User.create(:arango, %{user: "foo"})
    {:ok, resp} = User.remove(:arango, "foo")

    assert resp.status_code === 202
    assert resp.body["code"] === 202
    assert resp.body["error"] === false

    {:ok, resp} = User.list(:arango)

    foo = %{"active" => true, "extra" => %{}, "user" => "foo"}
    refute Enum.member?(resp.body["result"], foo)
  end

  test "replace() replaces the properties of a user." do
    User.create(:arango, %{user: "foo"})
    {:ok, resp} = User.replace(:arango, "foo", %{active: false})

    assert resp.status_code === 200
    assert resp.body["code"] === 200
    assert resp.body["error"] === false
    assert resp.body["active"] === false
    assert resp.body["extra"] === %{}
    assert resp.body["user"] === "foo"

    {:ok, resp} = User.list(:arango)

    foo = %{"active" => false, "extra" => %{}, "user" => "foo"}
    assert Enum.member?(resp.body["result"], foo)
  end

  test "revoke() revokes database access from a user." do
    User.create(:arango, %{user: "foo"})
    User.grant(:arango, "foo", "test")
    {:ok, resp} = Arangoex.User.database(:arango, "foo")

    assert resp.status_code === 200
    assert resp.body["code"] === 200
    assert resp.body["error"] === false
    assert resp.body["result"] === %{"test" => "rw"}

    User.revoke(:arango, "foo", "test")
    {:ok, resp} = Arangoex.User.database(:arango, "foo")

    assert resp.status_code === 200
    assert resp.body["code"] === 200
    assert resp.body["error"] === false
    assert resp.body["result"] === %{}
  end

  test "update() updates the properties of a user." do
    User.create(:arango, %{user: "foo"})
    {:ok, resp} = User.replace(:arango, "foo", %{active: false})

    assert resp.status_code === 200
    assert resp.body["code"] === 200
    assert resp.body["error"] === false
    assert resp.body["active"] === false
    assert resp.body["extra"] === %{}
    assert resp.body["user"] === "foo"

    {:ok, resp} = User.list(:arango)

    foo = %{"active" => false, "extra" => %{}, "user" => "foo"}
    assert Enum.member?(resp.body["result"], foo)
  end
end
