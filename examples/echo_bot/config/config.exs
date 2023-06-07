import Config

config :telegex, Telegex.Caller,
  adapter: Telegex.Caller.FinchAdapter,
  options: [recv_timeout: 5 * 1000]

import_config "#{config_env()}.exs"
