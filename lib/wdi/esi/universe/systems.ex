defmodule WDI.ESI.Universe.Systems do
    def get_system_id_list() do
          "universe/systems"
          |> WDI.ESI.Call.handle_call()
    end

    def get_system_details(system_id) do    
        "universe/systems/#{system_id}"
        |> WDI.ESI.Call.handle_call()
    end
end