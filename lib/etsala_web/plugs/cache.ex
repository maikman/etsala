defmodule EtsalaWeb.Plugs.Cache do
    @moduledoc """
    ets caching plug
    """
    require Logger
    import Plug.Conn
  
    @behaviour Plug
  
    def init(opts) do
      opts
    end
  
    def call(conn, _opts) do
      create_tables()

      conn
      |> init_session_table()
    end

    def create_tables() do
      :ets.new(:session, [:named_table])
      :ets.new(:esi_calls, [:named_table])
    end

    def init_session_table(conn) do
      session = conn |> get_session()
      character_id = session["character_id"]
      access_token = session["access_token"]

      :ets.insert(:session, {:character_id, character_id})
      :ets.insert(:session, {:access_token, access_token})

      conn
    end
  end
  