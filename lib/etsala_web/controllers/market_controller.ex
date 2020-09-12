defmodule EtsalaWeb.MarketController do
  use EtsalaWeb, :controller
  alias WDI.ESI.Markets.CharacterOrders
  alias WDI.ESI.Markets.Structures
  alias EtsalaWeb.Objects.Order
  alias EtsalaWeb.Objects.MarketInsight
  alias EtsalaWeb.Objects.Structure
  alias Etsala.Eve.Market.History

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
    # region_id = get_region_id(location_id) // TODO
    region_id = 10_000_002

    structure =
      structure_id |> WDI.ESI.Universe.Structures.get_structure_details() |> Structure.new()

    what_to_sell =
      missing_types_in_structure(structure_orders, station_orders)
      |> get_market_insight(region_id)
      |> Enum.sort(&(&1.market_score >= &2.market_score))
      |> Enum.map(&MarketInsight.new(&1))

    render(
      conn,
      "structure_to_station_comparison.html",
      insights: what_to_sell,
      structure: structure
    )
  end

  defp missing_types_in_structure(structure_orders, station_orders) do
    structure_types = get_structure_types(structure_orders)

    station_orders
    |> Enum.filter(&filter_station_order(&1, structure_types))
    |> Enum.uniq_by(& &1.type_id)
    |> Enum.map(& &1.type_id)
  end

  defp filter_station_order(station_order, structure_types) do
    !Enum.member?(structure_types, station_order.type_id) && station_order.is_buy_order == false
  end

  defp get_structure_types(orders) do
    orders
    |> Enum.map(& &1["type_id"])
    |> Enum.uniq()
  end

  defp get_market_insight(h = %History.History{}, mv = %{}) do
    price_score = h.average_price / mv.max_price
    order_count_score = h.average_order_count / mv.max_order_count
    volume_score = h.average_volume / mv.max_volume

    score = (price_score * 0.1 + order_count_score * 0.3 + volume_score * 0.6) * 100
    Map.put(h, :market_score, score)
  end

  defp get_market_insight(type_ids, region_id) do
    max_values = History.get_maximums()

    type_ids
    |> Enum.map(&get_market_insight(&1, max_values, region_id))
    |> Enum.filter(&(&1 != nil))
  end

  defp get_market_insight(type_id, max_values = %{}, region_id) do
    History.get_history_by_type_id_and_region_id(type_id, region_id)
    |> case do
      nil ->
        nil

      h ->
        get_market_insight(h, max_values)
    end
  end
end
