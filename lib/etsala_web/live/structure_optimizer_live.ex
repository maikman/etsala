defmodule EtsalaWeb.StructureOptimizerLive do
  use Phoenix.LiveView
  alias EtsalaWeb.MarketView
  alias WDI.ESI.Markets.CharacterOrders
  alias WDI.ESI.Markets.Structures
  alias EtsalaWeb.Objects.CharacterOrder
  alias EtsalaWeb.Objects.Structure
  alias EtsalaWeb.Objects.LocationOrder
  alias Etsala.Eve.Universe.Categories
  alias Etsala.Eve.Universe.Groups
  alias WDI.ESI.Markets.Structures
  alias EtsalaWeb.Objects.LocationOrder
  alias EtsalaWeb.Objects.MarketInsight
  alias Etsala.Eve.Market.History
  alias Etsala.Eve.Universe.Categories
  alias Tools.Tracking

  @impl true
  def render(assigns) do
    Phoenix.View.render(MarketView, "structure_optimizer_live.html", assigns)
  end

  @impl true
  def mount(_params, session, socket) do
    structure = session["structure"]
    access_token = session["access_token"]
    send(self(), {:load_insights, access_token, structure.id})

    {:ok,
     assign(socket,
       structure: structure,
       session: session,
       categories: Categories.list_categories(),
       filter: nil,
       insights: [],
       all_insights: [],
       loading: true
     )}
  end

  @impl true
  def handle_info({:load_insights, access_token, structure_id}, socket) do
    structure_orders =
      structure_id
      |> Structures.get_orders(access_token)
      |> Enum.filter(&(Map.get(&1, "is_buy_order") == false))

    # region_id = get_region_id(location_id) // TODO
    region_id = 10_000_002

    what_to_sell =
      missing_types_in_structure(structure_orders)
      |> get_market_insight(region_id)
      |> Enum.sort(&(&1.market_score >= &2.market_score))
      |> Enum.filter(&(&1.market_score > 1))
      |> Enum.map(&MarketInsight.new(&1))

    {:noreply,
     assign(socket,
       insights: what_to_sell,
       all_insights: what_to_sell,
       loading: false
     )}
  end

  @impl true
  def handle_event("category_select", %{"category" => "all"}, socket) do
    track_filter_event("all", socket.assigns.session)

    {:noreply,
     assign(socket,
       insights: socket.assigns.all_insights,
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
      socket.assigns.all_insights
      |> Enum.filter(fn insight -> Enum.member?(group_ids, insight.group_id) end)

    {:noreply,
     assign(socket,
       insights: filtered,
       filter: category_id |> String.to_integer()
     )}
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

    score = (price_score * 0.1 + order_count_score * 0.4 + volume_score * 0.5) * 100
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

  defp track_filter_event("all", session) do
    Tracking.track_event(session, "filter", "all", "structure_optimizer")
  end

  defp track_filter_event(category_id, session) do
    category = category_id |> Categories.get_category_by_category_id() |> Map.get(:name)
    Tracking.track_event(session, "filter", category, "structure_optimizer")
  end
end
