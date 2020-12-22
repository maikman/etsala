# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :etsala, env: Mix.env()

config :etsala,
  ecto_repos: [Etsala.Repo]

# Configures the endpoint
config :etsala, EtsalaWeb.Endpoint,
  live_view: [signing_salt: "LIdd8MEENlykY2x+krW5ee9M9wFBfgps"],
  url: [host: "localhost"],
  secret_key_base: "VG0mNP1fTfduh05Mwx2GYGCxgB/nRk0WR8Qm/a1XDM55TN7lxciFFjp2k5S4MBTy",
  render_errors: [view: EtsalaWeb.ErrorView, accepts: ~w(html json)],
  pubsub_server: Etsala.PubSub

config :etsala, :static_endpoints,
  ESI: %{
    url: "https://esi.evetech.net/latest/",
    datasource: "tranquility"
  },
  ESI_IMAGES: %{
    url: "https://images.evetech.net"
  },
  EVE_SSO: %{
    client_id: "384dc35a091242dd9034da862e43e949",
    secret_key: "r5QFA8zRQ0B7blDGLSDkTlIYH0xUDrgzOWQpT9jB",
    redirect_uri: "https://etsala.space/callback",
    # redirect_uri: "http://localhost:4000/callback",
    scopes: [
      "esi-search.search_structures.v1",
      "esi-universe.read_structures.v1",
      "esi-markets.structure_markets.v1",
      "esi-corporations.read_structures.v1",
      "esi-markets.read_character_orders.v1"
    ]
  }

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
