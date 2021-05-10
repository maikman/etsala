defmodule Etsala.Repo.Migrations.AddEventSource do
  use Ecto.Migration

  def change do
    alter table(:calendar) do
      add :event_source, :string
    end
  end
end
