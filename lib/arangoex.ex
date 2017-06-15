defmodule Arangoex do
  @moduledoc false
  # todo - document "Shared Options", incl. "database"

  alias Arangoex.Connection, as: AConnection

  @default_opts %{host: :localhost, port: 8529, database: "_system", username: "root", password: ""}

  def request(conn, method, path, params \\ %{}, meta \\ %{}, body \\ nil, opts \\ []) do
    # credo:disable-for-previous-line Credo.Check.Refactor.FunctionArity
    AConnection.request(conn, method, path, params, meta, body, opts)
  end

  def start_link(opts \\ []) do
    # todo - "with"" syntax?
    {host, opts} = pop_host(opts)
    {port, opts} = pop_port(opts)
    {database, opts} = pop_database(opts)
    {username, opts} = pop_username(opts)
    {password, opts} = pop_password(opts)
    AConnection.start_link([host: host, port: port, database: database, username: username, password: password], opts)
  end

  defp pop_database(opts) do
    Keyword.pop(opts, :database, Application.get_env(:arangoex, :database, @default_opts.database))
  end

  defp pop_host(opts), do: Keyword.pop(opts, :host, Application.get_env(:arangoex, :host, @default_opts.host))

  defp pop_password(opts) do
    Keyword.pop(opts, :password, Application.get_env(:arangoex, :password, @default_opts.password))
  end

  defp pop_port(opts), do: Keyword.pop(opts, :port, Application.get_env(:arangoex, :port, @default_opts.port))

  defp pop_username(opts) do
    Keyword.pop(opts, :username, Application.get_env(:arangoex, :username, @default_opts.username))
  end
end
