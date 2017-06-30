defmodule Arangoex.GraphTest do
  alias Arangoex.Graph
#  alias Arangoex.JSON

  use ExUnit.Case, async: true

  # todo - graph tests

#  test "add_edges()" do
#
#  end
#
#  test "add_vertices()" do
#
#  end

#  test "create() creates a new graph" do
#    {:ok, response} = Graph.create(%{name: "foo"})
#    body = JSON.decode!(response.body, keys: :atoms)
#
#    assert body.code == 202
#    assert body.error == false
#    assert body.graph.name == "foo"
#    assert body.graph.edgeDefinitions == []
#    assert body.graph.orphanCollections == []
#    assert body.graph.isSmart == false
#    assert body.graph.numberOfShards == 0
#    assert body.graph.smartGraphAttribute == ""
#    assert body.graph._id == "_graphs/foo"
#
#    Graph.remove("foo")
#  end

#  test "remove() deletes the given graph" do
#    Graph.create(%{name: "foo"})
#    {:ok, response} = Graph.remove("foo")
#    body = JSON.decode!(response.body, keys: :atoms)
#    assert body.code == 200
#    assert body.result === true
#    assert body.error === false
#
#    {:ok, response} =Database.list()
#    body = JSON.decode!(response.body, keys: :atoms)
#
#    refute Enum.member?(body.result, "foo")
#  end
end
