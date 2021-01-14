defmodule EtsalaWeb.Plugs.Tracking do
  @moduledoc """
  tracking plug
  """
  require Logger
  import Plug.Conn

  @behaviour Plug

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    conn
    |> create_tracking_id()
    |> track_page_view()
  end

  defp create_tracking_id(conn) do
    conn
    |> get_session
    |> Map.get("tracking_id")
    |> add_tracking_id_to_session(conn)
  end

  defp add_tracking_id_to_session(nil, conn) do
    conn
    |> put_session(:tracking_id, Ecto.UUID.generate())
  end

  defp add_tracking_id_to_session(_, conn), do: conn

  defp track_page_view(conn) do
    %{
      dp: conn |> Map.get(:request_path, nil),
      dh: conn |> Map.get(:host, nil),
      cid: conn |> get_session(:tracking_id),
      uid: conn |> get_session(:character_name) || "unknown",
      user_id: conn |> get_session(:character_name) || "unknown",
      ua: conn |> get_user_agent_from_conn(),
      t: "pageview",
      v: 1
    }
    |> WDI.MSP.Client.send_event()

    conn
  end

  defp get_user_agent_from_conn(conn) do
    conn
    |> Plug.Conn.get_req_header("user-agent")
    |> List.first()
  end
end
