defmodule Arangoex.Admin do
  @moduledoc false

  alias Arangoex.JSON

  @base_url ["/", "_admin"]

  # POST /_api/tasks
  # Create a server task.
  def create_task(%{} = task) do
    {:ok, body} = JSON.encode(task)
    ["/", "_api", "/", "tasks"] |> Arangoex.add_base_url() |> Arangoex.post(body)
  end

  # PUT /_api/tasks/{id}
  # Create a server task with the given id.
  def create_task_with_id(task_id, task) when is_binary(task_id) do
    {:ok, body} = JSON.encode(task)
    ["/", "_api", "/", "tasks", "/", task_id] |> Arangoex.add_base_url() |> Arangoex.put(body)
  end

  # POST /_admin/execute
  # Execute the given program.
  def execute(_program) do
    # todo - implement - insufficient documenation.
  end

  # GET /_admin/echo
  # Return the current request.
  def get_echo() do
    "echo" |> build_url() |> Arangoex.get()
  end

  # GET /_admin/log
  # Return gobal logs from the server.
  def get_log() do
    # todo - implement upto, level, start, size, offset, search, and sort query parameters
    "log" |> build_url() |> Arangoex.get()
  end

  # GET /_admin/log/level
  # Return the current server log level.
  def get_log_level() do
    ["log", "/", "level"] |> build_url() |> Arangoex.get()
  end

  # GET /_admin/long_echo
  # Return the current request and continue.
  def get_long_echo() do
    # todo - implement inevitable timeout error response
    "long_echo" |> build_url() |> Arangoex.get()
  end

  # GET /_admin/server/id
  # Return the id of the server in the cluster.
  def get_server_id() do
    ["server", "/", "id"] |> build_url() |> Arangoex.get()
  end

  # GET /_admin/server/role
  # Return the role of the server in the cluster.
  def get_server_role() do
    ["server", "/", "role"] |> build_url() |> Arangoex.get()
  end

  # GET /_admin/statistics
  # Return statistics for the system.
  def get_statistics() do
    "statistics" |> build_url() |> Arangoex.get()
  end

  # GET /_admin/statistics-description
  # Return a description of the system statistics.
  def get_statistics_description() do
    "statistics-description" |> build_url() |> Arangoex.get()
  end

  # GET /_admin/time
  # Return the system time.
  def get_system_time() do
    ["time"] |> build_url() |> Arangoex.get()
  end

  # GET /_admin/database/target-version
  # Return the required database target version.
  def get_target_version() do
    ["database", "/", "target-version"] |> build_url() |> Arangoex.get()
  end

  # GET /_api/tasks/{id}
  # Return the server task indicated by the task-id.
  def get_task(task_id) when is_binary(task_id) do
    ["/", "_api", "/", "tasks", "/", task_id] |> Arangoex.add_base_url() |> Arangoex.get()
  end

  # GET /_api/version
  # Return the server version.
  def get_version() do
    # todo - implement details query parameter
    ["/", "_api", "/", "version"] |> Arangoex.add_base_url() |> Arangoex.get()
  end

  # GET /_api/endpoint
  # Return a list of endpoints configured for the server.
  def list_endpoints() do
    # todo - must use the system db
    ["/", "_api", "/", "endpoints"] |> Arangoex.add_base_url() |> Arangoex.get()
  end

  # GET /_api/tasks/
  # List all tasks on the server.
  def list_tasks() do
    ["/", "_api" , "/", "tasks"] |> Arangoex.add_base_url() |> Arangoex.get()
  end

  # POST /_admin/routing/reload
  # Reload the collection routing information.
  def reload_routing() do
    ["routing", "/", "reload"] |> build_url() |> Arangoex.post("")
  end

  # DELETE /_api/tasks/{id}
  # Remove the task with the given id from the server.
  def remove_task(task_id) when is_binary(task_id) do
    ["/", "_api", "/", "tasks", "/", task_id] |> Arangoex.add_base_url() |> Arangoex.delete()
  end

  # PUT /_admin/log/level
  # Set the server log levels.
  def set_log_level(%{} = levels \\ %{}) do
    {:ok, body} = JSON.encode(levels)
    ["log", "/", "level"] |> build_url() |> Arangoex.put(body)
  end

  # DELETE /_admin/shutdown
  # Initial a clean shutdown sequence.
  def shutdown() do
    "shutdown" |> build_url() |> Arangoex.delete()
  end

  # GET /_admin/sleep
  # Sleep for the given duration in seconds.
  def sleep(duration \\ 0)
  def sleep(duration) when is_integer(duration) do
    ["sleep", "?", "duration", "=", Integer.to_string(duration)] |> build_url() |> Arangoex.get()
  end
  def sleep(duration) when is_float(duration) do
    ["sleep", "?", "duration", "=", Float.to_string(duration)] |> build_url() |> Arangoex.get()
  end

  # POST /_admin/test
  # Run the list of test files on the server.
  def test(tests \\ []) when is_list(tests)do
    {:ok, body} = JSON.encode(%{tests: tests})
    "test" |> build_url() |> Arangoex.post(body)
  end

  defp build_url([]), do: [Arangoex.add_base_url(@base_url)]
  defp build_url(url_part), do: [Arangoex.add_base_url(@base_url), "/", url_part]
end
