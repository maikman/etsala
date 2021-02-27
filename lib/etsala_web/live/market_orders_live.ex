defmodule EtsalaWeb.TypeDetailsLive do
  use Phoenix.LiveView
  alias EtsalaWeb.TypeView
  alias Etsala.Eve.Market.Order

  @impl true
  def render(assigns) do
    Phoenix.View.render(TypeView, "type_details_live.html", assigns)
  end

  @impl true
  def mount(_params, session, socket) do
    send(self(), {:load_market_orders, session["access_token"], session["details"]})

    access_token = session["access_token"]
    type = session["details"]

    {:ok,
     assign(socket,
       details: type,
       market_orders: [],
       loading: true,
       access_token: access_token
     )}
  end

  @impl true
  def handle_info({:load_sell_data, access_token, type}, socket) do
    market_orders =
      Order.get_sell_order_by_type_id(type.type_id)
      |> Enum.map(&EtsalaWeb.Objects.TypeOrder.new(&1, access_token))
      |> Enum.sort_by(&{&1.name, &1.price})

    {:noreply,
     assign(socket,
       market_orders: market_orders,
       loading: false
     )}
  end
end
