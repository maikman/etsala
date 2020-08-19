defmodule Importer.TypeIds do
  alias Etsala.Eve.Universe.Types

  def import do
    WDI.ESI.Universe.Types.get_type_id_list()
    |> Enum.each(&import_item(&1))
  end

  defp import_item(type_id) do
    Process.sleep(25)

    WDI.ESI.Universe.Types.get_type_details(type_id)
    |> store_published_item()
  end

  defp store_published_item(type) when is_map(type) do
    type
    |> Map.get("published")
    |> case do
      true -> Types.create_type_ids(type)
      _ -> nil
    end
  end

  defp store_published_item(_type), do: nil
end
