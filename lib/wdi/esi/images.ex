defmodule WDI.ESI.Images do
    require Logger
    @endpoint Application.get_env(:etsala, :static_endpoints)[:ESI_IMAGES]
  
    def get_image(type_id, size \\ nil) do
        image_type = 
        get_image_types(type_id) 
        |> select_available_type()

        "#{@endpoint.url}/types/#{type_id}/#{image_type}#{get_size_string(size)}"
    end

    defp get_size_string(nil), do: ""
    defp get_size_string(size), do: "?size=#{size}"

    def select_available_type(["bpc", "bp"]), do: "bp"
    def select_available_type(["render", "icon"]), do: "render"
    def select_available_type(["icon"]), do: "icon"
    def select_available_type(_), do: ""

    def get_image_types(type_id) do    
      "#{@endpoint.url}/types/#{type_id}"
      |> HTTPoison.get!()
      |> Map.get(:body)
      |> Jason.decode()
      |> case do
        {:ok, result} -> result
        _ -> nil
      end
    end
  end
  