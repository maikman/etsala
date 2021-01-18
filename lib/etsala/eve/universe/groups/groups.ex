defmodule Etsala.Eve.Universe.Groups.Groups do
  use Ecto.Schema
  import Ecto.Changeset

  schema "groups" do
    field :category_id, :integer
    field :group_id, :integer
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(type, attrs) do
    type
    |> cast(attrs, [
      :category_id,
      :group_id,
      :name
    ])
    |> validate_required([:category_id, :group_id, :name])
    |> unique_constraint(:group_id)
  end
end
