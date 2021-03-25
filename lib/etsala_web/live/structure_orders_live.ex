defmodule EtsalaWeb.StructureOrdersLive do
  use Phoenix.LiveView
  alias EtsalaWeb.MarketView
  alias WDI.ESI.Markets.CharacterOrders
  alias WDI.ESI.Markets.Structures
  alias EtsalaWeb.Objects.CharacterOrder
  alias EtsalaWeb.Objects.Structure
  alias EtsalaWeb.Objects.LocationOrder
  alias Etsala.Eve.Universe.Categories
  alias Etsala.Eve.Universe.Groups
  alias Tools.Tracking

  @impl true
  def render(assigns) do
    Phoenix.View.render(MarketView, "structure_orders_live.html", assigns)
  end

  @impl true
  def mount(_params, session, socket) do
    structure = session["structure"]
    access_token = session["access_token"]
    character_id = session["character_id"]
    send(self(), {:load_market_orders, access_token, structure.id})

    character_orders =
      character_id
      |> CharacterOrders.get_orders(access_token)
      |> Enum.filter(&(&1["location_id"] == String.to_integer(structure.id)))

    {:ok,
     assign(socket,
       structure: structure,
       filter: nil,
       session: session,
       selected_order_type: "Sell",
       orders: [],
       all_orders: [],
       character_orders: character_orders,
       character_order_ids: Enum.map(character_orders, & &1["order_id"]),
       character_order_summary: CharacterOrder.get_order_summary(character_orders),
       categories: Categories.list_categories(),
       access_token: access_token,
       loading: true
     )}
  end

  @impl true
  def handle_info({:load_market_orders, access_token, structure_id}, socket) do
    orders =
      structure_id
      |> Structures.get_orders(access_token)
      |> Enum.map(&LocationOrder.new(&1))
      |> Enum.filter(&(&1.type_id != nil))
      |> Enum.sort_by(&{&1.name, &1.price})

    {:noreply,
     assign(socket,
       orders: orders,
       all_orders: orders,
       loading: false
     )}
  end

  @impl true
  def handle_event("category_select", %{"category" => "all"}, socket) do
    track_filter_event("all", socket.assigns.session)

    character_order_summary =
      socket.assigns.character_orders |> get_character_order_summary(socket.assigns.all_orders)

    {:noreply,
     assign(socket,
       orders: socket.assigns.all_orders,
       character_order_summary: character_order_summary,
       filter: nil
     )}
  end

  @impl true
  def handle_event("category_select", %{"category" => category_id}, socket) do
    track_filter_event(category_id, socket.assigns.session)

    group_ids =
      category_id
      |> Groups.list_groups_by_category()
      |> Enum.map(& &1.group_id)

    filtered =
      socket.assigns.all_orders
      |> Enum.filter(fn order -> Enum.member?(group_ids, order.group_id) end)

    character_order_summary =
      socket.assigns.character_orders |> get_character_order_summary(filtered)

    {:noreply,
     assign(socket,
       orders: filtered,
       character_order_summary: character_order_summary,
       filter: category_id |> String.to_integer()
     )}
  end

  @impl true
  def handle_event("market_details_sell", _, socket) do
    socket.assigns.session |> Tracking.track_event("buy/sell", "sell", "structure_orders")

    {:noreply, assign(socket, selected_order_type: "Sell")}
  end

  @impl true
  def handle_event("market_details_buy", _, socket) do
    socket.assigns.session |> Tracking.track_event("buy/sell", "buy", "structure_orders")

    {:noreply, assign(socket, selected_order_type: "Buy")}
  end

  defp get_character_order_summary(character_orders, all_orders) do
    character_orders
    |> Enum.filter(fn %{"order_id" => c_order_id} ->
      all_orders
      |> Enum.find_value(fn order -> order.order_id == c_order_id end)
    end)
    |> CharacterOrder.get_order_summary()
  end

  defp track_filter_event("all", session) do
    Tracking.track_event(session, "filter", "all", "structure_orders")
  end

  defp track_filter_event(category_id, session) do
    category = category_id |> Categories.get_category_by_category_id() |> Map.get(:name)
    Tracking.track_event(session, "filter", category, "structure_orders")
  end
end
