defmodule WDI.ESI.Markets.Orders do
  def get_orders(region_id, page \\ 1, result \\ []) do
    list = get_orders_page(region_id, page)
    get_result(region_id, page, list, result)
  end

  def get_orders_page(region_id, page) do
    "markets/#{region_id}/orders"
    |> WDI.ESI.Call.handle_call(%{page: page})
  end

  defp get_result(_region_id, _page, %{"error" => _error}, result) do
    result
  end

  defp get_result(region_id, page, list, result) when is_list(list) do
    region_id |> get_orders(page + 1, list ++ result)
  end
end
