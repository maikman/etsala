defmodule Etsala.Repo.Migrations.AddHttpRequestLogTable do
  use Ecto.Migration

  def change do
    create table(:http_request_log) do
      add :status_code, :integer, null: false
      add :host, :string
      add :request_path, :text
      add :get_params, :map
      add :request_id, :string
      add :crash_reason, :string
      add :request_type, :string
      add :tracking_id, :string

      timestamps()
    end
  end
end
