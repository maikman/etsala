defmodule EtsalaWeb.RecruitmentController do
  use EtsalaWeb, :controller
  require Logger

  alias WDI.ESI.Corporation

  def index(conn, _params) do
    render(conn, "index.html", logos: get_logos())
  end

  defp get_logos() do
    size = 128

    %{
      geo_tech: Corporation.get_logo(98_462_263, size),
      domesticated_capsulers: Corporation.get_logo(98_653_392, size),
      aedezia: Corporation.get_logo(98_134_515, size),
      tan: Corporation.get_logo(98_511_671, size)
    }
  end
end
