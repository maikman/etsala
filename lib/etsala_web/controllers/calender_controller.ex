defmodule EtsalaWeb.CalendarController do
  use EtsalaWeb, :controller
  require Logger

  def index(conn, _params) do
    conn
    |> assign(:page_title, "Alliance Calendar")
    |> render("index.html")
  end
end
