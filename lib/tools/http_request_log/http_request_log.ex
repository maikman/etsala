defmodule Tools.HttpRequestLog.HttpRequestLog do
  use Ecto.Schema
  import Ecto.Changeset

  schema "http_request_log" do
    field :status_code, :integer
    field :host, :string
    field :request_path, :string
    field :get_params, :map
    field :request_id, :string
    field :crash_reason, :string
    field :request_type, :string
    field :tracking_id, :string

    timestamps()
  end

  @doc false
  def changeset(request_log, attrs) do
    request_log
    |> cast(attrs, [
      :status_code,
      :host,
      :request_path,
      :get_params,
      :request_id,
      :crash_reason,
      :request_type,
      :tracking_id,
      :inserted_at
    ])
    |> validate_required([
      :status_code,
      :host,
      :request_path,
      :request_id
    ])
  end
end
