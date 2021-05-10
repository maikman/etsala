defmodule EtsalaWeb.CalendarLive do
  use Phoenix.LiveView
  alias EtsalaWeb.CalendarView
  alias WDI.ESI.Character
  alias WDI.ESI.Corporation
  alias Etsala.Eve.Calendar

  @impl true
  def render(assigns) do
    Phoenix.View.render(CalendarView, "calendar_live.html", assigns)
  end

  @impl true
  def mount(_params, session, socket) do
    send(self(), {:sync_calendar, session})

    moon_timer = load_mining_events()

    {:ok,
     assign(socket,
       synced: false,
       count: nil,
       moon_timer: moon_timer
     )}
  end

  @impl true
  def handle_info({:sync_calendar, session}, socket) do
    count =
      session["character_id"]
      |> Character.get_calendar(session["access_token"])
      |> filter_moon_timer()
      |> Enum.map(&write_to_db(&1, session["character_id"]))
      |> Enum.count(fn {inserted, _} -> inserted == :ok end)

    moon_timer = load_mining_events()

    {:noreply,
     assign(socket,
       synced: true,
       count: count,
       moon_timer: moon_timer
     )}
  end

  defp load_mining_events() do
    Calendar.list_active_moon_drills() |> Enum.map(&build_event(&1))
  end

  defp build_event(calendar_event) do
    title =
      calendar_event.title
      |> String.replace_leading("Moon extraction for ", "")
      |> String.replace_trailing(" a", "")
      |> String.replace_trailing(" at", "")
      |> String.replace_trailing(" at V", "")
      |> String.split(" - ")

    corp_id =
      calendar_event.event_source
      |> Character.get_public_information()
      |> Map.get("corporation_id")

    corp_name = corp_id |> Corporation.get_information() |> Map.get("name")
    corp_logo = corp_id |> Corporation.get_logo()
    corp_link = "/corporation/#{Tools.Formatter.encode_name(corp_name)}-#{corp_id}"

    %{
      event_date: calendar_event.event_date |> create_date_string(),
      structure: title |> List.last(),
      location: title |> List.first(),
      corp_logo: corp_logo,
      corp_name: corp_name,
      corp_link: corp_link
    }
  end

  defp create_date_string(date) do
    time =
      date
      |> DateTime.to_time()
      |> Time.to_string()
      |> String.split(":")
      |> Enum.drop(-1)
      |> Enum.join(":")

    day =
      date
      |> DateTime.to_date()
      |> Date.to_string()
      |> String.split("-")
      |> Enum.drop(1)
      |> Enum.join("-")

    "#{day} - #{time}"
  end

  defp filter_moon_timer(events) when is_list(events) do
    events
    |> Enum.filter(fn x -> x["title"] |> String.starts_with?("Moon extraction for ") end)
  end

  defp filter_moon_timer(_), do: []

  defp write_to_db(moon_timer, character_id) do
    %{
      event_date: moon_timer["event_date"],
      event_id: moon_timer["event_id"],
      event_response: moon_timer["event_response"],
      importance: moon_timer["importance"] == 1,
      title: moon_timer["title"],
      type: "moon_timer",
      event_source: character_id
    }
    |> Calendar.create_calendar()
  end
end
