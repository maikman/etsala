defmodule Etsala.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :duration, :integer
      add :is_buy_order, :boolean, default: false, null: false
      add :issued, :string
      add :location_id, :integer
      add :min_volume, :integer
      add :order_id, :bigint
      add :price, :float
      add :range, :string
      add :system_id, :integer
      add :type_id, :integer
      add :volume_remain, :integer
      add :volume_total, :integer

      timestamps()
    end

    create unique_index(:orders, [:order_id])
    create index(:orders, [:location_id, :type_id])

  end
end
