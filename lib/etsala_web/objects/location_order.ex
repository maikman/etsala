defmodule EtsalaWeb.Objects.LocationOrder do
  import Ecto.Changeset
  import Tools.Formatter

  # alias WDI.ESI.Images
  alias Etsala.Eve.Universe.Types
  # alias WDI.ESI.Universe.Structures
  # alias WDI.ESI.Universe.Stations
  # alias EtsalaWeb.Objects.Structure
  alias Etsala.Eve.Market.Order.Order

  defstruct [
    :type_id,
    # :image,
    :name,
    :group_id,
    :price,
    :quantity,
    :expires_in,
    :order_type,
    :order_id
  ]

  def new(esi_order = %Order{}) do
    type = Types.get_type_from_cache(esi_order.type_id)

    %__MODULE__{
      type_id: type |> Map.get(:type_id),
      name: type |> Map.get(:name),
      group_id: type |> Map.get(:group_id),
      price: format_price(esi_order.price),
      quantity: "#{esi_order.volume_remain}/#{esi_order.volume_total}",
      expires_in: calculate_expire_time(esi_order.issued, esi_order.duration),
      order_type: get_order_type(esi_order.is_buy_order),
      order_id: esi_order.order_id
    }
  end

  def new(esi_order) do
    Order.changeset(%Order{}, esi_order) |> apply_changes() |> new()
  end

  defp calculate_expire_time(issued, duration) do
    {:ok, datetime, 0} = DateTime.from_iso8601(issued)
    expire_date = DateTime.add(datetime, duration * 24 * 60 * 60)
    {:ok, now} = DateTime.now("Etc/UTC")

    {days, _} =
      (DateTime.diff(expire_date, now) / 60 / 60 / 24)
      |> Float.floor()
      |> Float.to_string()
      |> Integer.parse()

    days
  end

  defp get_order_type(nil), do: "Sell"
  defp get_order_type(false), do: "Sell"
  defp get_order_type(true), do: "Buy"

  # defp get_station_or_structure(location_id) when location_id >= 1_000_000_000_000 do
  #   Structures.get_structure_details(location_id) |> Structure.new()
  # end

  # defp get_station_or_structure(location_id) do
  #   Stations.get_station_details(location_id) |> Structure.new()
  # end
end
