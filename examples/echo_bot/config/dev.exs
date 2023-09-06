import Config

config :echo_bot, work_mode: :polling

config :telegex,
  hook_adapter: Bandit,
  caller_adapter: {Finch, [receive_timeout: 15 * 1000]}

import_config "dev.secret.exs"
