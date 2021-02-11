defmodule EtsalaWeb.Objects.Corporation do
  alias WDI.ESI.Corporation

  defstruct [
    :alliance_id,
    :corporation_id,
    :ceo_id,
    :creator_id,
    :date_founded,
    :description,
    :home_station_id,
    :member_count,
    :name,
    :shares,
    :tax_rate,
    :ticker,
    :url,
    :war_eligible,
    :logo
  ]

  def new(esi_corp, corp_id) do
    %__MODULE__{
      alliance_id: esi_corp["alliance_id"],
      corporation_id: corp_id,
      ceo_id: esi_corp["ceo_id"],
      creator_id: esi_corp["creator_id"],
      date_founded: esi_corp["date_founded"],
      description: esi_corp["description"],
      home_station_id: esi_corp["home_station_id"],
      member_count: esi_corp["member_count"],
      name: esi_corp["name"],
      shares: esi_corp["shares"],
      tax_rate: esi_corp["tax_rate"],
      ticker: esi_corp["ticker"],
      url: esi_corp["url"],
      war_eligible: esi_corp["war_eligible"],
      logo: Corporation.get_logo(corp_id, 64)
    }
  end

  def get_corp(corp_id) do
    Corporation.get_information(corp_id)
    |> new(corp_id)
  end
end
