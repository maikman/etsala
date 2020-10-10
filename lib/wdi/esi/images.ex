defmodule WDI.ESI.Images do
  require Logger
  @endpoint Application.get_env(:etsala, :static_endpoints)[:ESI_IMAGES]

  def get_image(type_id, size \\ nil) do
    get_image_types(type_id)
    |> select_available_type()
    |> get_image_url(type_id, size)
  end

  defp get_image_url(nil, _type_id, _size), do: nil

  defp get_image_url(image_type, type_id, size),
    do: "#{@endpoint.url}/types/#{type_id}/#{image_type}#{get_size_string(size)}"

  defp get_size_string(nil), do: nil
  defp get_size_string(size), do: "?size=#{size}"

  defp select_available_type(["bpc", "bp"]), do: "bp"
  defp select_available_type(["render", "icon"]), do: "render"
  defp select_available_type(["icon"]), do: "icon"
  defp select_available_type(_), do: nil

  defp get_image_types(type_id) do
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
