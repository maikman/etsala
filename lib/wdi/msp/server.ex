defmodule ESB.Google.MSP.Server do
  @moduledoc """
  This module creates a google analytics server that serves predefined responses for cetain requests. It is
  only used for testing purpose.
  """

  use Plug.Router

  plug :match
  plug :dispatch

  def start, do: Plug.Cowboy.http(__MODULE__, [], port: 7050)

  def stop, do: Plug.Cowboy.shutdown(__MODULE__.HTTP)

  post "/collect" do
    {:ok, _payload, _} = Plug.Conn.read_body(conn)
    Plug.Conn.send_resp(conn, 200, "")
  end
end
