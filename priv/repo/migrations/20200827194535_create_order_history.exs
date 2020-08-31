defmodule Etsala.Repo.Migrations.CreateOrderHistory do
  use Ecto.Migration

  def change do
    create table(:order_history) do
      add :type_id, :integer
      add :region_id, :integer
      add :average_price, :float
      add :average_order_count, :integer
      add :average_volume, :bigint

      timestamps()
    end

    create unique_index(:order_history, [:type_id, :region_id])
  end
end
