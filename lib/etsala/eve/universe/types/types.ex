defmodule Etsala.Eve.Universe.Types.Types do
  use Ecto.Schema
  import Ecto.Changeset

  schema "types" do
    field :name, :string
    field :type_id, :integer

    timestamps()
  end

  @doc false
  def changeset(type, attrs) do
    type
    |> cast(attrs, [:type_id, :name])
    |> validate_required([:type_id, :name])
    |> unique_constraint(:type_id)
  end
end
