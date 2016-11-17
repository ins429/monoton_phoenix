# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :monoton, Monoton.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "xvhe0eydeM+Ctg+y0D5jqLnyGBu2+9BD52eT5fQPUAgqt8W0w1xw1L+/X5FyFPEO",
  render_errors: [default_format: "html"],
  pubsub: [name: Monoton.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

config :ex_aws,
  access_key_id: "AKIAI3QZZHIHFWC7ZQWA",
  secret_access_key: "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",
  region: "us-west-2"

config :monoton, ecto_repos: [Monoton.Repo]

config :monoton,
  env: Mix.env
