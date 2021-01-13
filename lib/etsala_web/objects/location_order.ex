defmodule EtsalaWeb.Objects.LocationOrder do
  import Ecto.Changeset
  import Tools.Formatter

  # alias WDI.ESI.Images
  alias Etsala.Eve.Universe.Types
  alias WDI.ESI.Universe.Structures
  alias WDI.ESI.Universe.Stations
  alias EtsalaWeb.Objects.Structure
  alias Etsala.Eve.Market.Order.Order
  alias Tools.Cache

  defstruct [
    :type_id,
    # :image,
    :name,
    # :station,
    :price,
    :quantity,
    :expires_in,
    :order_type,
    :order_id
  ]

  def new(esi_order = %Order{}) do
    %__MODULE__{
      type_id: esi_order.type_id,
      # image: Images.get_image(esi_order["type_id"], 64),
      name: get_name(esi_order.type_id),
      # station: get_station_or_structure(esi_order.location_id),
      # price: esi_order.price |> Decimal.cast() |> Decimal.round(2),
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

  defp get_name(type_id) do
    {:ok, result} =
      Cache.get_one(type_id, :type_names)
      |> case do
        [{_full_url, result}] -> {:ok, result}
        [] -> get_name_from_db(type_id)
        _ -> {:error, "Caching Error"}
      end

    result
  end

  defp get_name_from_db(type_id) do
    cache_all_names()

    name =
      Types.get_type_by_type_id(type_id)
      |> case do
        nil -> "Type not found"
        type -> type.name
      end

    {:ok, name}
  end

  defp cache_all_names() do
    Types.list_types()
    |> Enum.each(&Cache.insert({&1.type_id, &1.name}, :type_names))
  end

  # defp get_station_or_structure(location_id) when location_id >= 1_000_000_000_000 do
  #   Structures.get_structure_details(location_id) |> Structure.new()
  # end

  # defp get_station_or_structure(location_id) do
  #   Stations.get_station_details(location_id) |> Structure.new()
  # end
end