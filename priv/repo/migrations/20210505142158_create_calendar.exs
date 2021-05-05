defmodule Etsala.Repo.Migrations.CreateCalendar do
  use Ecto.Migration

  def change do
    create table(:calendar) do
      add :event_date, :utc_datetime
      add :event_id, :integer
      add :event_response, :string
      add :importance, :boolean, default: false, null: false
      add :title, :string
      add :type, :string

      timestamps()
    end

  end
end
