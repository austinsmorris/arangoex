defmodule Arangoex.Response do
  @moduledoc false

#  alias HTTPoison.Response, as: HTTPoisonResponse

  defstruct body: nil, headers: [], status_code: nil

  @type t :: %__MODULE__{status_code: integer, body: binary, headers: list}

#  def convert_response(%HTTPoisonResponse{} = response) do
#    %__MODULE__{body: response.body, headers: response.headers, status_code: response.status_code}
#  end
#
#  def convert_response({:ok, %HTTPoisonResponse{} = response}) do
#    {:ok, %__MODULE__{body: response.body, headers: response.headers, status_code: response.status_code}}
#  end
end
