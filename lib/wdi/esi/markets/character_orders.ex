defmodule WDI.ESI.Markets.CharacterOrders do

    def get_orders(character_id) do
        [access_token: token] = :ets.lookup(:session, :access_token)
        "characters/#{character_id}/orders/"
         |> WDI.ESI.Call.handle_call(%{token: token})
    end
end