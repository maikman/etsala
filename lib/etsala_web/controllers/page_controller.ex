defmodule EtsalaWeb.PageController do
  use EtsalaWeb, :controller
  require Logger

  alias WDI.ESI.Character

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def about(conn, _params) do
    conn
    |> assign(:profile_pic, Character.get_portrait(95_207_568, 128))
    |> render("about.html")
  end

  def changelog(conn, _params) do
    render(conn, "changelog.html")
  end

  def callback(conn, %{"code" => _code, "state" => _state}) do
    redirect(conn, to: "/")
  end

  def callback(conn, _) do
    Logger.error("invalid callback params")

    redirect(conn, to: "/")
  end

  def logout(conn, _) do
    conn
    |> clear_session()
    |> redirect(to: "/")
  end
end
