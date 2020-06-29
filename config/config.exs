use Mix.Config

config :telegex,
  timeout: 1000 * 45,
  recv_timeout: 1000 * 30

import_config "#{Mix.env()}.exs"
