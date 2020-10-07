defmodule EtsalaWeb.PageController do
  use EtsalaWeb, :controller
  require Logger

  def index(conn, _params) do
    render(conn, "index.html")
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
