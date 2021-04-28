defmodule EtsalaWeb.PageController do
  use EtsalaWeb, :controller
  require Logger

  alias WDI.ESI.Character

  def index(conn, _params) do
    conn
    |> assign(:corps, nil)
    |> assign(:page_title, "Welcome Capsuleer!")
    |> assign(
      :page_description,
      "Etsala Legion is a very active, mid-sized Eve Online alliance of a few hundred operating in the Forge Area in both high and low sec."
    )
    |> render("index.html")
  end

  def about(conn, _params) do
    conn
    |> assign(:profile_pic, Character.get_portrait(95_207_568, 128))
    |> assign(:page_title, "About")
    |> render("about.html")
  end

  def changelog(conn, _params) do
    conn
    |> assign(:page_title, "Changelog")
    |> render("changelog.html")
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
