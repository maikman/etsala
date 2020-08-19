defmodule EtsalaWeb.Objects.Structure do
    defstruct [
        :name,
        :owner_id,
        :position,
        :solar_system_id,
        :type_id,
        :id
    ]

    def new(esi_structure) do
        %__MODULE__{
            id: esi_structure["id"],
            name: esi_structure["name"],
            owner_id: esi_structure["owner_id"],
            position: esi_structure["position"],
            solar_system_id: esi_structure["solar_system_id"],
            type_id: esi_structure["type_id"]
        }
    end
end
