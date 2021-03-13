defmodule EtsalaWeb.MarketController do
  use EtsalaWeb, :controller
  alias WDI.ESI.Markets.CharacterOrders
  alias EtsalaWeb.Objects.CharacterOrder
  alias EtsalaWeb.Objects.Structure

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

    structure =
      structure_id
      |> WDI.ESI.Universe.Structures.get_structure_details(access_token)
      |> Structure.new()

    render(conn, "structure_orders.html", structure: structure)
  end

  def structure_optimizer(conn, params) do
    structure_id = Map.get(params, "structure_id")
    access_token = get_session(conn, :access_token)

    structure =
      structure_id
      |> WDI.ESI.Universe.Structures.get_structure_details(access_token)
      |> Structure.new()

    render(
      conn,
      "structure_optimizer.html",
      structure: structure
    )
  end
end
