defmodule Arangoex.SimpleTest do
  use ExUnit.Case, async: false

  alias Arangoex.{
    Collection,
    Document,
    JSON,
    Simple
  }

  @collection_name "cars"

  @document1 %{brand: "Ford", model: "Festiva"}
  @document2 %{brand: "Toyota", model: "Camry"}

  @example %{brand: "Ford"}

  setup do
    Collection.create(%{name: @collection_name})

    {:ok, response1} = Document.create(@collection_name, @document1)
    {:ok, response2} = Document.create(@collection_name, @document2)

    on_exit fn ->
      Collection.remove(@collection_name)
    end

    {:ok, responses: [response1, response2]}
  end

  test "get_first_document_by_example() gets first document by example from a collection" do
    {:ok, response} = Simple.get_first_document_by_example(@collection_name, @example)

    body = JSON.decode!(response.body)

    assert get_in(body, ["code"]) == 200
    assert get_in(body, ["document", "brand"]) == "Ford"
    assert get_in(body, ["document", "model"]) == "Festiva"
  end

  test "get_random_document() gets a random document from a collection" do
    {:ok, response} = Simple.get_random_document(@collection_name)

    body = JSON.decode!(response.body)
    doc  = get_in(body, ["document"])

    assert get_in(body, ["code"]) == 200
    assert Map.has_key?(doc, "brand")
    assert Map.has_key?(doc, "model")
  end

  @example_brands ["Ford", "Toyota"]
  @example_models ["Festiva", "Camry"]
  test "list_documents() gets all documents in a collection" do
    {:ok, response} = Simple.list_documents(@collection_name)

    body = JSON.decode!(response.body)

    [document1, document2] = get_in(body, ["result"])

    assert Enum.member?(@example_brands, get_in(document1, ["brand"]))
    assert Enum.member?(@example_models, get_in(document1, ["model"]))

    assert Enum.member?(@example_brands, get_in(document2, ["brand"]))
    assert Enum.member?(@example_models, get_in(document2, ["model"]))
  end

  test "list_documents_by_example() gets all documents matched by example document" do
    {:ok, response} = Simple.list_documents_by_example(@collection_name, @example)

    body = JSON.decode!(response.body)
    [document] = get_in(body, ["result"])

    assert get_in(document, ["brand"]) == "Ford"
    assert get_in(document, ["model"]) == "Festiva"
  end

  test "list_documents_for_keys() gets all documents matched by example document", %{responses: [resp1|_]} do
    key = JSON.decode!(resp1.body) |> get_in(["_key"])

    {:ok, response} = Simple.list_documents_for_keys(@collection_name, [key])

    body = JSON.decode!(response.body)
    [document] = get_in(body, ["documents"])

    assert get_in(document, ["brand"]) == "Ford"
    assert get_in(document, ["model"]) == "Festiva"
  end

  test "list_keys() gets all keys for documents in collection" do
    {:ok, response} = Simple.list_keys(@collection_name, "key")

    body = JSON.decode!(response.body)
    keys = get_in(body, ["result"])

    assert Enum.count(keys) == 2
  end

  test "remove_documents_by_example() removes all documents matched by example document" do
    {:ok, _} = Simple.remove_documents_by_example(@collection_name, @example)
    {:ok, response} = Simple.list_documents(@collection_name)

    body = JSON.decode!(response.body)
    [result] = get_in(body, ["result"])

    assert get_in(result, ["brand"]) == "Toyota"
  end

  test "remove_documents_for_keys() remove all documents match by list of keys", %{responses: responses} do
    keys = Enum.map(responses, fn resp -> JSON.decode!(resp.body) |> get_in(["_key"]) end)
    {:ok, _} = Simple.remove_documents_for_keys(@collection_name, keys)
    {:ok, response} = Simple.list_documents(@collection_name)

    assert [] == JSON.decode!(response.body) |> get_in(["result"])
  end

  @replaced_brands ["Chevrolet", "Toyota"]
  @replaced_models ["Camaro", "Camry"]
  test "replace_documents_by_example() replaces all documents matched by example by another document" do
    replacement = %{brand: "Chevrolet", model: "Camaro"}

    {:ok, _} = Simple.replace_documents_by_example(@collection_name, @example, replacement)
    {:ok, response} = Simple.list_documents(@collection_name)

    body = JSON.decode!(response.body)

    [document1, document2] = get_in(body, ["result"])

    assert Enum.member?(@replaced_brands, get_in(document1, ["brand"]))
    assert Enum.member?(@replaced_models, get_in(document1, ["model"]))

    assert Enum.member?(@replaced_brands, get_in(document2, ["brand"]))
    assert Enum.member?(@replaced_models, get_in(document2, ["model"]))
  end

  @modified_brands ["Ford", "Toyota"]
  @modified_models ["Ranger", "Camry"]
  test "update_documents_by_example() updates all documents matched by example with another document" do
    modification = %{model: "Ranger"}

    {:ok, _} = Simple.update_documents_by_example(@collection_name, @example, modification)
    {:ok, response} = Simple.list_documents(@collection_name)

    body = JSON.decode!(response.body)

    [document1, document2] = get_in(body, ["result"])

    assert Enum.member?(@modified_brands, get_in(document1, ["brand"]))
    assert Enum.member?(@modified_models, get_in(document1, ["model"]))

    assert Enum.member?(@modified_brands, get_in(document2, ["brand"]))
    assert Enum.member?(@modified_models, get_in(document2, ["model"]))
  end
end
