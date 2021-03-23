defmodule WDI.ESI.Corporation do
  def get_information(corp_id) do
    "corporations/#{corp_id}"
    |> WDI.ESI.Call.handle_call(%{}, true)
  end

  def get_logo(corp_id, size \\ 64) do
    "corporations/#{corp_id}/icons"
    |> WDI.ESI.Call.handle_call(%{}, true)
    |> Map.get("px#{size}x#{size}")
  end

  def get_structures(corp_id, access_token) do
    "corporations/#{corp_id}/structures"
    |> WDI.ESI.Call.handle_call(%{token: access_token}, true)
  end
end
