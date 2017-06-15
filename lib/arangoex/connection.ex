defmodule Arangoex.Connection do
  @moduledoc false

  alias Arangoex.Response

  use Connection

  @default_timeout 5_000
  @message_type_authorization 1000
  @message_type_request 1
  @version 1

  # public api
  def request(conn, method, path, params, meta, body, opts) do
    # credo:disable-for-previous-line Credo.Check.Refactor.FunctionArity
    # todo - allow for timeout to be passed in opts
    Connection.call(conn, {:request, method, path, params, meta, body, opts}, @default_timeout)
  end

  def start_link(args, opts \\ []) do
    Connection.start_link(__MODULE__, args, opts)
  end

  # callbacks
  def init(args) do
    {:connect, args, %{database: Keyword.get(args, :database), from: nil, socket: nil}}
  end

  def connect(info, state) do
    host = Keyword.get(info, :host)
    port = Keyword.get(info, :port)
    username = Keyword.get(info, :username)
    password = Keyword.get(info, :password)

    # todo - error handling for encoding
    auth = [version(), message_type_authorization(), "plain", username, password]
      |> VelocyPack.encode_to_iodata!()
      |> VelocyStream.pack()

    # todo = error handling
    {:ok, socket} = :gen_tcp.connect(host, port, [packet: :raw, mode: :binary, active: false], @default_timeout)
    :ok = :gen_tcp.send(socket, "VST/1.0\r\n\r\n")
    :ok = :gen_tcp.send(socket, auth)

    # todo - get auth response and return any possible error
    # todo - handle receiveing complete auth response without sleep
    :timer.sleep(100)
    :gen_tcp.recv(socket, 0)

    :ok = :inet.setopts(socket, active: :once)
    {:ok, %{state | socket: socket}}
  end

  def handle_call({:request, method, path, params, meta, body, opts}, from, state) do
    header = [
      version(),
      message_type_request(),
      Keyword.get(opts, :database, state.database),
      request_type(method),
      path,
      params,
      meta
    ]

    # todo - use message id for VelocyStream
    request = header |> build_request(body) |> VelocyStream.pack

    # todo - error handling
    :ok = :gen_tcp.send(state.socket, request)
    {:noreply, %{state | from: from}}
  end

  def handle_info({:tcp, _port, data}, state) do
    :ok = :inet.setopts(state.socket, active: :once)

    # todo - get all the data and parse into response
    # todo - match message id from VelocyStream
    # todo - error handling
    {message, 0} = VelocyStream.unpack(data)
    {:ok, header, tail} = VelocyPack.decode(message)
    {:ok, body, ""} = parse_body(tail)

    # todo - verify same version
    # todo - response type 2 or 3?
    # todo - status codes match?
    # todo - :error for non-ok responses?
    response = {:ok, Response.build_response(header, body)}

    # todo - what is state is nil?
    if state.from !== nil do
      Connection.reply(state.from, response)
    end

    {:noreply, %{state | from: nil}}
  end

  defp build_request(header, nil), do: VelocyPack.encode_to_iodata!(header)
  defp build_request(header, body), do: [VelocyPack.encode_to_iodata!(header), VelocyPack.encode_to_iodata!(body)]

  defp message_type_authorization, do: @message_type_authorization
  defp message_type_request, do: @message_type_request

  defp parse_body(""), do: {:ok, nil, ""}
  defp parse_body(data), do: VelocyPack.decode(data)

  defp request_type(:delete), do: 0
  defp request_type(:get), do: 1
  defp request_type(:post), do: 2
  defp request_type(:put), do: 3
  defp request_type(:head), do: 4
  defp request_type(:patch), do: 5
  defp request_type(:options), do: 6

  defp version, do: @version
end
