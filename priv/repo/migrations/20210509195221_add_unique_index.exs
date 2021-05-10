defmodule Etsala.Repo.Migrations.AddUniqueIndex do
  use Ecto.Migration

  def change do
    create unique_index(:calendar, [:event_id])
  end
end
