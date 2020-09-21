defmodule Importer.OrderHistory do
  require Logger

  alias Etsala.Eve.Universe.Types
  alias WDI.ESI.Markets.History
  alias Etsala.Eve.Market.History, as: MarketHistory

  def import(region_id \\ 10_000_002) do
    types_list = Types.list_types()
    types_list |> Enum.each(&create_order_history(region_id, &1.type_id))

    types_list |> Tools.Importer.output_count()
  end

  defp create_order_history(region_id, type_id) do
    Logger.debug("TYPE ID #{type_id} IN REGION #{region_id}")

    History.get_history(region_id, type_id)
    |> save_30_days_average(region_id, type_id)
  end

  defp save_30_days_average(history, region_id, type_id) when is_list(history) do
    history
    |> Enum.sort(&(&1["date"] >= &2["date"]))
    |> Enum.take(30)
    |> get_monthly_average()
    |> Map.merge(%{region_id: region_id, type_id: type_id})
    |> MarketHistory.insert_or_update_history()
  end

  defp save_30_days_average(_, _, _), do: nil

  defp get_monthly_average(last_30_days) do
    Map.put(%{}, :average_price, get_monthly_average(last_30_days, "average"))
    |> Map.put(:average_order_count, get_monthly_average(last_30_days, "order_count"))
    |> Map.put(:average_volume, get_monthly_average(last_30_days, "volume"))
  end

  defp get_monthly_average(last_30_days, attribute_name) do
    sum =
      last_30_days
      |> Enum.map(& &1[attribute_name])
      |> Enum.sum()

    Decimal.round(Decimal.from_float(sum / 30))
    |> Decimal.to_integer()
  end
end

Importer.OrderHistory.import()
