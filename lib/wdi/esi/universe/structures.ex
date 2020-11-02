defmodule WDI.ESI.Universe.Structures do
  def get_structure_id_list() do
    "universe/structures"
    |> WDI.ESI.Call.handle_call()
  end

  def get_structure_details(structure_id, access_token) do
    "universe/structures/#{structure_id}"
    |> WDI.ESI.Call.handle_call(%{token: access_token}, true)
    |> Map.merge(%{"id" => structure_id})
  end
end
