defmodule WDI.MSP.Client do
  @moduledoc """
    client for sending events to Googles Measurement Protocol (MSP)
  """

  @endpoint Application.get_env(:etsala, :static_endpoints)[:GoogleAnalytics]

  def send_event(event) do
    HTTPoison.post(@endpoint.url, build_query(event), headers(), http_opts())
  end

  defp build_query(event), do: URI.encode_query(Map.merge(event, %{tid: @endpoint.property_id}))

  defp headers, do: []

  defp http_opts, do: []
end
