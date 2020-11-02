defmodule WDI.ESI.Markets.Structures do
  def get_orders(structure_id, access_token) do
    "markets/structures/#{structure_id}"
    |> WDI.ESI.Call.handle_call(%{token: access_token})
  end
end
