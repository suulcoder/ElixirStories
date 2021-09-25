# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :hacker_news,
  ecto_repos: [HackerNews.Repo]

# HTTP JSON configuration
config :hacker_news, HackerNewsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Axf15qR9r1Xe7e/dOYoKQKxzaUN+aRAopGeisddCf9BpDK+j2PdEhVuKqZnug/jr",
  render_errors: [view: HackerNewsWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: HackerNews.PubSub,
  live_view: [signing_salt: "QawNUtLx"]

config :hacker_news, HackerNews.StoryWebSocket,
  port: 3500,
  path: "/api",
  max_connections: 10000, # don't accept connections if server already has this number of connections
  max_connection_age: :infinity, # force to disconnect a connection if the duration passed. if :infinity is set, do nothing.
  idle_timeout: 120_000, # disconnect if no event comes on a connection during this duration
  reuse_port: false, # TCP SO_REUSEPORT flag
  show_debug_logs: false,
  transmission_limit: [
    capacity: 50,  # if 50 frames are sent on a connection
    duration: 2000 # in 2 seconds, disconnect it.
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
