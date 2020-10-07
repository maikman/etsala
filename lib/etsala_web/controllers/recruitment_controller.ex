defmodule EtsalaWeb.RecruitmentController do
  use EtsalaWeb, :controller
  require Logger

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
