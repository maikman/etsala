defmodule WDI.ESI.Markets.CharacterOrders do
  def get_orders(character_id, access_token) do
    "characters/#{character_id}/orders/"
    |> WDI.ESI.Call.handle_call(%{token: access_token})
  end
end
