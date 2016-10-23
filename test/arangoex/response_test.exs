defmodule Arangoex.ResponseTest do
  use ExUnit.Case

  alias Arangoex.Response

  test "Response struct" do
    response = %Response{}
    assert response.body == nil
    assert response.headers == []
    assert response.status_code == nil
  end
end
