defmodule WDI.ESI.Universe.Stations do
  def get_station_id_list() do
    "universe/stations"
    |> WDI.ESI.Call.handle_call()
  end

  def get_station_details(station_id) do
    [access_token: token] = :ets.lookup(:session, :access_token)

    "universe/stations/#{station_id}"
    |> WDI.ESI.Call.handle_call(%{token: token}, true)
    |> Map.merge(%{"id" => station_id})
  end
end
