defmodule EtsalaWeb.Objects.MarketInsight do
  import Ecto.Changeset
  import Tools.Formatter

  # alias WDI.ESI.Images
  alias Etsala.Eve.Universe.Types
  alias Etsala.Eve.Market.History.History

  defstruct [
    :type_id,
    # :image,
    :name,
    :region_id,
    :average_price,
    :average_volume,
    :average_order_count,
    :market_score
  ]

  def new(order_history = %History{}) do
    %__MODULE__{
      type_id: order_history.type_id,
      # image: Images.get_image(esi_order["type_id"], 64),
      name: get_name(order_history.type_id),
      average_price: format_price(order_history.average_price),
      average_volume: order_history.average_volume,
      average_order_count: order_history.average_order_count,
      market_score: order_history.market_score |> Float.floor(2)
    }
  end

  def new(order_history) do
    History.changeset(%History{}, order_history) |> apply_changes() |> new()
  end

  defp get_name(type_id) do
    {:ok, result} =
      :ets.lookup(:type_names, type_id)
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
    |> Enum.each(&:ets.insert(:type_names, {&1.type_id, &1.name}))
  end
end
