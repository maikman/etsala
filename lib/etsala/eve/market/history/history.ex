defmodule Etsala.Eve.Market.History.History do
  use Ecto.Schema
  import Ecto.Changeset

  schema "order_history" do
    field :average_order_count, :integer
    field :average_price, :float
    field :average_volume, :integer
    field :region_id, :integer
    field :type_id, :integer

    timestamps()
  end

  @doc false
  def changeset(history, attrs) do
    history
    |> cast(attrs, [:type_id, :region_id, :average_price, :average_order_count, :average_volume])
    |> validate_required([
      :type_id,
      :region_id,
      :average_price,
      :average_order_count,
      :average_volume
    ])
    |> unique_constraint([:type_id, :region_id])
  end
end
