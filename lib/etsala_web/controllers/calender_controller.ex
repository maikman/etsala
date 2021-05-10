defmodule EtsalaWeb.CalendarController do
  use EtsalaWeb, :controller
  require Logger

  def index(%{assigns: %{character_id: nil}} = conn, _) do
    conn
    |> redirect(external: conn.assigns.login_url)
  end

  def index(%{assigns: %{is_member: false}} = conn, _params) do
    conn
    |> redirect(to: Routes.page_path(conn, :index))
  end

  def index(conn, _params) do
    conn
    |> assign(:page_title, "Alliance Calendar")
    |> render("calendar.html")
  end
end
