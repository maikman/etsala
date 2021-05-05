defmodule EtsalaWeb.MarketController do
  use EtsalaWeb, :controller
  alias WDI.ESI.Markets.CharacterOrders
  alias EtsalaWeb.Objects.CharacterOrder
  alias EtsalaWeb.Objects.Structure

  import Plug.Conn

  def character_market_orders(%{assigns: %{character_id: nil}} = conn, _) do
    conn
    |> redirect(external: conn.assigns.login_url)
  end

  def character_market_orders(%{assigns: %{is_member: false}} = conn, _params) do
    conn
    |> redirect(to: Routes.page_path(conn, :index))
  end

  def character_market_orders(conn, _params) do
    access_token = get_session(conn, :access_token)
    character_id = get_session(conn, :character_id)

    orders =
      character_id
      |> CharacterOrders.get_orders(access_token)
      |> Enum.map(&CharacterOrder.new(&1, access_token))
      |> Enum.sort_by(&{&1.name, &1.price})

    conn
    |> assign(:orders, orders)
    |> assign(:page_title, "My Orders")
    |> render("character_orders.html")
  end

  def structure_market_orders(%{assigns: %{character_id: nil}} = conn, _) do
    conn
    |> redirect(external: conn.assigns.login_url)
  end

  def structure_market_orders(%{assigns: %{is_member: false}} = conn, _params) do
    conn
    |> redirect(to: Routes.page_path(conn, :index))
  end

  def structure_market_orders(%{assigns: %{is_member: true}} = conn, params) do
    structure_id = Map.get(params, "id")
    access_token = get_session(conn, :access_token)

    structure =
      structure_id
      |> WDI.ESI.Universe.Structures.get_structure_details(access_token)
      |> Structure.new()

    conn
    |> assign(:structure, structure)
    |> assign(:page_title, structure.name)
    |> render("structure_orders.html")
  end

  def structure_optimizer(%{assigns: %{character_id: nil}} = conn, _) do
    conn
    |> redirect(external: conn.assigns.login_url)
  end

  def structure_optimizer(%{assigns: %{is_member: false}} = conn, _params) do
    conn
    |> redirect(to: Routes.page_path(conn, :index))
  end

  def structure_optimizer(%{assigns: %{is_member: true}} = conn, params) do
    structure_id = Map.get(params, "structure_id")
    access_token = get_session(conn, :access_token)

    structure =
      structure_id
      |> WDI.ESI.Universe.Structures.get_structure_details(access_token)
      |> Structure.new()

    conn
    |> assign(:structure, structure)
    |> assign(:page_title, "#{structure.name} Market Optimizer")
    |> render("structure_optimizer.html")
  end
end
