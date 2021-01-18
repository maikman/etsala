defmodule Etsala.Repo.Migrations.AddCategoriesTable do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :category_id, :integer
      add :name, :string

      timestamps()
    end
  end
end
