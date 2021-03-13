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
    :group_id,
    :region_id,
    :average_price,
    :average_volume,
    :average_order_count,
    :market_score
  ]

  def new(order_history = %History{}) do
    type = Types.get_type_from_cache(order_history.type_id)

    %__MODULE__{
      type_id: order_history.type_id,
      group_id: type |> Map.get(:group_id),
      # image: Images.get_image(esi_order["type_id"], 64),
      name: type |> Map.get(:name),
      average_price: format_price(order_history.average_price),
      average_volume: order_history.average_volume,
      average_order_count: order_history.average_order_count,
      market_score: order_history.market_score |> Float.floor(2)
    }
  end

  def new(order_history) do
    History.changeset(%History{}, order_history) |> apply_changes() |> new()
  end
end
