defmodule EtsalaWeb.CorporationController do
  use EtsalaWeb, :controller

  require Logger

  import Number.Percentage

  alias EtsalaWeb.Objects.Corporation

  # alliance page
  def index(conn, _params) do
    conn
    |> assign(:page_title, "The Alliance")
    |> assign(
      :page_description,
      "We are not one theme, but many. We are miners, we are warriors, we are builders and we are explorers.
      We protect each other and we harness the power of many to enable more out of New Eden."
    )
    |> render("index.html")
  end

  def corp_detail(conn, %{"id" => name_and_id}) do
    corp =
      name_and_id
      |> String.split("-")
      |> List.last()
      |> Corporation.get_corp(256)

    tax_rate = (corp.tax_rate * 100) |> number_to_percentage(precision: 2)

    conn
    |> assign(:corp, corp)
    |> assign(:tax_rate, tax_rate)
    |> assign(:page_title, corp.name)
    |> render("corp_details.html")
  end
end
