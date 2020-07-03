# EchoBot

Example of using Telegex to build an echo bot.

## Installation

Make sure to be in the project root directory:

```bash
cd examples/echo_bot
```

Get dependencies:

```bash
mix deps.get
```

Create a configuration file `config/secret.exs` and add content:

```elixir
use Mix.Config

config :telegex,
  token: "<BOT_TOKEN>"

```

Replace `<BOT_TOKEN>` with a real token.

Start the bot:

```elixir
iex -S mix
```

## Test effect

Promote your bot to the administrator to ensure that it can accept the message. Then, send text messages frantically.
