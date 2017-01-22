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

  def delete(url, opts \\ []) do
    response = request(:delete, url, "", get_headers(Keyword.get(opts, :headers, [])), opts)
    Response.convert_response(response)
  end

  def get(url, opts \\ []) do
    response = request(:get, url, "", get_headers(Keyword.get(opts, :headers, [])), opts)
    Response.convert_response(response)
  end

  def head(url, opts \\ []) do
    response = request(:head, url, "", get_headers(Keyword.get(opts, :headers, [])), opts)
    Response.convert_response(response)
  end

  def patch(url, body, opts \\ []) do
    response = request(:patch, url, body, get_headers(Keyword.get(opts, :headers, [])), opts)
    Response.convert_response(response)
  end

  def post(url, body, opts \\ []) do
    response = request(:post, url, body, get_headers(Keyword.get(opts, :headers, [])), opts)
    Response.convert_response(response)
  end

  def put(url, body \\ "", opts \\ []) do
    response = request(:put, url, body, get_headers(Keyword.get(opts, :headers, [])), opts)
    Response.convert_response(response)
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

      @doc false
      def build_url(url_part, opts \\ [])
      def build_url([], opts), do: do_build_url([], opts)
      def build_url(url_part, opts), do: do_build_url(["/", url_part], opts)

      defp do_build_query_params(opts) do
        opts
          |> Keyword.get(:query_params, [])
          |> extract_query_params(opts)
          |> Enum.reduce([], &join_query_params/2)
          |> finish_query_params()
      end

      defp do_build_url(url_part, opts) do
        [Arangoex.get_base_url(opts), @base_url_part, url_part, do_build_query_params(opts)]
      end

      defp extract_query_params(params, opts) do
        Enum.map(params, fn(param) ->
          case Keyword.get(opts, param) do
            nil -> []
            value -> [Atom.to_string(param), "=", value]
          end
        end)
      end

      defp finish_query_params([]), do: []
      defp finish_query_params(params), do: ["?", params]

      defp join_query_params([], acc), do: acc
      defp join_query_params(param, []), do: param
      defp join_query_params(param, acc), do: [param, "&", acc]
    end
  end
end
