use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :monoton, Monoton.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  cache_static_lookup: false,
  watchers: [node: ["node_modules/webpack/bin/webpack.js", "--watch", "--colors", "--progress"]]

# Watch static and templates for browser reloading.
config :monoton, Monoton.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif)$},
      ~r{web/views/.*(ex)$},
      ~r{web/templates/.*(eex)$}
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Configure your database
config :monoton, Monoton.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "peterlee",
  password: "postgres",
  database: "monoton_dev",
  size: 10 # The amount of database connections in the pool
