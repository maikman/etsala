defmodule Importer.Categories do
  require Logger

  alias Etsala.Eve.Universe.Categories

  def import do
    category_list = WDI.ESI.Universe.Categories.get_category_id_list()
    category_list |> Enum.each(&import_category(&1))
    category_list |> Tools.Importer.output_count()
  end

  defp import_category(category_id) do
    Process.sleep(5)

    WDI.ESI.Universe.Categories.get_category_details(category_id)
    |> store_published_category()
  end

  defp store_published_category(category) when is_map(category) do
    category
    |> Map.get("published")
    |> case do
      true -> Categories.insert_or_update_category(category)
      _ -> nil
    end
  end

  defp store_published_category(_category), do: nil
end

Importer.Categories.import()
