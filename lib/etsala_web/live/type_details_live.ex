defmodule EtsalaWeb.TypeDetailsLive do
  use Phoenix.LiveView
  import Phoenix.HTML.Link
  alias EtsalaWeb.TypeView
  alias Etsala.Eve.Market.Order

  @impl true
  def render(assigns) do
    Phoenix.View.render(TypeView, "type_details_live.html", assigns)
  end

  @impl true
  def mount(_params, session, socket) do
    {:ok,
     assign(socket,
       details: session["details"],
       market_orders: session["market_orders"],
       access_token: session["access_token"]
     )}
  end

  def handle_event("market_details_sell", _params, socket) do
    market_orders =
      Order.get_sell_order_by_type_id(socket.assigns.details.type_id)
      |> Enum.map(&EtsalaWeb.Objects.TypeOrder.new(&1, socket.assigns.access_token))
      |> Enum.sort_by(&{&1.name, &1.price})

    {:noreply, assign(socket, market_orders: market_orders)}
  end

  def handle_event("market_details_buy", _params, socket) do
    market_orders =
      Order.get_buy_order_by_type_id(socket.assigns.details.type_id)
      |> Enum.map(&EtsalaWeb.Objects.TypeOrder.new(&1, socket.assigns.access_token))
      |> Enum.sort_by(&{&1.name, &1.price})

    {:noreply, assign(socket, market_orders: market_orders)}
  end

  # def handle_event("suggest", %{"q" => _query}, socket) do
  #   {:noreply, assign(socket, matches: [])}
  # end

  # def handle_event("search", %{"q" => query}, socket) when byte_size(query) <= 100 do
  #   send(self(), {:search, query})
  #   {:noreply, assign(socket, query: query, result: "Searching...", loading: true, matches: [])}
  # end

  # def handle_info({:search, query}, socket) do
  #   result =
  #     Etsala.Eve.Universe.Types.search_type(query)
  #     |> Enum.map(& &1.name)
  #     |> Enum.sort_by(&byte_size/1)

  #   {:noreply, assign(socket, loading: false, result: result, matches: [])}
  # end
end
