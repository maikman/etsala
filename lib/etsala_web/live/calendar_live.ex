defmodule EtsalaWeb.CalendarLive do
  use Phoenix.LiveView
  use Timex

  alias EtsalaWeb.CalendarView
  alias WDI.ESI.Character
  alias WDI.ESI.Calendar, as: Events
  alias WDI.ESI.Corporation
  alias Etsala.Eve.Calendar

  @impl true
  def render(assigns) do
    Phoenix.View.render(CalendarView, "calendar_live.html", assigns)
  end

  @impl true
  def mount(_params, session, socket) do

    if connected?(socket), do: Process.send_after(self(), :update_eve_time, 60000)
    send(self(), {:sync_calendar, session})

    moon_timer = load_mining_events()
    eve_time = get_current_eve_time()

    {:ok,
     assign(socket,
       synced: false,
       count: nil,
       moon_timer: moon_timer,
       eve_time: eve_time
     )}
  end

  @impl true
  def handle_info({:sync_calendar, session}, socket) do
    access_token = session["access_token"]
    character_id = session["character_id"]

    count =
      character_id
      |> Events.get_calendar(access_token)
      |> filter_moon_timer()
      |> Enum.map(&add_event_description(&1, character_id, access_token))
      |> Enum.map(&write_to_db(&1, character_id))
      |> Enum.count(fn {inserted, _} -> inserted == :ok end)

    moon_timer = load_mining_events()

    {:noreply,
     assign(add_flash(count, socket),
       synced: true,
       count: count,
       moon_timer: moon_timer
     )}
  end

  @impl true
  def handle_info(:update_eve_time, socket) do
    if connected?(socket), do: Process.send_after(self(), :update_eve_time, 60000)
    eve_time = get_current_eve_time()

    {:noreply,
     assign(socket,
       eve_time: eve_time
     )}
  end

  defp add_flash(0, socket), do: socket
  defp add_flash(1, socket), do: socket |> put_flash(:info, "new event added")
  defp add_flash(count, socket), do: socket |> put_flash(:info, "#{count} new events added")

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
      status: get_status(calendar_event.event_date),
      event_date: calendar_event.event_date |> create_date_string(),
      structure: title |> List.last(),
      location: title |> List.first(),
      corp_logo: corp_logo,
      corp_name: corp_name,
      corp_link: corp_link
    }
  end

  defp create_date_string(date), do: date |> Timex.format!("%m-%d - %H:%M", :strftime)

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
      event_source: character_id,
      description: moon_timer["description"]
    }
    |> Calendar.create_calendar()
  end

  defp get_status(event_date) do
    {:ok, datetime} = DateTime.now("Etc/UTC")
    diff = Timex.diff(event_date, datetime, :hours)
    cond do
      diff > -3 && diff < 0 -> "auto-fracture"
      diff < 0 -> "popped"
      true -> ""
    end
  end

  defp get_current_eve_time() do
    {:ok, datetime} = DateTime.now("Etc/UTC")

    datetime
    |> Timex.format!("%m-%d - %H:%M", :strftime)
  end

  defp add_event_description(event, character_id, access_token) do
    desc = event["event_id"]
    |> Events.get_event_details(character_id, access_token)
    |> Map.get("text")

    event
    |> Map.put("description", desc)
  end
end
