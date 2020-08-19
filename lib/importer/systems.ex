defmodule Importer.Systems do
    alias Etsala.Eve.Universe.System
    alias WDI.ESI.Universe.Systems
  
    def import do
      Systems.get_system_id_list()
      |> Enum.each(&import_item(&1))
    end
  
    defp import_item(system_id) do
      Process.sleep(25)
  
      Systems.get_system_details(system_id)
      |> store_item()
    end
  
    defp store_item(type) when is_map(type) do
      type |> System.create_system()
    end
  
    defp store_item(_type), do: nil
  end
  