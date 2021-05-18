defmodule WDI.ESI.Calendar do
  def get_calendar(character_id, access_token) do
    "characters/#{character_id}/calendar"
    |> WDI.ESI.Call.handle_call(%{token: access_token}, true)
  end

  def get_event_details(event_id,character_id, access_token) do
    "characters/#{character_id}/calendar/#{event_id}"
    |> WDI.ESI.Call.handle_call(%{token: access_token}, true)
  end
end
