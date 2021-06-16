# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :tempo,
  ecto_repos: [Tempo.Repo]

# Configures the endpoint
config :tempo, TempoWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Ok8cAFYs0osJeRpyNoNcHXG7ZCljsmrWwIdHsT25ChJiLOgDAsr1zX/tfIfHD87X",
  render_errors: [view: TempoWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Tempo.PubSub,
  live_view: [signing_salt: "c8KAldRC"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
