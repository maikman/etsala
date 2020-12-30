defmodule Tools.LogBackend.RouterError do
  @moduledoc """
  this module prepares and adds router errors to the Logger so it can be handled from the LogBackend
  """
  import Tools.LogBackend.Helper
  require Logger

  def handle_router_error(conn, %{reason: reason, stack: stack}) do
    main_meta = [
      status_code: conn.status,
      request_path: conn.request_path,
      host: conn.host,
      get_params: replace_structs(conn.params),
      request_type: conn.method,
      crash_reason: get_crash_reason(reason)
    ]

    main_meta
    |> Keyword.merge(custom_meta(conn, reason, stack))
    |> Logger.metadata()

    Logger.info("router_error")
  end

  defp get_crash_reason(%{__struct__: _} = reason), do: Atom.to_string(reason.__struct__)
  defp get_crash_reason(reason) when is_atom(reason), do: Atom.to_string(reason)
  defp get_crash_reason(_reason), do: "unknown"

  defp custom_meta(%{status: 500} = conn, _reason, stack) do
    conn
    |> Map.take([:assigns, :cookies, :req_headers, :resp_headers, :scheme])
    |> Map.update!(:req_headers, &Map.new(&1))
    |> Map.update!(:resp_headers, &Map.new(&1))
    |> Map.update!(:scheme, &Atom.to_string(&1))
    |> Map.to_list()
    |> replace_structs()
    |> remove_user_data()
    |> Keyword.merge(stack_trace: Exception.format_stacktrace(stack))
  end

  defp custom_meta(_conn, _reason, _stack), do: []

  defp remove_user_data(conn) do
    conn
    |> Keyword.update(:assigns, %{}, fn assigns ->
      assigns
      |> Map.update(:credential, nil, fn _ -> %{} end)
      |> Map.update(:customer, nil, fn _ -> %{} end)
    end)
  end
end
