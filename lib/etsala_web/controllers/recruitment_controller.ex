defmodule EtsalaWeb.RecruitmentController do
  use EtsalaWeb, :controller
  require Logger

  alias EtsalaWeb.Objects.Corporation

  @recruiting_corps [
    geo_tech: %{id: 98_462_263},
    domesticated_capsulers: %{id: 98_653_392},
    aedezia: %{id: 98_134_515},
    tan: %{id: 98_511_671},
    mammon: %{id: 98_652_554},
    sumpfschrompfen: %{id: 98_668_441}
  ]

  def index(conn, _params) do
    conn
    |> assign(:corps, get_recruiting_corps())
    |> assign(:page_title, "Recruitment")
    |> assign(
      :page_description,
      "Be a part of the Etsala Legion, an Eve Online alliance. Take a look at our recruiting corporations."
    )
    |> render("index.html")
  end

  defp get_recruiting_corps() do
    @recruiting_corps
    |> Enum.map(fn {k, v} -> add_corp_details(k, v) end)
    |> List.flatten()
  end

  defp add_corp_details(key, corp) do
    corp_obj = Corporation.get_corp(corp.id, 128)

    ["#{key}": corp_obj]
  end
end
