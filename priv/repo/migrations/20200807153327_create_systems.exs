defmodule Etsala.Repo.Migrations.CreateSystems do
  use Ecto.Migration

  def change do
    create table(:systems) do
      add :name, :string
      add :system_id, :integer

      timestamps()
    end

  end
end
