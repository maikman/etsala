defmodule EtsalaWeb.MarketController do
    use EtsalaWeb, :controller
    alias WDI.ESI.Markets.CharacterOrders
    alias WDI.ESI.Markets.Structures
    alias EtsalaWeb.Objects.Order
    alias EtsalaWeb.Objects.Structure

    import Plug.Conn
  
    def character_market_orders(conn, _params) do
      session = conn |> get_session()
      character_id = session["character_id"]
      orders = CharacterOrders.get_orders(character_id) |> Enum.map(&Order.new(&1))
      render(conn, "character_orders.html", orders: orders)
    end

    def structure_market_orders(conn, params) do
        structure_id = Map.get(params, "id")
        structure = structure_id |> WDI.ESI.Universe.Structures.get_structure_details() |> Structure.new()
        orders = structure_id |> Structures.get_orders() |> Enum.map(&Order.new(&1))
        render(conn, "structure_orders.html", structure: structure, orders: orders)
    end

    # def structure_to_station_comparison(conn, params) do
    #     structure_id = Map.get(params, "structure_id")
    #     region_id = Map.get(params, "region_id")
    #     station_id = Map.get(params, "station_id")

    #     structure_orders = structure_id |> Structures.get_orders() |> Enum.map(&Order.new(&1))
    #     station_orders = Stations.get_orders()
    # end
  end
