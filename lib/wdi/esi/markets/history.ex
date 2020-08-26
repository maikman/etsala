defmodule WDI.ESI.Markets.History do
  
    def get_history(region_id, type_id) do
        "markets/#{region_id}/history"
        |> WDI.ESI.Call.handle_call(%{type_id: type_id})
    end
  end
  