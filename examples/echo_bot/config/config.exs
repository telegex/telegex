import Config

config :telegex, Telegex.Caller,
  adapter: Telegex.Caller.ReqAdapter,
  options: [connect_options: [timeout: 5 * 1000]]

import_config "#{config_env()}.exs"
