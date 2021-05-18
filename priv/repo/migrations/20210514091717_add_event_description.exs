defmodule Etsala.Repo.Migrations.AddEventDescription do
  use Ecto.Migration

  def change do
    alter table(:calendar) do
      add :description, :text
    end
  end
end
