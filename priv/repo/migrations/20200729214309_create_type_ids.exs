defmodule Etsala.Repo.Migrations.CreateTypeIds do
  use Ecto.Migration

  def change do
    create table(:type_ids) do
      add :type_id, :integer
      add :name, :string

      timestamps()
    end

    create unique_index(:type_ids, [:type_id])
  end
end
