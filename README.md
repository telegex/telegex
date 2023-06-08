# Telegex

The new Telegram Bot API client features a unique and perfect implementation approach!

_😋 Three years ago I created this project, and three years later I redesigned it._

## Introduce

This library defines standardized APIs through code generation techniques using magical macro codes. These macros generate implementations from the data sourced from official documentation pages, which I parse into structured JSON data as macro inputs.

As a result, this library strictly adheres to the documentation standards. Due to its reliance on documentation data and code generation, adapting to new API versions is extremely easy. This ensures that it can effortlessly provide all the latest types and APIs while maintaining absolute correctness.

## Installation

Add Telegex to your mix.exs dependencies:

```elixir
def deps do
  [
    {:telegex, "~> 1.0.0-rc.3"},
  ]
end
```

>Note: `InputFile` with local file paths is not supported in the structured type of API parameters in version RC.2. Please use the file ID instead. This is temporary, and local file input will be supported upon the release of version 1.0.

## Configuration

Add bot token to the secret configuration file, like this:

```elixir
config :telegex, token: "<BOT_TOKEN>"
```

Specify the adapter for the HTTP client in the public configuration file (default is `FinchAdapter`):

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

- `FinchAdapter`: [`finch`](https://hex.pm/packages/finch), [`multipart`](https://hex.pm/packages/multipart)
- `ReqAdapter`: [`req`](https://hex.pm/packages/req) (⚠️ may be deprecated)
- `HTTPoisonAdapter`: [`httpoison`](https://hex.pm/packages/httpoison)

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

Is there anything you don't understand about building a Telegram Bot? Have bot development needs? Welcome to contact me.
