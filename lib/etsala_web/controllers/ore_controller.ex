defmodule EtsalaWeb.OreController do
  use EtsalaWeb, :controller
  require Logger

  def moon_mining(conn, %{"type" => type}) do
    conn
    |> assign(:type, type)
    |> assign(:page_title, "Moon Mining - #{String.capitalize(type)} Moon Ores")
    |> assign(
      :page_description,
      "Find out what you currently need to mine first. All the ores are sorted by the selling prices of the reprocessed materials."
    )
    |> render("moon_mining.html")
  end
end
