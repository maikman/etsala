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

    structure =
      structure_id |> WDI.ESI.Universe.Structures.get_structure_details() |> Structure.new()

    orders = structure_id |> Structures.get_orders() |> Enum.map(&Order.new(&1))
    render(conn, "structure_orders.html", structure: structure, orders: orders)
  end

  def structure_to_station_comparison(conn, params) do
    structure_id = Map.get(params, "structure_id")
    location_id = Map.get(params, "location_id")

    structure_orders = structure_id |> Structures.get_orders()
    station_orders = location_id |> Etsala.Eve.Market.Order.get_order_by_location_id()

    structure =
      structure_id |> WDI.ESI.Universe.Structures.get_structure_details() |> Structure.new()

    what_to_sell =
      missing_types_in_structure(structure_orders, station_orders) |> Enum.map(&Order.new(&1))

    render(
      conn,
      "structure_to_station_comparison.html",
      orders: what_to_sell,
      structure: structure
    )
  end

  def missing_types_in_structure(structure_orders, station_orders) do
    structure_types = get_structure_types(structure_orders)

    station_orders
    |> Enum.filter(&filter_station_order(&1, structure_types))
    |> Enum.uniq_by(& &1.type_id)
  end

  def filter_station_order(station_order, structure_types) do
    !Enum.member?(structure_types, station_order.type_id) &&
      station_order.volume_total > 10 &&
      station_order.is_buy_order == false &&
      station_order.volume_remain < station_order.volume_total
  end

  def get_structure_types(orders) do
    orders
    |> Enum.map(& &1["type_id"])
    |> Enum.uniq()
  end
end
