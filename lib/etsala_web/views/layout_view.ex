defmodule EtsalaWeb.LayoutView do
  use EtsalaWeb, :view

  def get_page_title(conn) do
    if conn.assigns[:page_title] do
      "#{conn.assigns[:page_title]} - Etsala Legion"
    else
      "Etsala Legion"
    end
  end
end
