defmodule Etsala.Eve.Universe.System.System do
  use Ecto.Schema
  import Ecto.Changeset

  schema "systems" do
    field :name, :string
    field :system_id, :integer

    timestamps()
  end

  @doc false
  def changeset(system, attrs) do
    system
    |> cast(attrs, [:name, :system_id])
    |> validate_required([:name, :system_id])
  end
end
