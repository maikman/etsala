defmodule Etsala.Repo.Migrations.AddGroupTable do
  use Ecto.Migration

  def change do
    create table(:groups) do
      add :category_id, :integer
      add :group_id, :integer
      add :name, :string

      timestamps()
    end
  end
end
