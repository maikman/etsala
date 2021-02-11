defmodule EtsalaWeb.PageController do
  use EtsalaWeb, :controller
  require Logger

  alias WDI.ESI.Character
  # alias WDI.ESI.Alliance
  # alias EtsalaWeb.Objects.Corporation

  # @alliance_id Application.get_env(:etsala, :etsala_legion)[:alliance_id]

  def index(conn, _params) do
    # corps =
    #   Alliance.get_corporations(@alliance_id)
    #   |> Enum.map(&Corporation.get_corp(&1))
    #   |> Enum.sort(&(&1.member_count >= &2.member_count))

    conn
    # |> assign(:corps, corps)
    |> render("index.html")
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
