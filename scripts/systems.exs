defmodule Importer.Systems do
  alias Etsala.Eve.Universe.System
  alias WDI.ESI.Universe.Systems

  require Logger

  def import do
    systems = Systems.get_system_id_list()
    systems |> Enum.each(&import_item(&1))
    systems |> Tools.Importer.output_count()
  end

  defp import_item(system_id) do
    Systems.get_system_details(system_id)
    |> store_item()
  end

  defp store_item(type) when is_map(type) do
    type |> System.create_system()

    name = Map.get(type, "name")
    system_id = Map.get(type, "system_id")
    Logger.debug("create system #{name} (#{system_id})")
  end

  defp store_item(_type), do: nil
end

Importer.Systems.import()
