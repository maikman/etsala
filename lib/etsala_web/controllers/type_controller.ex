defmodule EtsalaWeb.TypeController do
  use EtsalaWeb, :controller
  alias EtsalaWeb.Router.Helpers, as: Routes
  alias Etsala.Eve.Universe.Types
  alias WDI.ESI.Images

  def types(conn, _params) do
    types = Types.list_types() |> Enum.sort(&(&1.name <= &2.name))
    render(conn, "types.html", types: types)
  end

  def type_details(conn, %{"id" => name}) do
    type =
      name
      |> Tools.Formatter.decode_name()
      |> Types.get_type_by_name()

    details =
      %{}
      |> Map.put(:type_id, type.type_id)
      |> Map.put(:name, type.name)
      |> Map.put(:description, type.description |> format_description(conn))
      |> Map.put(:image_url, Images.get_image(type.type_id, 64))

    render(conn, "type_details.html", details: details)
  end

  def type_details_old(conn, %{"id" => id}) do
    type = id |> Types.get_type_by_type_id()

    conn
    |> put_status(301)
    |> redirect(to: Routes.type_path(conn, :type_details, Tools.Formatter.encode_name(type.name)))
  end

  def format_description(nil, _), do: ""

  def format_description(description, conn) do
    description
    |> String.replace("\r\n", "<br>")
    |> replace_type_links(conn)
    # TODO: add faction and other logic
    |> String.replace("showinfo:30//", "/faction/")
  end

  defp replace_type_links(desc, conn) do
    Regex.replace(~r/showinfo:\d+/, desc, fn x ->
      IO.inspect(x)

      type =
        x
        |> String.split(":")
        |> List.last()
        |> Types.get_type_by_type_id()

      name =
        if type do
          type
          |> Map.get(:name)
          |> Tools.Formatter.encode_name()
        else
          "#"
        end

      Routes.type_path(conn, :type_details, name)
    end)
  end
end
