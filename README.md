# Telegex

[![.github/workflows/otp-26.yml](https://github.com/telegex/telegex/actions/workflows/otp-26.yml/badge.svg?branch=master)](https://github.com/telegex/telegex/actions/workflows/otp-26.yml)
[![.github/workflows/otp-25.yml](https://github.com/telegex/telegex/actions/workflows/otp-25.yml/badge.svg?branch=master)](https://github.com/telegex/telegex/actions/workflows/otp-25.yml)
[![Module Version](https://img.shields.io/hexpm/v/telegex.svg)](https://hex.pm/packages/telegex)
[![Hex Docs](https://img.shields.io/badge/hex-docs-lightgreen.svg)](https://hexdocs.pm/telegex/)
[![Total Download](https://img.shields.io/hexpm/dt/telegex.svg)](https://hex.pm/packages/telegex)
[![Last Updated](https://img.shields.io/github/last-commit/telegex/telegex.svg)](https://github.com/telegex/telegex/commits/master)

A new Telegram bot framework, which is also a perfect Bot API client library.

_All API functions, comments, types (structures and specifications) of Telegex are generated from documents. I parse the documents into structured data and publish it on [telegex/api_doc.json](https://github.com/telegex/api_doc.json)._

## Introduction

Telegex is not only a client for Bot API, but also a framework for building bots. It provides convenient support for receiving updates and implements an advanced processing model based on "chains".

>The section regarding chains currently has no documentation available. Join the group for help: [@elixir_telegex](https://t.me/elixir_telegex).

## Installation

Add Telegex to your mix.exs dependencies:

```elixir
def deps do
  [
    {:telegex, "~> 1.5.0"},
  ]
end
```

## Configuration

Add bot token to the secret configuration file, like this:

```elixir
config :telegex, token: "<BOT_TOKEN>"
```

Specify the adapter for the HTTP client in the public configuration file:

```elixir
config :telegex, caller_adapter: Finch
```

Pass options to the adapter, such as timeout:

```elixir
config :telegex, caller_adapter: {Finch, [receive_timeout: 5 * 1000]}
```

You can also choose `HTTPoison` as the client. If using HTTPoison, set the corresponding adapter and timeout:

```elixir
config :telegex, caller_adapter: {HTTPoison, [recv_timeout: 5 * 1000]}
```

>Note: There are no standardized values for the `options` parameter here, as they directly relate to the HTTP client being used. The example above passes the raw options for the client library.

**Note: You need to manually add adapter-related libraries to the `deps`:**

- `Finch`: [`finch`](https://hex.pm/packages/finch), [`multipart`](https://hex.pm/packages/multipart) (recommend)
- `HTTPoison`: [`httpoison`](https://hex.pm/packages/httpoison) (⚠️ sending local files is not supported)

_For complete configuration, please refer to the [`Telegex.Global`](https://hexdocs.pm/telegex/Telegex.Global.html) module documentation._

## API call

All Bot APIs are located under the `Telegex` module, and these APIs fully comply with the required and optional parameters in the documentation, returning specific types (struct rather than map).

### getMe

```elixir
iex> Telegex.get_me
{:ok,
 %Telegex.Type.User{
   supports_inline_queries: false,
   can_read_all_group_messages: false,
   can_join_groups: true,
   added_to_attachment_menu: nil,
   is_premium: nil,
   language_code: nil,
   username: "telegex_dev_bot",
   last_name: nil,
   first_name: "Telegex Dev",
   is_bot: true,
   id: 6258629308
 }}
```

### getUpdates

```elixir
iex> Telegex.get_updates limit: 50
{:ok,
 [
   %Telegex.Type.Update{
     chat_join_request: nil,
     chat_member: nil,
     my_chat_member: nil,
     poll_answer: nil,
     poll: nil,
     pre_checkout_query: nil,
     shipping_query: nil,
     callback_query: nil,
     chosen_inline_result: nil,
     inline_query: nil,
     edited_channel_post: nil,
     channel_post: nil,
     edited_message: nil,
     message: %Telegex.Type.Message{
       reply_markup: nil,
       web_app_data: nil,
       # omitted part...
       new_chat_photo: nil,
       new_chat_title: nil,
       text: "Hello",
       # omitted part...
     },
     update_id: 929396006
   }
 ]}
```

### sendMessage

```elixir
iex> Telegex.send_message -1001486769003, "Hello!"
{:ok,
 %Telegex.Type.Message{
   venue: nil,
   chat: %Telegex.Type.Chat{
     # omitted part...
     title: "Dev test",
     type: "supergroup",
     id: -1001486769003
   },
   date: 1686111102,
   message_id: 12777,
   text: "Hello!",
   from: %Telegex.Type.User{
     supports_inline_queries: nil,
     can_read_all_group_messages: nil,
     can_join_groups: nil,
     added_to_attachment_menu: nil,
     is_premium: nil,
     language_code: nil,
     username: "telegex_dev_bot",
     last_name: nil,
     first_name: "Telegex Dev",
     is_bot: true,
     id: 6258629308
  }, 
  # omitted part...
 }}
```

## Polling mode

Polling is a simple and effective pattern that ensures messages within the same group arrive in order. Although it may not be the fastest, it is simple and reliable.

To work in polling mode:

1. Create a new module, like `YourProject.PollingHandler`
1. `Use Telegex.Polling.GenHandler`
1. Implement `on_boot/0` and `on_update/1` callback functions
1. Add your module to the supervision tree

Polling handler example:

```elixir
defmodule YourProject.PollingHandler do
  use Telegex.Polling.GenHandler

  @impl true
  def on_boot do
    # delete any potential webhook
    {:ok, true} = Telegex.delete_webhook()
    # create configuration (can be empty, because there are default values)
    %Telegex.Polling.Config{}
    # you must return the `Telegex.Polling.Config` struct ↑
  end

  @impl true
  def on_update(update) do
    # consume the update

    :ok
  end
end

```

**Don't forget to add your module to the supervision tree.**

## Webhook mode

Add [`plug`](https://hex.pm/packages/plug) and [`remote_ip`](https://hex.pm/packages/remote_ip) to your application's deps because they are required for webhook mode.

You also need to configure adapters for hooks, which provide web services.

Based on [`Bandit`](https://hexdocs.pm/telegex/Telegex.Hook.Adapter.Bandit.html) - [`bandit`](https://hex.pm/packages/bandit)

```elixir
# add `bandit` to your deps.
config :telegex, hook_adapter: Bandit
```

Based on [`Cowboy`](https://hexdocs.pm/telegex/Telegex.Hook.Adapter.Cowboy.html) - [`plug_cowboy`](https://hex.pm/packages/plug_cowboy)

```elixir
# add `plug_cowboy` to your dpes.
config :telegex, hook_adapter: Cowboy
```

To work in webhook mode:

1. Create a new module, like `YourProject.HookHandler`
1. `Use Telegex.Hook.GenHandler`
1. Implement `on_boot/0` and `on_update/1` callback functions
1. Add your module to the supervision tree

Hook handler example:

```elixir
defmodule YourProject.HookHandler do
  use Telegex.Hook.GenHandler

  @impl true
  def on_boot do
    # read some parameters from your env config
    env_config = Application.get_env(:your_project, __MODULE__)
    # delete the webhook and set it again
    {:ok, true} = Telegex.delete_webhook()
    # set the webhook (url is required)
    {:ok, true} = Telegex.set_webhook(env_config[:webhook_url])
    # specify port for web server
    # port has a default value of 4000, but it may change with library upgrades
    %Telegex.Hook.Config{server_port: env_config[:server_port]}
    # you must return the `Telegex.Hook.Config` struct ↑
  end

  @impl true
  def on_update(update) do
  
    # consume the update
    :ok
  end
end
```

_For complete configuration, please refer to the [`Telegex.Hook.GenHandler`](https://hexdocs.pm/telegex/Telegex.Hook.GenHandler.html) module documentation._

**Don't forget to add your module to the supervision tree.**

## Compatibility mode

You can create handlers for two modes and determine which one to start based on the configuration.

```elixir
updates_handler =
  if Application.get_env(:your_project, :work_mode) == :webhook do
    YourProject.HookHandler
  else
    YourProject.PollingHandler
  end

children = [
  # omit other children
  updates_handler
]

opts = [strategy: :one_for_one, name: YourProject.Supervisor]
Supervisor.start_link(children, opts)
```

## The end

Is there anything you don't understand about building a Telegram Bot? Have bot development needs? Welcome to contact me.
