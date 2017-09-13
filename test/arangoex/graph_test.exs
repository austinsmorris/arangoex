defmodule Arangoex.GraphTest do
  alias Arangoex.Collection
  alias Arangoex.Graph

  use ExUnit.Case, async: false

  setup do
    Graph.remove(:arango, "foo")

    on_exit fn ->
      Graph.remove(:arango, "foo")
    end
  end

  test "add_edges() adds an edge definition to a graph" do
    {:ok, %{status_code: 202}} = Graph.create(:arango, %{name: "foo"})
    {:ok, %{status_code: 200}} = Collection.create(:arango, %{name: "bar"})
    {:ok, %{status_code: 200}} = Collection.create(:arango, %{name: "baz"})
    {:ok, %{status_code: 200}} = Collection.create(:arango, %{name: "my_edges", type: 3})
    edge_def = %{collection: "my_edges", from: ["bar"], to: ["baz"]}
    returned_edge_def = %{"collection" => "my_edges", "from" => ["bar"], "to" => ["baz"]}
    {:ok, resp} = Graph.add_edges(:arango, "foo", edge_def)

    assert resp.status_code == 202
    assert Enum.member?(resp.body["graph"]["edgeDefinitions"], returned_edge_def)

    {:ok, %{status_code: 200}} = Collection.remove(:arango, "bar")
    {:ok, %{status_code: 200}} = Collection.remove(:arango, "baz")
    {:ok, %{status_code: 200}} = Collection.remove(:arango, "my_edges")
  end

  test "add_vertices() adds a vertex collection to a graph" do
    {:ok, %{status_code: 202}} = Graph.create(:arango, %{name: "foo"})
    {:ok, resp} = Graph.add_vertices(:arango, "foo", %{collection: "bar"})

    assert resp.status_code == 202
    assert Enum.member?(resp.body["graph"]["orphanCollections"], "bar")

    {:ok, %{status_code: 200}} = Collection.remove(:arango, "bar")
  end

  test "create() creates a new graph" do
    {:ok, resp} = Graph.create(:arango, %{name: "foo"})

    assert resp.status_code == 202
    assert resp.body["code"] == 202
    assert resp.body["error"] == false
    assert resp.body["graph"]["name"] == "foo"
    assert resp.body["graph"]["edgeDefinitions"] == []
    assert resp.body["graph"]["orphanCollections"] == []
    assert resp.body["graph"]["isSmart"] == false
    assert resp.body["graph"]["numberOfShards"] == 0
    assert resp.body["graph"]["smartGraphAttribute"] == ""
    assert resp.body["graph"]["_id"] == "_graphs/foo"
    assert is_binary(resp.body["graph"]["_rev"])
  end

  test "create_edge()" do
    create_standard_graph()
    {:ok, %{body: %{"vertex" => %{"_id" => id1}}}} = Graph.create_vertex(:arango, "foo", "bar", %{my_key: "my_value"})
    {:ok, %{body: %{"vertex" => %{"_id" => id2}}}} = Graph.create_vertex(:arango, "foo", "baz", %{my_key: "my_value"})
    {:ok, resp} = Graph.create_edge(:arango, "foo", "my_edges", %{_from: id1, _to: id2, my_key: "my_value"})

    assert resp.status_code == 202
    assert resp.body["code"] == 202
    assert resp.body["error"] === false
    assert is_binary(resp.body["edge"]["_id"])
    assert is_binary(resp.body["edge"]["_key"])
    assert is_binary(resp.body["edge"]["_rev"])

    remove_standard_graph()
  end

  test "create_vertex()" do
    create_standard_graph()
    {:ok, resp} = Graph.create_vertex(:arango, "foo", "bar", %{my_key: "my_value"})

    assert resp.status_code == 202
    assert resp.body["code"] == 202
    assert resp.body["error"] === false
    assert is_binary(resp.body["vertex"]["_id"])
    assert is_binary(resp.body["vertex"]["_key"])
    assert is_binary(resp.body["vertex"]["_rev"])

    remove_standard_graph()
  end

  test "get() returns information about the given graph" do
    {:ok, %{status_code: 202}} = Graph.create(:arango, %{name: "foo"})
    {:ok, resp} = Graph.get(:arango, "foo")

    assert resp.status_code == 200
    assert resp.body["code"] == 200
    assert resp.body["error"] === false
    assert resp.body["graph"]["name"] == "foo"
    assert resp.body["graph"]["edgeDefinitions"] == []
    assert resp.body["graph"]["orphanCollections"] == []
    assert resp.body["graph"]["isSmart"] == false
    assert resp.body["graph"]["numberOfShards"] == 1
    assert resp.body["graph"]["smartGraphAttribute"] == ""
    assert resp.body["graph"]["_id"] == "_graphs/foo"
    assert is_binary(resp.body["graph"]["_rev"])
  end

  test "get_edge() returns information about an edge" do
    create_standard_graph()
    {:ok, %{body: %{"vertex" => %{"_id" => id1}}}} = Graph.create_vertex(:arango, "foo", "bar", %{my_key: "my_value"})
    {:ok, %{body: %{"vertex" => %{"_id" => id2}}}} = Graph.create_vertex(:arango, "foo", "baz", %{my_key: "my_value"})
    edge = %{_from: id1, _to: id2, my_key: "my_value"}
    {:ok, %{body: %{"edge" => %{"_id" => edge_id}}}} = Graph.create_edge(:arango, "foo", "my_edges", edge)
    {:ok, resp} = Graph.get_edge(:arango, "foo", edge_id)

    assert resp.status_code == 200
    assert resp.body["code"] == 200
    assert resp.body["error"] === false
    assert resp.body["edge"]["_id"] == edge_id
    assert resp.body["edge"]["_from"] == id1
    assert resp.body["edge"]["_to"] == id2
    assert resp.body["edge"]["my_key"] == "my_value"
    assert is_binary(resp.body["edge"]["_key"])
    assert is_binary(resp.body["edge"]["_rev"])

    remove_standard_graph()
  end

  test "get_vertex() returns information about a vertex" do
    create_standard_graph()
    {:ok, %{body: %{"vertex" => %{"_id" => id}}}} = Graph.create_vertex(:arango, "foo", "bar", %{my_key: "my_value"})
    {:ok, resp} = Graph.get_vertex(:arango, "foo", id)

    assert resp.status_code == 200
    assert resp.body["code"] == 200
    assert resp.body["error"] === false
    assert resp.body["vertex"]["_id"] == id
    assert resp.body["vertex"]["my_key"] == "my_value"
    assert is_binary(resp.body["vertex"]["_key"])
    assert is_binary(resp.body["vertex"]["_rev"])

    remove_standard_graph()
  end

  test "list() returns information about all graphs in the database" do
    {:ok, %{status_code: 202}} = Graph.create(:arango, %{name: "foo"})
    {:ok, %{status_code: 202}} = Graph.create(:arango, %{name: "bar"})
    {:ok, resp} = Graph.list(:arango)

    assert resp.status_code == 200
    assert resp.body["code"] == 200
    assert resp.body["error"] === false
    assert length(resp.body["graphs"]) == 2
    assert Enum.at(resp.body["graphs"], 0)["_id"] == "_graphs/foo"
    assert Enum.at(resp.body["graphs"], 1)["_id"] == "_graphs/bar"

    {:ok, %{status_code: 202}} = Graph.remove(:arango, "foo")
    {:ok, %{status_code: 202}} = Graph.remove(:arango, "bar")
  end

  test "list_edges() returns information about edge collections in a graph" do
    create_standard_graph()
    {:ok, resp} = Graph.list_edges(:arango, "foo")

    assert resp.status_code == 200
    assert resp.body["code"] == 200
    assert resp.body["error"] === false
    assert Enum.member?(resp.body["collections"], "my_edges")

    remove_standard_graph()
  end

  test "list_vertices() returns information about vertex collections in a graph" do
    create_standard_graph()
    {:ok, resp} = Graph.list_vertices(:arango, "foo")

    assert resp.status_code == 200
    assert resp.body["code"] == 200
    assert resp.body["error"] === false
    assert Enum.member?(resp.body["collections"], "bar")
    assert Enum.member?(resp.body["collections"], "baz")

    remove_standard_graph()
  end

  test "remove() deletes the given graph" do
    {:ok, %{status_code: 202}} = Graph.create(:arango, %{name: "foo"})
    {:ok, resp} = Graph.remove(:arango, "foo")

    assert resp.status_code == 202
    assert resp.body["code"] == 202
    assert resp.body["error"] === false
    assert resp.body["removed"] === true
  end

  test "remove_edge() removes an edge from a graph" do
    create_standard_graph()
    {:ok, %{body: %{"vertex" => %{"_id" => id1}}}} = Graph.create_vertex(:arango, "foo", "bar", %{my_key: "my_value"})
    {:ok, %{body: %{"vertex" => %{"_id" => id2}}}} = Graph.create_vertex(:arango, "foo", "baz", %{my_key: "my_value"})
    edge = %{_from: id1, _to: id2, my_key: "my_value"}
    {:ok, %{body: %{"edge" => %{"_id" => edge_id}}}} = Graph.create_edge(:arango, "foo", "my_edges", edge)
    {:ok, resp} = Graph.remove_edge(:arango, "foo", edge_id)

    assert resp.status_code == 202
    assert resp.body["code"] == 202
    assert resp.body["error"] === false
    assert resp.body["removed"] === true

    {:ok, edge_resp} = Graph.get_edge(:arango, "foo", edge_id)

    assert edge_resp.status_code == 404

    remove_standard_graph()
  end

  test "remove_edges() removes an edge definition from a graph" do
    create_standard_graph()
    {:ok, resp} = Graph.remove_edges(:arango, "foo", "my_edges")

    assert resp.status_code == 202
    assert resp.body["code"] == 202
    assert resp.body["error"] == false
    assert resp.body["graph"]["name"] == "foo"
    assert resp.body["graph"]["edgeDefinitions"] == []
    assert resp.body["graph"]["orphanCollections"] == ["bar", "baz"]
    assert resp.body["graph"]["isSmart"] == false
    assert resp.body["graph"]["numberOfShards"] == 1
    assert resp.body["graph"]["smartGraphAttribute"] == ""
    assert resp.body["graph"]["_id"] == "_graphs/foo"
    assert is_binary(resp.body["graph"]["_rev"])

    {:ok, edge_resp} = Graph.list_edges(:arango, "foo")

    assert edge_resp.status_code == 200
    assert edge_resp.body["collections"] === []

    remove_standard_graph()
  end

  test "remove_vertex() removes an edge from a graph" do
    create_standard_graph()
    {:ok, %{body: %{"vertex" => %{"_id" => id}}}} = Graph.create_vertex(:arango, "foo", "bar", %{my_key: "my_value"})
    {:ok, resp} = Graph.remove_vertex(:arango, "foo", id)

    assert resp.status_code == 202
    assert resp.body["code"] == 202
    assert resp.body["error"] === false
    assert resp.body["removed"] === true

    {:ok, vertex_resp} = Graph.get_vertex(:arango, "foo", id)

    assert vertex_resp.status_code == 404

    remove_standard_graph()
  end

  test "remove_vertices() removes an edge definition from a graph" do
    create_standard_graph()
    {:ok, %{status_code: 202}} = Graph.remove_edges(:arango, "foo", "my_edges")
    {:ok, resp} = Graph.remove_vertices(:arango, "foo", "bar")

    assert resp.status_code == 202
    assert resp.body["code"] == 202
    assert resp.body["error"] == false
    assert resp.body["graph"]["name"] == "foo"
    assert resp.body["graph"]["edgeDefinitions"] == []
    assert resp.body["graph"]["orphanCollections"] == ["baz"]
    assert resp.body["graph"]["isSmart"] == false
    assert resp.body["graph"]["numberOfShards"] == 1
    assert resp.body["graph"]["smartGraphAttribute"] == ""
    assert resp.body["graph"]["_id"] == "_graphs/foo"
    assert is_binary(resp.body["graph"]["_rev"])

    {:ok, edge_resp} = Graph.list_vertices(:arango, "foo")

    assert edge_resp.status_code == 200
    assert edge_resp.body["collections"] === ["baz"]

    remove_standard_graph()
  end

  test "replace_edge() replaces the given edge" do
    create_standard_graph()
    {:ok, %{body: %{"vertex" => %{"_id" => id1}}}} = Graph.create_vertex(:arango, "foo", "bar", %{my_key: "my_value"})
    {:ok, %{body: %{"vertex" => %{"_id" => id2}}}} = Graph.create_vertex(:arango, "foo", "baz", %{my_key: "my_value"})
    edge = %{_from: id1, _to: id2, my_key: "my_value"}
    {:ok, %{body: %{"edge" => %{"_id" => edge_id}}}} = Graph.create_edge(:arango, "foo", "my_edges", edge)
    {:ok, resp} = Graph.replace_edge(:arango, "foo", edge_id, %{_from: id1, _to: id2, other_key: "other_value"})

    assert resp.status_code == 202
    assert resp.body["code"] == 202
    assert resp.body["error"] === false
    assert is_binary(resp.body["edge"]["_id"])
    assert is_binary(resp.body["edge"]["_key"])
    assert is_binary(resp.body["edge"]["_rev"])
    assert is_binary(resp.body["edge"]["_oldRev"])

    replaced_edge =
      resp.body["edge"]
      |> Map.delete("_oldRev")
      |> Map.put("other_key", "other_value")
      |> Map.put("_from", id1)
      |> Map.put("_to", id2)
    {:ok, edge_response} = Graph.get_edge(:arango, "foo", edge_id)

    assert edge_response.body["edge"] === replaced_edge

    remove_standard_graph()
  end

  test "replace_edges() replaces an edge definition in a graph" do
    create_standard_graph()
    {:ok, %{status_code: 202}} = Graph.add_vertices(:arango, "foo", %{collection: "bat"})
    edge_def = %{collection: "my_edges", from: ["bar"], to: ["bat"]}
    {:ok, resp} = Graph.replace_edges(:arango, "foo", "my_edges", edge_def)

    assert resp.status_code == 202
    assert resp.body["code"] == 202
    assert resp.body["error"] == false
    assert resp.body["graph"]["name"] == "foo"
    assert resp.body["graph"]["edgeDefinitions"] == [%{"collection" => "my_edges", "from" => ["bar"], "to" => ["bat"]}]
    assert resp.body["graph"]["orphanCollections"] == ["baz"]
    assert resp.body["graph"]["isSmart"] == false
    assert resp.body["graph"]["numberOfShards"] == 1
    assert resp.body["graph"]["smartGraphAttribute"] == ""
    assert resp.body["graph"]["_id"] == "_graphs/foo"
    assert is_binary(resp.body["graph"]["_rev"])

    remove_standard_graph()
  end

  test "replace_vertex() replaces the given vertex" do
    create_standard_graph()
    {:ok, %{body: %{"vertex" => %{"_id" => id}}}} = Graph.create_vertex(:arango, "foo", "bar", %{my_key: "my_value"})
    {:ok, resp} = Graph.replace_vertex(:arango, "foo", id, %{other_key: "other_value"})

    assert resp.status_code == 202
    assert resp.body["code"] == 202
    assert resp.body["error"] === false
    assert is_binary(resp.body["vertex"]["_id"])
    assert is_binary(resp.body["vertex"]["_key"])
    assert is_binary(resp.body["vertex"]["_rev"])
    assert is_binary(resp.body["vertex"]["_oldRev"])

    vertex =
      resp.body["vertex"]
      |> Map.delete("_oldRev")
      |> Map.put("other_key", "other_value")
    {:ok, vertex_response} = Graph.get_vertex(:arango, "foo", id)

    assert vertex_response.body["vertex"] === vertex

    remove_standard_graph()
  end

  test "update_edge() updates the given edge" do
    create_standard_graph()
    {:ok, %{body: %{"vertex" => %{"_id" => id1}}}} = Graph.create_vertex(:arango, "foo", "bar", %{my_key: "my_value"})
    {:ok, %{body: %{"vertex" => %{"_id" => id2}}}} = Graph.create_vertex(:arango, "foo", "baz", %{my_key: "my_value"})
    edge = %{_from: id1, _to: id2, my_key: "my_value"}
    {:ok, %{body: %{"edge" => %{"_id" => edge_id}}}} = Graph.create_edge(:arango, "foo", "my_edges", edge)
    {:ok, resp} = Graph.update_edge(:arango, "foo", edge_id, %{another_key: "another_value"})

    assert resp.status_code == 202
    assert resp.body["code"] == 202
    assert resp.body["error"] === false
    assert is_binary(resp.body["edge"]["_id"])
    assert is_binary(resp.body["edge"]["_key"])
    assert is_binary(resp.body["edge"]["_rev"])
    assert is_binary(resp.body["edge"]["_oldRev"])

    updated_edge =
      resp.body["edge"]
      |> Map.delete("_oldRev")
      |> Map.put("my_key", "my_value")
      |> Map.put("another_key", "another_value")
      |> Map.put("_from", id1)
      |> Map.put("_to", id2)
    {:ok, edge_response} = Graph.get_edge(:arango, "foo", edge_id)

    assert edge_response.body["edge"] === updated_edge

    remove_standard_graph()
  end

  test "update_vertex() updates the given vertex" do
    create_standard_graph()
    {:ok, %{body: %{"vertex" => %{"_id" => id}}}} = Graph.create_vertex(:arango, "foo", "bar", %{my_key: "my_value"})
    {:ok, resp} = Graph.update_vertex(:arango, "foo", id, %{another_key: "another_value"})

        assert resp.status_code == 202
        assert resp.body["code"] == 202
        assert resp.body["error"] === false
        assert is_binary(resp.body["vertex"]["_id"])
        assert is_binary(resp.body["vertex"]["_key"])
        assert is_binary(resp.body["vertex"]["_rev"])
        assert is_binary(resp.body["vertex"]["_oldRev"])

    vertex =
      resp.body["vertex"]
      |> Map.delete("_oldRev")
      |> Map.put("my_key", "my_value")
      |> Map.put("another_key", "another_value")
    {:ok, vertex_response} = Graph.get_vertex(:arango, "foo", id)

    assert vertex_response.body["vertex"] === vertex

    remove_standard_graph()
  end

  defp create_standard_graph do
    {:ok, %{status_code: 200}} = Collection.create(:arango, %{name: "bar"})
    {:ok, %{status_code: 200}} = Collection.create(:arango, %{name: "baz"})
    {:ok, %{status_code: 200}} = Collection.create(:arango, %{name: "my_edges", type: 3})
    edge_def = %{collection: "my_edges", from: ["bar"], to: ["baz"]}

    {:ok, %{status_code: 202}} = Graph.create(:arango, %{name: "foo", edgeDefinitions: [edge_def]})
  end

  defp remove_standard_graph do
    {:ok, %{status_code: 200}} = Collection.remove(:arango, "bar")
    {:ok, %{status_code: 200}} = Collection.remove(:arango, "baz")
    {:ok, %{status_code: 200}} = Collection.remove(:arango, "my_edges")
    {:ok, %{status_code: 202}} = Graph.remove(:arango, "foo")
  end
end
