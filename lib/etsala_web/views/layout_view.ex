defmodule EtsalaWeb.LayoutView do
  use EtsalaWeb, :view

  def get_page_title(conn) do
    if conn.assigns[:page_title] do
      "#{conn.assigns[:page_title]} - Etsala Legion"
    else
      "Etsala Legion"
    end
  end

  def get_page_description(%{assigns: %{page_description: desc}}) when desc != "", do: desc
  def get_page_description(_), do: nil
end
