defmodule EtsalaWeb.CorporationController do
  use EtsalaWeb, :controller
  require Logger

  alias EtsalaWeb.Objects.Corporation

  def index(conn, _params) do
    conn
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
    |> render("corp_details.html")
  end
end
