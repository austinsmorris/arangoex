defmodule Arangoex.Database do
  @moduledoc false

  alias Arangoex.JSON
  alias Arangoex.Simple

  @base_url ["/", "_api", "/", "database"]

  # POST /_api/database
  # Create a new database.
  def create(%{} = database) do
    # todo - requires system database!
    {:ok, body} = JSON.encode(database)
    [] |> build_url() |> Arangoex.post(body)
  end

  # GET /_api/database/current
  # Return information about the current database.
  def get_current() do
    "current" |> build_url() |> Arangoex.get()
  end

  # GET /_api/database
  # Return a list of all databases on the system.
  def list() do
    [] |> build_url() |> Arangoex.get()
  end

  # GET /_api/database/user
  # Return a list of databases for the current user.
  def list_for_current_user() do
    "user" |> build_url() |> Arangoex.get()
  end

  # DELETE /_api/database/{database-name}
  # Remove the database identified by database-name from the system.
  def remove(database_name) do
    database_name |> build_url() |> Arangoex.delete()
  end

  defp build_url([]), do: [Arangoex.add_base_url(@base_url)]
  defp build_url(url_part), do: [Arangoex.add_base_url(@base_url), "/", url_part]
end
