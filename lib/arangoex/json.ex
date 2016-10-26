defmodule Arangoex.JSON do
  @moduledoc false

  alias Poison
  alias Poison.Encoder
  alias Poison.Parser

  @spec decode(iodata, Keyword.t) :: {:ok, Parser.t} | {:error, :invalid} | {:error, {:invalid, String.t}}
  def decode(iodata, options \\ []), do: Poison.decode(iodata, options)

  @spec decode!(iodata, Keyword.t) :: Parser.t | no_return
  def decode!(iodata, options \\ []), do: Poison.decode!(iodata, options)

  @spec encode(Encoder.t, Keyword.t) :: {:ok, iodata} | {:ok, String.t} | {:error, {:invalid, any}}
  def encode(value, options \\ []), do: Poison.encode(value, options)

  @spec encode!(Encoder.t, Keyword.t) :: iodata | no_return
  def encode!(value, options \\ []), do: Poison.encode!(value, options)
end
