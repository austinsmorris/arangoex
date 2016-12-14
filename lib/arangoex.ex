defmodule Arangoex do
  @moduledoc false

  alias Arangoex.Response

  use HTTPoison.Base

  @default_opts [host: "http://localhost:8529", database: "_system", username: "root", password: ""]

  @database Application.get_env(:arangoex, :database, Keyword.fetch!(@default_opts, :database))
  @host Application.get_env(:arangoex, :host, Keyword.fetch!(@default_opts, :host))

  @base_url [@host, "/", "_db", "/", @database]

  @authorization "Basic " <> Base.encode64(
    Application.get_env(:arangoex, :username, Keyword.fetch!(@default_opts, :username)) <> ":" <>
    Application.get_env(:arangoex, :password, Keyword.fetch!(@default_opts, :password))
  )

  def get_base_url(opts \\ []) do
    database_name = Keyword.get(opts, :database)
    do_get_base_url(database_name)
  end

  def delete(url, headers \\ [], options \\ []) do
    response = request(:delete, url, "", get_headers(headers), options)
    response |> Response.convert_response()
  end

  def get(url, headers \\ [], options \\ []) do
    response = request(:get, url, "", get_headers(headers), options)
    response |> Response.convert_response()
  end

  def head(url, headers \\ [], options \\ []) do
    response = request(:head, url, "", get_headers(headers), options)
    response |> Response.convert_response()
  end

  def patch(url, body, headers \\ [], options \\ []) do
    response = request(:patch, url, body, get_headers(headers), options)
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

  defp do_get_base_url(nil), do: @base_url
  defp do_get_base_url(database_name), do: [@host, "/", "_db", "/", database_name]

  defp get_headers(headers) do
    headers = headers ++ [{"Accept", "application/json"}, {"Authorization", @authorization}]
    Enum.dedup_by(headers, fn({header, _value}) -> header end)
  end

  defmacro __using__(opts) do
    quote bind_quoted: [opts: opts] do
      @base_url_part Keyword.get(opts, :base_url, [])

      def build_url(url_part, options \\ [])
      def build_url([], options), do: do_build_url([], options)
      def build_url(url_part, options), do: do_build_url(["/", url_part], options)

      defp do_build_url(url_part, opts), do: [Arangoex.get_base_url(opts), @base_url_part, url_part]
    end
  end
end
