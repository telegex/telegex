import Config

config :telegex, caller_adapter: {Finch, [receive_timeout: 5 * 1000]}

import_config "#{config_env()}.exs"
