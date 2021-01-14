defmodule Etsala.Repo.Migrations.AddTypeFields do
  use Ecto.Migration

  def change do
    alter table(:types) do
      add :capacity, :float
      add :description, :text
      add :group_id, :integer
      add :icon_id, :integer
      add :market_group_id, :integer
      add :mass, :float
      add :packaged_volume, :float
      add :portion_size, :integer
      add :radius, :float
      add :volume, :float
    end
  end
end
