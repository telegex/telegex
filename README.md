# Telegex

This library is a client implementation of the official bot API, without any encapsulation. Original flavor!

## A little more cautious 😝

The models and APIs of this library are all constructed by DSL (well-designed macros) and contain complete typespecs.

It **fully supports** bot API version **5.2** and will continue to support the latest version.

However, there are still some methods that lack testing, so I must remind everyone to be careful. If you encounter a bug, please report it in time.

## Webhook support?

If you need webhook mode, please look forward to the 0.2.0 version.

## Examples & Help

There are some complete example projects in the [examples](https://github.com/Hentioe/telegex/tree/master/examples/) directory. Their code contains relatively complete comments to teach you how to get updates (receive messages) correctly and add related services to the supervision tree.

Welcome to communicate here: [@elixir_telegex](https://t.me/elixir_telegex)

## Related libraries

- [telegex_plug](https://github.com/telegex/telegex_plug) (Pipeline processing message abstraction)

## Installation

Add Telegex to your `mix.exs` dependencies:

```elixir
def deps do
  [{:telegex, "~> 0.1"}]
end
```

Run the `mix deps.get` command to install.

## Configuration

Add your bot token to `config/config.exs`, like this:

```elixir
config :telegex,
  token: "<BOT_TOKEN>",
  # This is the default and optional, will be passed as options to `HTTPoison.post/4`.
  timeout: 1000 * 15,
  # This is the default and optional, will be passed as options to `HTTPoison.post/4`.
  recv_timeout: 1000 * 10
```

## Usage

Here are some examples of common API calls.

### getMe

```elixir
iex> Telegex.get_me
{:ok,
 %Telegex.Model.User{
   can_join_groups: true,
   can_read_all_group_messages: false,
   first_name: "TelegexTest",
   id: 1192456069,
   is_bot: true,
   language_code: nil,
   last_name: nil,
   supports_inline_queries: false,
   username: "telegex_test_bot"
 }}
```

### getUpdates

```elixir
iex> Telegex.get_updates limit: 50
{:ok,
 [
   %Telegex.Model.Update{
     message: %Telegex.Model.Message{
       new_chat_photo: nil,
       author_signature: nil,
       forward_sender_name: nil,
       ...
     },
     poll: nil,
     poll_answer: nil,
     pre_checkout_query: nil,
     shipping_query: nil,
     update_id: 174059571,
     ...
   }
 ]}
```

### sendMessage

```elixir
iex> Telegex.send_message -1001486769003, "Hello Telegex!"
{:ok,
 %Telegex.Model.Message{
   venue: nil,
   chat: %Telegex.Model.Chat{
     id: -1001486769003,
     title: "Dev test",
     type: "supergroup",
     ...
   },
   date: 1593272573,
   message_id: 4146,
   text: "Hello Telegex!",
   from: %Telegex.Model.User{can_join_groups: nil, ...},
   video_note: nil,
   ...
 }}
```

For more details, please refer to the [documentation](https://hexdocs.pm/telegex/Telegex.html) and the [official page](https://core.telegram.org/bots/api) of the Telegram bot API.
