defmodule Arangoex.Response do
  @moduledoc """
  Response struct and supporting functions for ArangoDB reponses.
  """

  defstruct body: nil, headers: nil, response_type: nil, status_code: nil, version: nil

  @type t :: %__MODULE__{body: any, headers: any, response_type: integer, status_code: integer, version: integer}

  def build_response([version, response_type, status_code] = _header, body) do
    %__MODULE__{body: body, response_type: response_type, status_code: status_code, version: version}
  end
end
