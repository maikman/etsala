defmodule Etsala.Eve.Universe.Types.Types do
  use Ecto.Schema
  import Ecto.Changeset

  schema "types" do
    field :name, :string
    field :type_id, :integer
    field :capacity, :float
    field :description, :string
    field :group_id, :integer
    field :icon_id, :integer
    field :market_group_id, :integer
    field :mass, :float
    field :packaged_volume, :float
    field :portion_size, :integer
    field :radius, :float
    field :volume, :float

    timestamps()
  end

  @doc false
  def changeset(type, attrs) do
    type
    |> cast(attrs, [
      :name,
      :type_id,
      :capacity,
      :description,
      :group_id,
      :icon_id,
      :market_group_id,
      :mass,
      :packaged_volume,
      :portion_size,
      :radius,
      :volume
    ])
    |> validate_required([:type_id, :name])
    |> unique_constraint(:type_id)
  end
end
