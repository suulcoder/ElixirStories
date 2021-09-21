# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :hacker_news,
  ecto_repos: [HackerNews.Repo]

# Configures the endpoint
config :hacker_news, HackerNewsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "bstJn82Nepo9WKxEtB+A5/0324p9G76Q8uV8KfwEbwdT1/ABn5fHCied6z2qZ+ns",
  render_errors: [view: HackerNewsWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: HackerNews.PubSub,
  live_view: [signing_salt: "lCBElVOA"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"