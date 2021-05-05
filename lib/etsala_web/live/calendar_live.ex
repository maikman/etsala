defmodule EtsalaWeb.CalendarLive do
  use Phoenix.LiveView
  alias EtsalaWeb.CalendarView

  @impl true
  def render(assigns) do
    Phoenix.View.render(CalendarView, "calendar_live.html", assigns)
  end

  @impl true
  def mount(_params, _session, socket) do
    send(self(), :load_ore_data)

    {:ok,
     assign(socket,
       materials: [],
       ore_list: []
     )}
  end
end
