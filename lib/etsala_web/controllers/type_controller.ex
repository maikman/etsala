defmodule EtsalaWeb.TypeController do
  use EtsalaWeb, :controller
  alias Etsala.Eve.Universe.Types
  alias WDI.ESI.Images

  def types(conn, _params) do
    types = Types.list_types() |> Enum.sort(&(&1.name <= &2.name))
    render(conn, "types.html", types: types)
  end

  def type_detail(conn, %{"id" => type_id}) do
    esi_item = WDI.ESI.Universe.Types.get_type_details(type_id)

    details =
      %{}
      |> Map.put(:name, esi_item["name"])
      |> Map.put(:description, esi_item["description"] |> format_description())
      |> Map.put(:image_url, Images.get_image(type_id, 64))

    render(conn, "type_detail.html", details: details)
  end

  def format_description(desc) do
    desc
    |> String.replace("\r\n", "<br>")
    # TODO: add faction and other logic
    |> String.replace("showinfo:30//", "/faction/")
    |> String.replace("showinfo:", "/types/")
  end
end
