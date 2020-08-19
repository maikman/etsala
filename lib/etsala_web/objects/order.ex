defmodule EtsalaWeb.Objects.Order do
    # alias WDI.ESI.Images
    alias Etsala.Eve.Universe.Types
    alias WDI.ESI.Universe.Structures
    alias EtsalaWeb.Objects.Structure

    defstruct [
        :type_id,
        # :image,
        :name,
        :station,
        :price,
        :quantity,
        :expires_in,
        :order_type
    ]

    def new(esi_order) do
        %__MODULE__{
            type_id: esi_order["type_id"],
            # image: Images.get_image(esi_order["type_id"], 64),
            name: Types.get_type_by_type_id(esi_order["type_id"]).name,
            station: Structures.get_structure_details(esi_order["location_id"]) |> Structure.new(),
            price: esi_order["price"] |> Decimal.cast() |> Decimal.round(2),
            quantity: "#{esi_order["volume_remain"]}/#{esi_order["volume_total"]}",
            expires_in: calculate_expire_time(esi_order["issued"], esi_order["duration"]),
            order_type: get_order_type(esi_order["is_buy_order"])
        }
    end

    defp calculate_expire_time(issued, duration) do
        {:ok, datetime, 0} = DateTime.from_iso8601(issued)
        expire_date = DateTime.add(datetime, duration*24*60*60)
        {:ok, now} = DateTime.now("Etc/UTC")
        {days, _} = DateTime.diff(expire_date, now)/60/60/24 
        |> Float.floor()
        |> Float.to_string()
        |> Integer.parse()

        days
    end 

    defp get_order_type(nil), do: "Sell"
    defp get_order_type(false), do: "Sell"
    defp get_order_type(true), do: "Buy"
end
