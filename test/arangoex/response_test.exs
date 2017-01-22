defmodule Arangoex.ResponseTest do
  alias Arangoex.Response
  alias HTTPoison.Response, as: HTTPoisonResponse

  use ExUnit.Case, async: true

  test "Response struct" do
    response = %Response{}
    assert response.body == nil
    assert response.headers == []
    assert response.status_code == nil
  end

  test "convert HTTPoison.Response" do
    response = %HTTPoisonResponse{body: "foo", headers: [{"foo", "bar"}], status_code: 123}
    converted = Response.convert_response(response)
    assert converted.body == "foo"
    assert converted.headers == [{"foo", "bar"}]
    assert converted.status_code == 123
  end

  test "convert HTTPoison.Response tuple" do
    response = %HTTPoisonResponse{body: "foo", headers: [{"foo", "bar"}], status_code: 123}
    {:ok, converted} = Response.convert_response({:ok, response})
    assert converted.body == "foo"
    assert converted.headers == [{"foo", "bar"}]
    assert converted.status_code == 123
  end
end
