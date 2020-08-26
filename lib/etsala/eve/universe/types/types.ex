defmodule Etsala.Eve.Universe.Types.Types do
  use Ecto.Schema
  import Ecto.Changeset

  schema "types" do
    field :name, :string
    field :type_id, :integer
    field :average_price, :float
    field :average_order_count, :integer
    field :average_market_volume, :integer

    timestamps()
  end

  @doc false
  def changeset(type, attrs) do
    type
    |> cast(attrs, [:type_id, :name, :average_price, :average_order_count, :average_market_volume])
    |> validate_required([:type_id, :name])
    |> unique_constraint(:type_id)
  end
end
