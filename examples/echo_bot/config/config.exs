use Mix.Config

config :telegex,
  # This is the default and optional, will be passed as options to `HTTPoison.post/4`.
  timeout: 1000 * 15,
  # This is the default and optional, will be passed as options to `HTTPoison.post/4`.
  recv_timeout: 1000 * 10

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
