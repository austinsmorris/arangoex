defmodule Arangoex.Admin do
  @moduledoc false

#  alias Arangoex.JSON
#  import Arangoex, only: [get_base_url: 1]

#  use Arangoex, base_url: ["/", "_admin"]

  # POST /_api/tasks
  # Create a server task.
  def create_task(%{} = task, opts \\ []) do
#    {:ok, body} = JSON.encode(task)
#
#    [get_base_url(opts), "/", "_api", "/", "tasks"]
#      |> Arangoex.post(body, opts)
  end

  # PUT /_api/tasks/{id}
  # Create a server task with the given id.
  def create_task_with_id(task_id, task, opts \\ []) when is_binary(task_id) do
#    {:ok, body} = JSON.encode(task)
#
#    [get_base_url(opts), "/", "_api", "/", "tasks", "/", task_id]
#      |> Arangoex.put(body, opts)
  end

  # POST /_admin/execute
  # Execute the given program.
  def execute(_program, _opts \\ []) do
    # todo - implement - insufficient documenation.
  end

  # GET /_admin/echo
  # Return the current request.
  def get_echo(opts \\ []) do
#    "echo"
#      |> build_url(opts)
#      |> Arangoex.get(opts)
  end

  # GET /_admin/log
  # Return gobal logs from the server.
  def get_log(opts \\ []) do
    # todo - implement upto, level, start, size, offset, search, and sort query parameters
#    "log"
#      |> build_url(opts)
#      |> Arangoex.get(opts)
  end

  # GET /_admin/log/level
  # Return the current server log level.
  def get_log_level(opts \\ []) do
#    ["log", "/", "level"]
#      |> build_url(opts)
#      |> Arangoex.get(opts)
  end

  # GET /_admin/long_echo
  # Return the current request and continue.
  def get_long_echo(opts \\ []) do
    # todo - implement inevitable timeout error response
#    "long_echo"
#      |> build_url(opts)
#      |> Arangoex.get(opts)
  end

  # GET /_admin/server/id
  # Return the id of the server in the cluster.
  def get_server_id(opts \\ []) do
#    ["server", "/", "id"]
#      |> build_url(opts)
#      |> Arangoex.get(opts)
  end

  # GET /_admin/server/role
  # Return the role of the server in the cluster.
  def get_server_role(opts \\ []) do
#    ["server", "/", "role"]
#      |> build_url(opts)
#      |> Arangoex.get(opts)
  end

  # GET /_admin/statistics
  # Return statistics for the system.
  def get_statistics(opts \\ []) do
#    "statistics"
#      |> build_url(opts)
#      |> Arangoex.get(opts)
  end

  # GET /_admin/statistics-description
  # Return a description of the system statistics.
  def get_statistics_description(opts \\ []) do
#    "statistics-description"
#      |> build_url(opts)
#      |> Arangoex.get(opts)
  end

  # GET /_admin/time
  # Return the system time.
  def get_system_time(opts \\ []) do
#    ["time"]
#      |> build_url(opts)
#      |> Arangoex.get(opts)
  end

  # GET /_admin/database/target-version
  # Return the required database target version.
  def get_target_version(opts \\ []) do
#    ["database", "/", "target-version"]
#      |> build_url(opts)
#      |> Arangoex.get(opts)
  end

  # GET /_api/tasks/{id}
  # Return the server task indicated by the task-id.
  def get_task(task_id, opts \\ []) when is_binary(task_id) do
#    [get_base_url(opts), "/", "_api", "/", "tasks", "/", task_id]
#      |> Arangoex.get(opts)
  end

  # GET /_api/version
  # Return the server version.
  def get_version(opts \\ []) do
    # todo - implement details query parameter
#    Arangoex.get([get_base_url(opts), "/", "_api", "/", "version"], opts)
  end

  # GET /_api/endpoint
  # Return a list of endpoints configured for the server.
  def list_endpoints(opts \\ []) do
    # todo - must use the system db
#    Arangoex.get([get_base_url(opts), "/", "_api", "/", "endpoints"], opts)
  end

  # GET /_api/tasks/
  # List all tasks on the server.
  def list_tasks(opts \\ []) do
#    Arangoex.get([get_base_url(opts), "/", "_api" , "/", "tasks"], opts)
  end

  # POST /_admin/routing/reload
  # Reload the collection routing information.
  def reload_routing(opts \\ []) do
#    ["routing", "/", "reload"]
#      |> build_url(opts)
#      |> Arangoex.post("", opts)
  end

  # DELETE /_api/tasks/{id}
  # Remove the task with the given id from the server.
  def remove_task(task_id, opts \\ []) when is_binary(task_id) do
#    [get_base_url(opts), "/", "_api", "/", "tasks", "/", task_id]
#      |> Arangoex.delete(opts)
  end

  # PUT /_admin/log/level
  # Set the server log levels.
  def set_log_level(%{} = levels \\ %{}, opts \\ []) do
#    {:ok, body} = JSON.encode(levels)
#    ["log", "/", "level"]
#      |> build_url(opts)
#      |> Arangoex.put(body, opts)
  end

  # DELETE /_admin/shutdown
  # Initial a clean shutdown sequence.
  def shutdown(opts \\ []) do
#    "shutdown"
#      |> build_url(opts)
#      |> Arangoex.delete(opts)
  end

  # GET /_admin/sleep
  # Sleep for the given duration in seconds.
  def sleep(duration \\ 0, opts \\ [])
  def sleep(duration, opts) when is_integer(duration) do
#    ["sleep", "?", "duration", "=", Integer.to_string(duration)]
#      |> build_url(opts)
#      |> Arangoex.get(opts)
  end
  def sleep(duration, opts) when is_float(duration) do
#    ["sleep", "?", "duration", "=", Float.to_string(duration)]
#      |> build_url(opts)
#      |> Arangoex.get(opts)
  end

  # POST /_admin/test
  # Run the list of test files on the server.
  def test(tests \\ [], opts \\ []) when is_list(tests)do
#    {:ok, body} = JSON.encode(%{tests: tests})
#
#    "test"
#      |> build_url(opts)
#      |> Arangoex.post(body, opts)
  end
end
