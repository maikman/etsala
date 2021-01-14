defmodule WDI.ESI.Corporation do
  def get_logo(corp_id, size \\ 64) do
    "corporations/#{corp_id}/icons"
    |> WDI.ESI.Call.handle_call(%{}, true)
    |> Map.get("px#{size}x#{size}")
  end
end
