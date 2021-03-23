defmodule Tools.Tracking do
  import Plug.Conn
  alias WDI.MSP.Client

  def track_event(session, category, action, label \\ "") do
    %{
      cid: session |> Map.get("tracking_id"),
      uid: session |> Map.get("character_name", "unknown"),
      user_id: session |> Map.get("character_name", "unknown"),
      t: "event",
      v: 1,
      ec: category,
      ea: action,
      el: label
    }
    |> Client.send_event()
  end

  def track_page_view(conn) do
    %{
      dp: conn |> Map.get(:request_path, nil),
      dh: conn |> Map.get(:host, nil),
      cid: conn |> get_session(:tracking_id),
      uid: conn |> get_session(:character_name) || "unknown",
      user_id: conn |> get_session(:character_name) || "unknown",
      ua: conn |> get_user_agent_from_conn(),
      dr: conn |> get_referrer_from_conn(),
      uip: conn |> Map.get(:remote_ip) |> get_user_ip(),
      t: "pageview",
      v: 1
    }
    |> Client.send_event()

    conn
  end

  def create_tracking_id(conn) do
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

  defp get_user_agent_from_conn(conn) do
    conn
    |> Plug.Conn.get_req_header("user-agent")
    |> List.first()
  end

  defp get_referrer_from_conn(conn) do
    conn
    |> get_req_header("referer")
    |> List.first()
  end

  defp get_user_ip({a, b, c, d}), do: [a, b, c, d] |> Enum.join(".")

  defp get_user_ip(_), do: nil
end
