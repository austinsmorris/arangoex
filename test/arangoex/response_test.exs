defmodule Arangoex.ResponseTest do
  alias Arangoex.Response

  use ExUnit.Case, async: true

  test "Response struct" do
    response = %Response{}
    assert response.body == nil
    assert response.headers == nil
    assert response.response_type == nil
    assert response.status_code == nil
    assert response.version == nil
  end

  test "to_response() without headers" do
    response = Response.to_response([1, 2, 200], %{"foo" => "bar"})
    assert response == %Response{body: %{"foo" => "bar"}, headers: nil, response_type: 2, status_code: 200, version: 1}
  end
end
