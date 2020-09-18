use Mix.Config

# Configure your database
# RDS
# config :etsala, Etsala.Repo,
#   username: "postgres",
#   password: "Pos2754984",
#   database: "etsala-prod",
#   hostname: "167.86.78.70",
#   show_sensitive_data_on_connection_error: true,
#   pool_size: 10

# config :etsala, Etsala.Repo,
#   adapter: Ecto.Adapters.Postgres,
#   url: {:system, "DATABASE_URL"},
#   database: "etsala-prod",
#   ssl: true,
#   pool_size: 2

# gigalixir config:set DATABASE_URL="ecto://postgres:a91zMTygIMAYjBph9AIQ@172.31.46.214:5432/etsala-prod"

# For production, don't forget to configure the url host
# to something meaningful, Phoenix uses this information
# when generating URLs.
#
# Note we also include the path to a cache manifest
# containing the digested version of static files. This
# manifest is generated by the `mix phx.digest` task,
# which you should run after static files are built and
# before starting your production server.
config :etsala, EtsalaWeb.Endpoint,
  url: [host: "example.com", port: 80],
  cache_static_manifest: "priv/static/cache_manifest.json",
  https: [
    port: 443,
    otp_app: :etsala,
    keyfile: System.get_env("SSL_KEY_FILE"),
    certfile: System.get_env("SSL_CERT_FILE")
    # OPTIONAL Key for intermediate certificates
    # cacertfile: System.get_env("INTERMEDIATE_CERTFILE_PATH")
  ]

# Do not print debug messages in production
config :logger, level: :info

# ## SSL Support
#
# To get SSL working, you will need to add the `https` key
# to the previous section and set your `:url` port to 443:
#
#     config :etsala, EtsalaWeb.Endpoint,
#       ...
#       url: [host: "example.com", port: 443],
#       https: [
#         :inet6,
#         port: 443,
#         cipher_suite: :strong,
#         keyfile: System.get_env("SOME_APP_SSL_KEY_PATH"),
#         certfile: System.get_env("SOME_APP_SSL_CERT_PATH")
#       ]
#
# The `cipher_suite` is set to `:strong` to support only the
# latest and more secure SSL ciphers. This means old browsers
# and clients may not be supported. You can set it to
# `:compatible` for wider support.
#
# `:keyfile` and `:certfile` expect an absolute path to the key
# and cert in disk or a relative path inside priv, for example
# "priv/ssl/server.key". For all supported SSL configuration
# options, see https://hexdocs.pm/plug/Plug.SSL.html#configure/1
#
# We also recommend setting `force_ssl` in your endpoint, ensuring
# no data is ever sent via http, always redirecting to https:
#
#     config :etsala, EtsalaWeb.Endpoint,
#       force_ssl: [hsts: true]
#
# Check `Plug.SSL` for all available options in `force_ssl`.

# Finally import the config/prod.secret.exs which loads secrets
# and configuration from environment variables.
import_config "prod.secret.exs"
