defmodule Tools.HttpRequestLogDetails.HttpRequestLogDetails do
  use Ecto.Schema
  import Ecto.Changeset

  schema "http_request_log_details" do
    field :request_id, :string
    field :stack_trace, :string
    field :assigns, :map
    field :cookies, :map
    field :req_headers, :map
    field :resp_headers, :map
    field :scheme, :string

    timestamps()
  end

  @doc false
  def changeset(request_log, attrs) do
    request_log
    |> cast(attrs, [
      :request_id,
      :stack_trace,
      :assigns,
      :cookies,
      :req_headers,
      :resp_headers,
      :scheme
    ])
    |> validate_required([
      :request_id
    ])
  end
end
