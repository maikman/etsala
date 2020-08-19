defmodule WDI.ESI.SSO do
    @sso Application.get_env(:etsala, :static_endpoints)[:EVE_SSO]

    def oauth_token_call(code) do
        basic_auth = Base.encode64("#{@sso.client_id}:#{@sso.secret_key}") 
        headers = [
          Authorization: "Basic #{basic_auth}",
          "Content-Type": "application/x-www-form-urlencoded",
          Host: "login.eveonline.com"
        ]
    
        "https://login.eveonline.com/v2/oauth/token"
        |> HTTPoison.post("grant_type=authorization_code&code=#{code}", headers)
    end

    def oauth_refresh_call(refresh_token) do
        basic_auth = Base.encode64("#{@sso.client_id}:#{@sso.secret_key}") 
        headers = [
          Authorization: "Basic #{basic_auth}",
          "Content-Type": "application/x-www-form-urlencoded",
          Host: "login.eveonline.com"
        ]
    
        "https://login.eveonline.com/v2/oauth/token"
        |> HTTPoison.post("grant_type=refresh_token&refresh_token=#{refresh_token}", headers)
    end
end