defmodule Etsala.Repo.Migrations.ChangeOrderLocationType do
  use Ecto.Migration

  def change do
    alter table(:orders) do
      modify :location_id, :bigint
    end
  end
end
