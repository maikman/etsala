defmodule EtsalaWeb.CorporationController do
  use EtsalaWeb, :controller
  require Logger

  alias EtsalaWeb.Objects.Corporation

  # alliance page
  def index(conn, _params) do
    conn
    |> assign(:page_title, "The Alliance")
    |> render("index.html")
  end

  def corp_detail(conn, %{"id" => name_and_id}) do
    corp =
      name_and_id
      |> String.split("-")
      |> List.last()
      |> Corporation.get_corp(256)

    conn
    |> assign(:corp, corp)
    |> assign(:page_title, corp.name)
    |> render("corp_details.html")
  end
end
