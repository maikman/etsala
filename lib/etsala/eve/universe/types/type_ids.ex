defmodule Etsala.Eve.Universe.Types.TypeIds do
  use Ecto.Schema
  import Ecto.Changeset

  schema "type_ids" do
    field :name, :string
    field :type_id, :integer

    timestamps()
  end

  @doc false
  def changeset(type_ids, attrs) do
    type_ids
    |> cast(attrs, [:type_id, :name])
    |> validate_required([:type_id, :name])
    |> unique_constraint(:type_id)
  end
end
