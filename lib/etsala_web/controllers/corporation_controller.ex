defmodule EtsalaWeb.CorporationController do
  use EtsalaWeb, :controller
  require Logger

  def index(conn, _params) do
    conn
    |> render("index.html")
  end

  def corp_detail(conn, %{"id" => _corp_name}) do
    conn
    |> render("index.html")
  end
end
