defmodule WDI.ESI.Markets.Orders do
  
    def get_orders(region_id, page \\ 1, result \\ []) do
      list = get_orders_page(region_id, page)
  
      case Enum.empty?(list) do
        false -> region_id |> get_orders(page + 1, list ++ result)
        true -> result
      end
    end
  
    def get_orders_page(region_id, page) do
        "markets/#{region_id}/orders"
        |> WDI.ESI.Call.handle_call(%{page: page})
    end
  end
  