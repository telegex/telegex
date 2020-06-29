# Telegex

[![Hex.pm](https://img.shields.io/hexpm/v/telegex.svg)](http://hex.pm/packages/telegex)

This library is a client implementation of the official bot API, without any encapsulation. Original flavor!

The models and APIs of this library are all constructed by DSL (well-designed macros) and contain complete typespecs.

## Do not use 😝

It currently lacks testing and is not complete. Please wait for the release of version `0.1.0`!

## Installation

Add Telegex to your `mix.exs` dependencies:

```elixir
def deps do
  [{:telegex, "~> 0.1.0"}]
end
```

Run the `mix deps.get` command to install.

## Configuration

Add your bot token to `config/config.exs`, like this:

```elixir
config :telegex,
  token: "<TOKEN_HERE>",
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
