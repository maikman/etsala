defmodule Etsala.Repo.Migrations.TypeEnhancement do
  use Ecto.Migration

  def change do
    rename table("type_ids"), to: table("types")

    alter table("types") do
      add :average_price, :float
      add :average_order_count, :integer
      add :average_market_volume, :integer
    end

  end
end
