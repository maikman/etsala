defmodule Tools.LogBackend.RequestLogger do
  @moduledoc """
  module for http request logging
  """

  alias Tools.LogBackend.UserTracking

  @log_attr_4xx [
    :status_code,
    :request_path,
    :request_id,
    :host,
    :session_id,
    :crash_reason,
    :get_params,
    :request_type,
    :tracking_id
  ]

  @log_attr_5xx [
    :status_code,
    :request_path,
    :request_id,
    :host,
    :session_id,
    :stack_trace,
    :get_params,
    :request_type,
    :tracking_id,
    :crash_reason,
    :assigns,
    :cookies,
    :req_headers,
    :resp_headers,
    :scheme
  ]

  @spec handle_request(atom | %{host: any}) :: {:request_log, :noop | map}
  def handle_request(metadata), do: metadata |> create_log()

  defp create_log(%{status_code: 404} = metadata), do: create_404_log(metadata)
  defp create_log(%{status_code: 500} = metadata), do: create_500_log(metadata)
  defp create_log(%{status_code: 200} = metadata), do: create_200_log(metadata)
  defp create_log(_), do: {:request_log, :noop}

  defp create_404_log(metadata) do
    log = metadata |> Map.take(@log_attr_4xx)

    {:request_log, log}
  end

  defp create_500_log(metadata) do
    log = metadata |> Map.take(@log_attr_5xx)

    {:request_log, log}
  end

  defp create_200_log(metadata) do
    log = metadata |> Map.take(@log_attr_4xx)

    {:request_log, log}
  end
end
