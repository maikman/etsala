defmodule WDI.ESI.Markets.Structures do

    def get_orders(structure_id) do
        "markets/structures/#{structure_id}"
        |> WDI.ESI.Call.handle_call()
    end
end