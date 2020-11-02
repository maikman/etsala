defmodule EtsalaWeb.MarketController do
  use EtsalaWeb, :controller
  alias WDI.ESI.Markets.CharacterOrders
  alias WDI.ESI.Markets.Structures
  alias EtsalaWeb.Objects.LocationOrder
  alias EtsalaWeb.Objects.CharacterOrder
  alias EtsalaWeb.Objects.MarketInsight
  alias EtsalaWeb.Objects.Structure
  alias Etsala.Eve.Market.History

  import Plug.Conn

  def character_market_orders(conn, _params) do
    access_token = get_session(conn, :access_token)
    character_id = get_session(conn, :character_id)

    orders =
      character_id
      |> CharacterOrders.get_orders(access_token)
      |> Enum.map(&CharacterOrder.new(&1, access_token))
      |> Enum.sort_by(&{&1.name, &1.price})

    render(conn, "character_orders.html", orders: orders)
  end

  def structure_market_orders(conn, params) do
    structure_id = Map.get(params, "id")
    access_token = get_session(conn, :access_token)
    character_id = get_session(conn, :character_id)

    structure =
      structure_id
      |> WDI.ESI.Universe.Structures.get_structure_details(access_token)
      |> Structure.new()

    orders =
      structure_id
      |> Structures.get_orders(access_token)
      |> Enum.map(&LocationOrder.new(&1))
      |> Enum.sort_by(&{&1.name, &1.price})

    character_order_ids =
      character_id
      |> CharacterOrders.get_orders(access_token)
      |> Enum.map(& &1["order_id"])

    render(conn, "structure_orders.html",
      structure: structure,
      orders: orders,
      character_order_ids: character_order_ids
    )
  end

  def structure_optimizer(conn, params) do
    structure_id = Map.get(params, "structure_id")
    access_token = get_session(conn, :access_token)

    structure_orders = structure_id |> Structures.get_orders(access_token)
    # region_id = get_region_id(location_id) // TODO
    region_id = 10_000_002

    structure =
      structure_id
      |> WDI.ESI.Universe.Structures.get_structure_details(access_token)
      |> Structure.new()

    what_to_sell =
      missing_types_in_structure(structure_orders)
      |> get_market_insight(region_id)
      |> Enum.sort(&(&1.market_score >= &2.market_score))
      |> Enum.map(&MarketInsight.new(&1))

    render(
      conn,
      "structure_optimizer.html",
      insights: what_to_sell,
      structure: structure
    )
  end

  defp missing_types_in_structure(structure_orders) do
    structure_types = get_structure_types(structure_orders)

    Etsala.Eve.Market.History.list_order_history()
    |> Enum.filter(&filter_station_order(&1, structure_types))
    |> Enum.map(& &1.type_id)
  end

  defp filter_station_order(all_types, structure_types) do
    !Enum.member?(structure_types, all_types.type_id)
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
