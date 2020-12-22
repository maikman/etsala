defmodule Etsala.Repo.Migrations.AddIndexForTypeNames do
  use Ecto.Migration

  def change do
    create index "types", [:name]
  end
end
