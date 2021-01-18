defmodule WDI.ESI.Universe.Categories do
  require Logger

  def get_category_id_list() do
    "universe/categories"
    |> WDI.ESI.Call.handle_call()
  end

  def get_category_details(category_id) do
    Logger.debug("Get category details for #{category_id}")

    "universe/categories/#{category_id}"
    |> WDI.ESI.Call.handle_call()
  end
end
