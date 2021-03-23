defmodule EtsalaWeb.Plugs.Tracking do
  @moduledoc """
  tracking plug
  """
  require Logger
  import Tools.Tracking

  @behaviour Plug

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    conn
    |> create_tracking_id()
    |> track_page_view()
  end
end
