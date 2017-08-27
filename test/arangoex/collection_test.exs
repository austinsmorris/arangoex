defmodule Arangoex.CollectionTest do
  alias Arangoex.Collection

  use ExUnit.Case, async: false

  setup do
    # make sure "foo" collection does not exist for tests
    Collection.remove(:arango, "foo")

    on_exit fn ->
      # make sure "foo" collection is removed from any test
      Collection.remove(:arango, "foo")
    end
  end

  test "count() returns the number of documents in a collection" do
    # todo - create collection, create documents, count documents
  end

  test "create() creates a new collection." do
    {:ok, resp} = Collection.create(:arango, %{name: "foo"})

    assert resp.status_code == 200
    assert resp.body["code"] == 200
    assert resp.body["error"] === false
    assert is_binary(resp.body["id"])
    assert resp.body["isSystem"] === false
    assert resp.body["isVolatile"] === false
    assert resp.body["name"] === "foo"
    assert resp.body["status"] === 3 # todo - what does this mean?
    assert resp.body["type"] === 2 # todo - what does this mean?
    assert resp.body["waitForSync"] === false

    foo = %{"id" => resp.body["id"], "isSystem" => false, "name" => "foo", "status" => 3, "type" => 2}
    {:ok, resp} = Collection.list(:arango)

    assert Enum.member?(resp.body["result"], foo)
  end

  test "get() returns information about a collection" do
    Collection.create(:arango, %{name: "foo"})
    {:ok, resp} = Collection.get(:arango, "foo")

    assert resp.status_code == 200
    assert resp.body["code"] == 200
    assert resp.body["error"] === false
    assert is_binary(resp.body["id"])
    assert resp.body["isSystem"] === false
    assert resp.body["name"] === "foo"
    assert resp.body["status"] === 3 # todo - what does this mean?
    assert resp.body["type"] === 2 # todo - what does this mean?
  end

  test "checksum() returns the checksum for a collection" do
    Collection.create(:arango, %{name: "foo"})
    {:ok, resp} = Collection.checksum(:arango, "foo")

    assert resp.status_code == 200
    assert resp.body["code"] == 200
    assert resp.body["error"] === false
    assert is_binary(resp.body["id"])
    assert resp.body["isSystem"] === false
    assert resp.body["checksum"] === "0" # todo - what does this mean?
    assert resp.body["name"] === "foo"
    assert resp.body["status"] === 3 # todo - what does this mean?
    assert resp.body["type"] === 2 # todo - what does this mean?
    assert resp.body["revision"] === "0" # todo - what does this mean?
  end

  test "get_properties() returns the propeties of a collection" do
    Collection.create(:arango, %{name: "foo"})
    {:ok, resp} = Collection.get_properties(:arango, "foo")

    assert resp.status_code == 200
    assert resp.body["code"] == 200
    assert resp.body["error"] === false
    assert is_binary(resp.body["id"])
    assert is_integer(resp.body["journalSize"])
    assert resp.body["isSystem"] === false
    assert resp.body["isVolatile"] === false
    assert resp.body["doCompact"] === true
    assert resp.body["name"] === "foo"
    assert resp.body["status"] === 3 # todo - what does this mean?
    assert resp.body["type"] === 2 # todo - what does this mean?
    assert resp.body["waitForSync"] === false
    assert resp.body["keyOptions"] === %{"allowUserKeys" => true, "lastValue" => 0, "type" => "traditional"} # todo - what does this mean?
  end

  test "list() returns information about databases in the system." do
    {:ok, coll} = Collection.create(:arango, %{name: "foo"})
    {:ok, resp} = Collection.list(:arango)

    assert resp.status_code == 200
    assert resp.body["code"] == 200
    assert resp.body["error"] === false
    assert is_list(resp.body["result"])

    foo = %{"id" => coll.body["id"], "isSystem" => false, "name" => "foo", "status" => 3, "type" => 2}
    assert Enum.member?(resp.body["result"], foo)
  end

  test "load() loads a collection from memory" do
    Collection.create(:arango, %{name: "foo"})
    {:ok, resp} = Collection.load(:arango, "foo")

    assert resp.status_code == 200
    assert resp.body["code"] == 200
    assert resp.body["error"] === false
    assert is_binary(resp.body["id"])
    assert resp.body["count"] === 0
    assert resp.body["isSystem"] === false
    assert resp.body["name"] === "foo"
    assert resp.body["status"] === 3 # todo - what does this mean?
    assert resp.body["type"] === 2 # todo - what does this mean?
  end

  test "remove() deletes the given collection." do
    Collection.create(:arango, %{name: "foo"})
    {:ok, resp} = Collection.remove(:arango, "foo")

    assert resp.status_code == 200
    assert resp.body["code"] == 200
    assert resp.body["error"] === false
    assert is_binary(resp.body["id"])

    foo = %{"id" => resp.body["id"], "isSystem" => false, "name" => "foo", "status" => 3, "type" => 2}
    {:ok, resp} = Collection.list(:arango)

    refute Enum.member?(resp.body["result"], foo)
  end

  test "revision() returns the revision of the collection." do
    Collection.create(:arango, %{name: "foo"})
    {:ok, resp} = Collection.revision(:arango, "foo")

    assert resp.status_code == 200
    assert resp.body["code"] == 200
    assert resp.body["error"] === false
    assert is_binary(resp.body["id"])
    assert resp.body["revision"] === "0"
    assert resp.body["isSystem"] === false
    assert resp.body["name"] === "foo"
    assert resp.body["status"] === 3 # todo - what does this mean?
    assert resp.body["type"] === 2 # todo - what does this mean?
  end

  test "rotate() rotates the journal of a collection." do
    Collection.create(:arango, %{name: "foo"})
#    {:ok, resp} = Collection.rotate(:arango, "foo")

    # todo
#    assert resp.status_code == 200
#    assert resp.body["code"] == 200
#    assert resp.body["error"] === false
#    assert is_binary(resp.body["id"])
  end

  test "statistics() returns statistics about a a collection." do
    Collection.create(:arango, %{name: "foo"})
#    {:ok, resp} = Collection.statistics(:arango, "foo")

    # todo
#    assert resp.status_code == 200
#    assert resp.body["code"] == 200
#    assert resp.body["error"] === false
#    assert is_binary(resp.body["id"])
  end

  test "truncate() removes all documects from a collection, leaving indexes intact." do
    # todo
  end

  test "unload() unloads a collection from memory" do
    Collection.create(:arango, %{name: "foo"})
    Collection.load(:arango, "foo")
    {:ok, resp} = Collection.unload(:arango, "foo")

    assert resp.status_code == 200
    assert resp.body["code"] == 200
    assert resp.body["error"] === false
    assert is_binary(resp.body["id"])
    assert resp.body["isSystem"] === false
    assert resp.body["name"] === "foo"
#    assert resp.body["status"] === ? # todo - what does this mean? 2 or 4?
    assert resp.body["type"] === 2 # todo - what does this mean?
  end
end
