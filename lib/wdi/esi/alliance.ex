defmodule WDI.ESI.Alliance do
  def get_corporations(alliance_id) do
    "alliances/#{alliance_id}/corporations"
    |> WDI.ESI.Call.handle_call(%{}, true)
  end
end
