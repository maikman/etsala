defmodule Importer.Groups do
  require Logger

  alias Etsala.Eve.Universe.Groups

  def import do
    group_list = WDI.ESI.Universe.Groups.get_group_id_list()
    group_list |> Enum.each(&import_group(&1))
    group_list |> Tools.Importer.output_count()
  end

  defp import_group(group_id) do
    Process.sleep(5)

    WDI.ESI.Universe.Groups.get_group_details(group_id)
    |> store_published_group()
  end

  defp store_published_group(group) when is_map(group) do
    group
    |> Map.get("published")
    |> case do
      true -> Groups.insert_or_update_group(group)
      _ -> nil
    end
  end

  defp store_published_group(_group), do: nil
end

Importer.Groups.import()
