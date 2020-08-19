defmodule EtsalaWeb.Plugs.User do
    @moduledoc """
    adding user to session
    """
    require Logger
    import Plug.Conn

    alias WDI.ESI.Character
  
    @behaviour Plug
  
    def init(opts) do
      opts
    end
  
    def call(conn, _opts) do
      conn
      |> add_user_data_to_session()
      
    end

    def add_user_data_to_session(conn) do
        character_id = conn 
        |> get_session
        |> Map.get("access_token")
        |> get_character_id()

        conn
        |> put_session(:character_id, character_id)
        |> add_character_name()
        |> add_character_portrait()
        |> assign(:character_id, character_id)
    end

    defp add_character_name(conn) do
        conn 
        |> get_session
        |> Map.get("character_name")
        |> add_character_name(conn)
    end

    defp add_character_name(nil, conn) do
        name = conn 
        |> get_session
        |> Map.get("access_token")
        |> get_character_id()
        |> Character.get_name()

        conn
        |> put_session(:character_name, name)
        |> assign(:character_name, name)
    end

    defp add_character_name(name, conn) do
        conn
        |> assign(:character_name, name)
    end

    defp add_character_portrait(conn) do
        conn 
        |> get_session
        |> Map.get("character_portrait")
        |> add_character_portrait(conn)
    end

    defp add_character_portrait(nil, conn) do
        portrait = conn 
        |> get_session
        |> Map.get("access_token")
        |> get_character_id()
        |> Character.get_portrait()

        conn
        |> put_session(:character_portrait, portrait)
        |> assign(:character_portrait, portrait)
    end

    defp add_character_portrait(portrait, conn) do
        conn
        |> assign(:character_portrait, portrait)
    end

    defp get_character_id(nil), do: nil
    # TODO avoid happy path
    defp get_character_id(access_token) do
        {:ok, payload_string} = access_token 
        |> String.split(".")
        |> Enum.fetch(1)
  
        {:ok, payload} = payload_string |> Base.decode64(padding: false)
  
        {:ok, result} = payload |> Jason.decode()
  
        {:ok, character_id} = 
        result 
        |> Map.get("sub") 
        |> String.split(":")
        |> Enum.fetch(2)
  
        character_id
    end
  end
  