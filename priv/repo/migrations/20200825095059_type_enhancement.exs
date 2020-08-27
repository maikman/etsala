defmodule Etsala.Repo.Migrations.TypeEnhancement do
  use Ecto.Migration

  def change do
    rename table("type_ids"), to: table("types")
  end
end
