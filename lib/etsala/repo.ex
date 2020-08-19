defmodule Etsala.Repo do
  use Ecto.Repo,
    otp_app: :etsala,
    adapter: Ecto.Adapters.Postgres
end
