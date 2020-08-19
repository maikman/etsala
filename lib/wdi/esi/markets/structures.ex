defmodule WDI.ESI.Markets.Structures do

    def get_orders(structure_id) do
        [access_token: token] = :ets.lookup(:session, :access_token)

        "markets/structures/#{structure_id}"
        |> WDI.ESI.Call.handle_call(%{token: token})
    end
end