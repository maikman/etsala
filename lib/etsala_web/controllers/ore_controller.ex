defmodule EtsalaWeb.OreController do
  use EtsalaWeb, :controller
  require Logger

  def moon_mining(conn, _params) do
    conn
    |> render("moon_mining.html")
  end
end
