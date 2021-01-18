defmodule WDI.ESI.Universe.Groups do
  require Logger

  def get_group_id_list(page \\ 1, result \\ []) do
    list = get_group_id_list_page(page)

    Logger.debug("Fetching group page #{page} with #{Enum.count(list)} groups")

    get_result(page + 1, list, result)
  end

  defp get_result(_page, %{"error" => _error}, result) do
    result
  end

  defp get_result(page, list, result) do
    get_group_id_list(page, list ++ result)
  end

  def get_group_id_list_page(page) do
    "universe/groups"
    |> WDI.ESI.Call.handle_call(%{page: page})
  end

  def get_group_details(group_id) do
    Logger.debug("Get group details for #{group_id}")

    "universe/groups/#{group_id}"
    |> WDI.ESI.Call.handle_call()
  end
end
