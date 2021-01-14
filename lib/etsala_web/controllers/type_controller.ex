defmodule EtsalaWeb.TypeController do
  use EtsalaWeb, :controller
  alias EtsalaWeb.Router.Helpers, as: Routes
  alias Etsala.Eve.Universe.Types
  alias Etsala.Eve.Market.Order
  alias WDI.ESI.Images

  def types(conn, _params) do
    types = Types.list_types() |> Enum.sort(&(&1.name <= &2.name))
    render(conn, "types.html", types: types)
  end

  def type_details(conn, %{"id" => name}) do
    access_token = get_session(conn, :access_token)

    type =
      name
      |> Tools.Formatter.decode_name()
      |> Types.get_type_by_name()

    market_orders =
      Order.get_sell_order_by_type_id(type.type_id)
      |> Enum.map(&EtsalaWeb.Objects.TypeOrder.new(&1, access_token))
      |> Enum.sort_by(&{&1.name, &1.price})

    details =
      %{}
      |> Map.put(:type_id, type.type_id)
      |> Map.put(:name, type.name)
      |> Map.put(:description, type.description |> format_description())
      |> Map.put(:image_url, Images.get_image(type.type_id, 64))

    render(conn, "type_details.html", details: details, market_orders: market_orders)
  end

  def format_description(nil), do: ""

  def format_description(description) do
    description
    |> String.replace("\r\n", "<br>")
    # TODO: add faction and other logic
    |> String.replace("showinfo:30//", "/faction/")
    |> String.replace("showinfo:", "/types/")
  end
end
