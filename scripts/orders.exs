defmodule Importer.Orders do
  alias Etsala.Eve.Market.Order
  alias WDI.ESI.Markets.Orders

  require Logger

  def import_orders do
    # regions = get_regions()
    regions = [10_000_002]

    regions |> Enum.each(&import_orders(&1))
  end

  def import_orders(region_id) do
    delete_old_orders(region_id)

    orders = Orders.get_orders(region_id)
    orders |> Enum.each(&import_order(&1, region_id))

    orders |> Tools.Importer.output_count("Region ID: #{region_id}")
  end

  defp import_order(order, region_id) when is_map(order) do
    order |> Map.put("region_id", region_id) |> Order.create_order()

    :ok
  end

  defp import_order(_order, _), do: nil

  defp delete_old_orders(region_id) do
    result = Order.delete_old_orders(region_id)

    Logger.info("deleted #{result.num_rows} old orders.")
  end

end

Importer.Orders.import_orders()
