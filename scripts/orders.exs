defmodule Importer.Orders do
  alias Etsala.Eve.Market.Order
  alias WDI.ESI.Markets.Orders

  def import_jita_orders do
    orders = Orders.get_orders(10_000_002)
    orders |> Enum.each(&import_jita_order(&1))

    orders |> Importer.Helper.output_count()
  end

  defp import_jita_order(order) when is_map(order) do
    order
    |> Map.get("location_id")
    |> case do
      60_003_760 -> Order.insert_or_update_order(order)
      _ -> nil
    end

    :ok
  end

  defp import_jita_order(_order), do: nil
end

Importer.Orders.import_jita_orders()
