defmodule Etsala.Repo.Migrations.AddRegionToOrders do
  use Ecto.Migration

  def change do
    alter table(:orders) do
      add :region_id, :integer
    end
  end
end
