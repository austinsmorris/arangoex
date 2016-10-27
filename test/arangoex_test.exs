defmodule ArangoexTest do
  use ExUnit.Case
  doctest Arangoex

  test "add_base_url builds the proper request url" do
    url = Arangoex.add_base_url("/foo", [])
    assert url == "http://localhost:8529/_db/test/foo"
  end
end
