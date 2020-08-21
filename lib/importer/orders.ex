defmodule Importer.Orders do
    alias WDI.ESI.Universe.Regions
    alias Etsala.Eve.Market.Order
    alias WDI.ESI.Markets.Orders
  
    def import_jita_orders do
      Orders.get_orders(10000002)
      |> Enum.each(&import_order(&1))
    end
  
    defp import_order(order) when is_map(order) do
      order
      |> Map.get("location_id")
      |> case do
        60003760 -> Order.insert_or_update_order(order)
        _ -> nil
      end
    end
  
    defp import_order(_order), do: nil
  end
  