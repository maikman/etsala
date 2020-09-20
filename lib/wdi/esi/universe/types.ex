defmodule WDI.ESI.Universe.Types do
  require Logger

  def get_type_id_list(page \\ 1, result \\ []) do
    list = get_type_id_list_page(page)

    Logger.debug("Fetching type page #{page}")

    case Enum.empty?(list) do
      false -> get_type_id_list(page + 1, list ++ result)
      true -> result
    end
  end

  def get_type_id_list_page(page) do
    "universe/types"
    |> WDI.ESI.Call.handle_call(%{page: page})
  end

  def get_type_details(type_id) do
    Logger.debug("Get type details for #{type_id}")

    "universe/types/#{type_id}"
    |> WDI.ESI.Call.handle_call()
  end
end
