defmodule Importer.Types do
  require Logger

  alias Etsala.Eve.Universe.Types

  def import do
    output = &Logger.info("imported #{&1} types")

    type_list =
      WDI.ESI.Universe.Types.get_type_id_list()
      |> Enum.each(&import_item(&1))

    type_list
    |> Enum.count()
    |> output.()
  end

  defp import_item(type_id) when type_id < 100_000 do
    Process.sleep(5)

    WDI.ESI.Universe.Types.get_type_details(type_id)
    |> store_published_item()
  end

  defp import_item(type_id) do
    Logger.debug("skip #{type_id}")

    nil
  end

  defp store_published_item(type) when is_map(type) do
    type
    |> Map.get("published")
    |> case do
      true -> Types.insert_or_update_type(type)
      _ -> nil
    end
  end

  defp store_published_item(_type), do: nil
end

Importer.Types.import()
