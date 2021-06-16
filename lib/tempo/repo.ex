defmodule Tempo.Repo do
  use Ecto.Repo,
    otp_app: :tempo,
    adapter: Ecto.Adapters.Postgres
end
