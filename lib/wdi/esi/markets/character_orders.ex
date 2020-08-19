defmodule WDI.ESI.Markets.CharacterOrders do

    def get_orders(character_id) do
        "characters/#{character_id}/orders/"
         |> WDI.ESI.Call.handle_call()
    end
end