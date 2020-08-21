defmodule WDI.ESI.Universe.Regions do
    def get_regions() do
          "universe/regions"
          |> WDI.ESI.Call.handle_call()
    end

    def get_region_details(region_id) do    
        "universe/regions/#{region_id}"
        |> WDI.ESI.Call.handle_call()
    end
end