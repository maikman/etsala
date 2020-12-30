defmodule Etsala.Repo.Migrations.AddHttpRequestLogDetailsTable do
  use Ecto.Migration

  def change do
    create table(:http_request_log_details) do
      add :request_id, :string
      add :stack_trace, :text
      add :assigns, :map
      add :cookies, :map
      add :req_headers, :map
      add :resp_headers, :map
      add :scheme, :string

      timestamps()
    end
  end
end
