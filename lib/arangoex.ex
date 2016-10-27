defmodule Arangoex do
  @moduledoc false

  alias Arangoex.Response

  use HTTPoison.Base

  @default_opts [host: "http://localhost:8529", database: "_system", username: "root", password: ""]

  @base_url Application.get_env(:arangoex, :host, Keyword.fetch!(@default_opts, :host)) <>
    "/_db/" <> Application.get_env(:arangoex, :database, Keyword.fetch!(@default_opts, :database))

  @authorization "Basic " <> Base.encode64(
    Application.get_env(:arangoex, :username, Keyword.fetch!(@default_opts, :username)) <> ":" <>
    Application.get_env(:arangoex, :password, Keyword.fetch!(@default_opts, :password))
  )

  def add_base_url(url, _opts) do
    @base_url <> url
  end

  def get(url, headers \\ [], options \\ []) do
    response = request(:get, url, "", get_headers(headers), options)
    response |> Response.convert_response()
  end

  def head(url, headers \\ [], options \\ []) do
    response = request(:head, url, "", get_headers(headers), options)
    response |> Response.convert_response()
  end

  def post(url, body, headers \\ [], options \\ []) do
    response = request(:post, url, body, get_headers(headers), options)
    response |> Response.convert_response()
  end

  def put(url, body \\ "", headers \\ [], options \\ []) do
    response = request(:put, url, body, get_headers(headers), options)
    response |> Response.convert_response()
  end

  defp get_headers(headers) do
    headers = headers ++ [{"Accept", "application/json"}, {"Authorization", @authorization}]
    Enum.dedup_by(headers, fn({header, _value}) -> header end)
  end
end
