defmodule Etsala.Eve.Calendar.Calendar do
  use Ecto.Schema
  import Ecto.Changeset

  schema "calendar" do
    field :event_date, :utc_datetime
    field :event_id, :integer
    field :event_response, :string
    field :importance, :boolean, default: false
    field :title, :string
    field :type, :string
    field :event_source, :string
    field :description, :string

    timestamps()
  end

  @doc false
  def changeset(calendar, attrs) do
    calendar
    |> cast(attrs, [
      :event_date,
      :event_id,
      :event_response,
      :importance,
      :title,
      :type,
      :event_source,
      :description
    ])
    |> validate_required([:event_date, :event_id, :title, :type, :event_source])
    |> unique_constraint(:event_id, name: :calendar_event_id_index)
  end
end
