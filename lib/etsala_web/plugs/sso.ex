defmodule EtsalaWeb.Plugs.SSO do
  @moduledoc """
  sso related data
  """
  require Logger
  import Plug.Conn
  import Phoenix.Controller, only: [redirect: 2]

  @behaviour Plug
  @sso Application.get_env(:etsala, :static_endpoints)[:EVE_SSO]

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    conn
    |> refresh_access_token()
    |> init_sso_auth()
    |> prepare_eve_login()
  end

  def prepare_eve_login(conn) do
    login_url = "https://login.eveonline.com/v2/oauth/authorize/?"
    scopes = "&scope=#{@sso.scopes |> Enum.join("%20")}"
    state = get_state(conn)

    query =
      %{
        response_type: "code",
        redirect_uri: @sso.redirect_uri,
        client_id: @sso.client_id,
        state: state
      }
      |> URI.encode_query()


    conn
    |> assign(:login_url, login_url <> query <> scopes)
  end

  def refresh_access_token(conn) do
    conn
    |> get_session
    |> Map.get("expire_time")
    |> case do
      nil -> conn
      expire_time -> refresh_access_token(conn, expire_time)
    end
  end

  def refresh_access_token(conn, expire_time) do
    {:ok, now} = DateTime.now("Etc/UTC")

    DateTime.diff(expire_time, now)
    |> update_tokens(conn)
  end

  def update_tokens(time_left, conn) when time_left > 0, do: conn

  def update_tokens(_time_left, conn) do
    conn
    |> get_session
    |> Map.get("refresh_token")
    |> WDI.ESI.SSO.oauth_refresh_call()
    |> case do
      {:ok, response} -> update_session(conn, response)
      {:error, error} -> Logger.error(error)
      _ -> conn
    end
  end

  def init_sso_auth(
        conn = %Plug.Conn{
          query_params: %{"code" => code, "state" => "dev"},
          request_path: "/callback"
        }
      ) do
    conn
    |> redirect(external: "http://localhost:4000/callback?code=#{code}&state=#{conn.request_path}")
  end

  def init_sso_auth(
        conn = %Plug.Conn{
          query_params: %{"code" => code, "state" => _state},
          request_path: "/callback"
        }
      ) do
    WDI.ESI.SSO.oauth_token_call(code)
    |> case do
      {:ok, response} -> update_session(conn, response)
      {:error, error} -> Logger.error(error)
      _ -> conn
    end
  end

  def init_sso_auth(conn), do: conn

  defp update_session(conn, response) do
    {:ok, result} = response |> Map.get(:body) |> Jason.decode()
    access_token = Map.get(result, "access_token")
    expire_time = Map.get(result, "expires_in") |> calculate_expire_time()

    conn
    |> put_session(:access_token, access_token)
    |> put_session(:expire_time, expire_time)
    |> put_session(:refresh_token, Map.get(result, "refresh_token"))
    |> configure_session(renew: true)
  end

  defp calculate_expire_time(nil), do: nil

  defp calculate_expire_time(expires_in) do
    {:ok, now} = DateTime.now("Etc/UTC")

    DateTime.add(now, expires_in)
  end

  defp get_state(conn) do
    Application.get_env(:etsala, :env)
    |> case do
      :dev -> "dev"
      _ -> conn.request_path
    end
  end
end
