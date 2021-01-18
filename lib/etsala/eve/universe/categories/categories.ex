defmodule Etsala.Eve.Universe.Categories.Categories do
  use Ecto.Schema
  import Ecto.Changeset

  schema "categories" do
    field :category_id, :integer
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(type, attrs) do
    type
    |> cast(attrs, [
      :category_id,
      :name
    ])
    |> validate_required([:category_id, :name])
    |> unique_constraint(:category_id)
  end
end
