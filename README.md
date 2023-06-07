# Telegex

The new Telegram Bot API client features a unique and perfect implementation approach!

_😋 Three years ago I created this project, and three years later I redesigned it._

## Configuration

Add bot token to the secret configuration file, like this:

```elixir
config :telegex, token: "<BOT_TOKEN>"
```

Specify the adapter for the HTTP client in the public configuration file:

```elixir
config :telegex, Telegex.Caller, adapter: Telegex.Caller.ReqAdapter
```

Pass options to the adapter, such as timeout:

```elixir
config :telegex, Telegex.Caller, adapter: Telegex.Caller.ReqAdapter,
  options: [connect_options: [timeout: 5 * 1000]]
```

You can also choose `HTTPoison` as the client. If using HTTPoison, set the corresponding adapter and timeout:

```elixir

config :telegex, Telegex.Caller, adapter: Telegex.Caller.HTTPoisonAdapter,
  options: [recv_timeout: 5 * 1000]
```

As you may have noticed, there are no standardized values for the `options` parameter here, as they directly relate to the HTTP client being used. The example above passes the raw options for the client library.

**Note: You need to manually add adapter-related libraries to the `deps`:**

- [`req`](https://hex.pm/packages/req): `ReqAdapter`
- [`httpoison`](https://hex.pm/packages/httpoison): `HTTPoisonAdapter`

Don't have a client library you use? Tell me in issues!

## Usage

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
 %Telegex.Model.Message{
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
