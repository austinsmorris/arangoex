defmodule Arangoex.JSONTest do
  use ExUnit.Case

  alias Arangoex.JSON

  test "decoding valid json string" do
    {:ok, map} = JSON.decode("{\"foo\":\"bar\"}")
    assert map == %{"foo" => "bar"}
  end

  test "decoding invalid json string" do
    {:error, error} = JSON.decode("{\"foo\":bar\"}")
    assert error == {:invalid, "b", 7}
  end

  test "decoding valid jason string raising error" do
    map = JSON.decode!("{\"foo\":\"bar\"}")
    assert map == %{"foo" => "bar"}
  end

  test "decoding invalid json string raising error" do
    assert_raise(Poison.SyntaxError, fn -> JSON.decode!("{\"foo\":bar\"}") end)
  end

  test "encoding valid json string" do
    {:ok, string}= JSON.encode(%{foo: :bar})
    assert string == "{\"foo\":\"bar\"}"
  end

  test "encoding invalid json string" do
    {:error, error}= JSON.encode({:foo, :bar})
    assert error == {:invalid, {:foo, :bar}}
  end

  test "encoding valid jason string raising error" do
    string= JSON.encode!(%{foo: :bar})
    assert string == "{\"foo\":\"bar\"}"
  end

  test "encoding invalid json string raising error" do
    assert_raise(Poison.EncodeError, fn -> JSON.encode!({:foo, :bar}) end)
  end
end
