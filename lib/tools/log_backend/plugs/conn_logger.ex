defmodule Tools.LogBackend.Plug.ConnLogger do
  @moduledoc """
    log conn values for further usage
  """
  require Logger

  @doc false
  def init(_opts), do: nil

  @doc false
  def call(conn, _opts) do
    conn
    |> filter_request_infos()
    |> add_to_metadata()

    conn
  end

  defp filter_request_infos(conn) do
    request_id = get_value_from_header_list(conn.resp_headers, "x-request-id")

    conn
    |> Map.take([:host, :request_path])
    |> Map.merge(%{
      :request_id => request_id,
      :get_params => conn.params,
      :request_type => conn.method,
      :user_agent => get_user_agent_from_conn(conn)
    })
  end

  defp get_user_agent_from_conn(conn) do
    conn
    |> Plug.Conn.get_req_header("user-agent")
    |> List.first()
  end

  defp obfuscate_passwords(params), do: params

  defp add_to_metadata(params) do
    for {k, v} <- params do
      Logger.metadata("#{k}": v)
    end
  end

  def get_value_from_header_list(header_list, search) do
    case header_list |> Enum.find(fn {key, _val} -> key == search end) do
      {_, result} -> result
      _ -> ""
    end
  end
end
