defmodule EtsalaWeb.OreController do
  use EtsalaWeb, :controller
  require Logger

  def moon_mining(conn, _params) do
    conn
    |> assign(:page_title, "Moon Mining Helper")
    |> assign(
      :page_description,
      "Find out what you currently need to mine first. All the ores are sorted by the selling prices of the reprocessed materials."
    )
    |> render("moon_mining.html")
  end
end
