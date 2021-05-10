defmodule WDI.ESI.Character do
  def get_public_information(character_id) do
    "characters/#{character_id}"
    |> WDI.ESI.Call.handle_call(%{}, true)
  end

  def get_name(character_id) do
    character_id
    |> get_public_information()
    |> Map.get("name")
  end

  def get_portrait(character_id, size \\ 64) do
    "characters/#{character_id}/portrait"
    |> WDI.ESI.Call.handle_call(%{}, true)
    |> Map.get("px#{size}x#{size}")
  end

  def get_corporation_history(character_id) do
    "characters/#{character_id}/corporationhistory"
    |> WDI.ESI.Call.handle_call(%{}, true)
  end

  def get_calendar(character_id, access_token) do
    "characters/#{character_id}/calendar"
    |> WDI.ESI.Call.handle_call(%{token: access_token}, true)
  end
end
