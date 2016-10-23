defmodule Arangoex.Response do
  @moduledoc false

  defstruct body: nil, headers: [], status_code: nil

  @type t :: %__MODULE__{status_code: integer, body: binary, headers: Keyword.t}
end
