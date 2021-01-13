defmodule EtsalaWeb.Plugs.User do
  @moduledoc """
  adding user to session
  """
  require Logger
  import Plug.Conn

  alias WDI.ESI.Character
  alias WDI.ESI.Alliance

  @behaviour Plug

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    conn
    |> add_character_id()
    |> add_character_name()
    |> add_character_portrait()
    |> add_is_member()
  end

  defp add_character_id(conn) do
    character_id =
      conn
      |> get_session
      |> Map.get("access_token")
      |> get_character_id()

    conn
    |> put_session(:character_id, character_id)
    |> assign(:character_id, character_id)
  end

  defp add_character_name(conn) do
    conn
    |> get_session
    |> Map.get("character_name")
    |> add_character_name(conn)
  end

  defp add_character_name(nil, conn) do
    name =
      conn
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
    portrait =
      conn
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
    {:ok, payload_string} =
      access_token
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

  defp add_is_member(%{assigns: %{character_id: nil}} = conn) do
    conn |> assign(:is_member, false)
  end

  defp add_is_member(%{assigns: %{character_id: character_id}} = conn) do
    is_member =
      character_id
      |> Character.get_corporation_history()
      |> Enum.max_by(& &1["start_date"])
      |> Map.get("corporation_id")
      |> alliance_member?()

    conn
    |> assign(:is_member, is_member)
  end

  # Etsala Citizen
  defp alliance_member?(98_602_271), do: true

  # Etsala Legion
  defp alliance_member?(corp_id) do
    Alliance.get_corporations(99_009_177)
    |> Enum.member?(corp_id)
  end
end
