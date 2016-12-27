defmodule Arangoex.Database do
  @moduledoc false

  alias Arangoex.JSON

  use Arangoex, base_url: ["/", "_api", "/", "database"]

  # POST /_api/database
  # Create a new database.
  def create(%{} = database, opts \\ []) do
    {:ok, body} = JSON.encode(database)

    []
      |> build_url(Keyword.put_new(opts, :database, "_system"))
      |> Arangoex.post(body, opts)
  end

  # GET /_api/database/current
  # Return information about the current database.
  def get_current(opts \\ []) do
    "current"
      |> build_url(opts)
      |> Arangoex.get(opts)
  end

  # GET /_api/database
  # Return a list of all databases on the system.
  def list(opts \\ []) do
    []
      |> build_url(opts)
      |> Arangoex.get(opts)
  end

  # GET /_api/database/user
  # Return a list of databases for the current user.
  def list_for_current_user(opts \\ []) do
    "user"
      |> build_url(opts)
      |> Arangoex.get(opts)
  end

  # DELETE /_api/database/{database-name}
  # Remove the database identified by database-name from the system.
  def remove(database_name, opts \\ []) do
    database_name
      |> build_url(Keyword.put_new(opts, :database, "_system"))
      |> Arangoex.delete(opts)
  end
end
