defmodule Telegex do
  @moduledoc "All methods in the Bot API."

  use Telegex.MethodDefiner

  defmethod(
    "getUpdates",
    "Use this method to receive incoming updates using long polling (wiki). Returns an Array of Update objects.",
    [
      %{
        description:
          "Identifier of the first update to be returned. Must be greater by one than the highest among the identifiers of previously received updates. By default, updates starting with the earliest unconfirmed update are returned. An update is considered confirmed as soon as getUpdates is called with an offset higher than its update_id. The negative offset can be specified to retrieve updates starting from -offset update from the end of the updates queue. All previous updates will be forgotten.",
        name: :offset,
        required: false,
        type: :integer
      },
      %{
        description:
          "Limits the number of updates to be retrieved. Values between 1-100 are accepted. Defaults to 100.",
        name: :limit,
        required: false,
        type: :integer
      },
      %{
        description:
          "Timeout in seconds for long polling. Defaults to 0, i.e. usual short polling. Should be positive, short polling should be used for testing purposes only.",
        name: :timeout,
        required: false,
        type: :integer
      },
      %{
        description:
          "A JSON-serialized list of the update types you want your bot to receive. For example, specify [\"message\", \"edited_channel_post\", \"callback_query\"] to only receive updates of these types. See Update for a complete list of available update types. Specify an empty list to receive all update types except chat_member, message_reaction, and message_reaction_count (default). If not specified, the previous setting will be used.\n\nPlease note that this parameter doesn't affect updates created before the call to the getUpdates, so unwanted updates may be received for a short period of time.",
        name: :allowed_updates,
        required: false,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: :string}
      }
    ],
    %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.Update}
  )

  defmethod(
    "setWebhook",
    "Use this method to specify a URL and receive incoming updates via an outgoing webhook. Whenever there is an update for the bot, we will send an HTTPS POST request to the specified URL, containing a JSON-serialized Update. In case of an unsuccessful request, we will give up after a reasonable amount of attempts. Returns True on success.",
    [
      %{
        description:
          "HTTPS URL to send updates to. Use an empty string to remove webhook integration",
        name: :url,
        required: true,
        type: :string
      },
      %{
        description:
          "Upload your public key certificate so that the root certificate in use can be checked. See our self-signed guide for details.",
        name: :certificate,
        required: false,
        type: Telegex.Type.InputFile
      },
      %{
        description:
          "The fixed IP address which will be used to send webhook requests instead of the IP address resolved through DNS",
        name: :ip_address,
        required: false,
        type: :string
      },
      %{
        description:
          "The maximum allowed number of simultaneous HTTPS connections to the webhook for update delivery, 1-100. Defaults to 40. Use lower values to limit the load on your bot's server, and higher values to increase your bot's throughput.",
        name: :max_connections,
        required: false,
        type: :integer
      },
      %{
        description:
          "A JSON-serialized list of the update types you want your bot to receive. For example, specify [\"message\", \"edited_channel_post\", \"callback_query\"] to only receive updates of these types. See Update for a complete list of available update types. Specify an empty list to receive all update types except chat_member, message_reaction, and message_reaction_count (default). If not specified, the previous setting will be used.\nPlease note that this parameter doesn't affect updates created before the call to the setWebhook, so unwanted updates may be received for a short period of time.",
        name: :allowed_updates,
        required: false,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: :string}
      },
      %{
        description: "Pass True to drop all pending updates",
        name: :drop_pending_updates,
        required: false,
        type: :boolean
      },
      %{
        description:
          "A secret token to be sent in a header “X-Telegram-Bot-Api-Secret-Token” in every webhook request, 1-256 characters. Only characters A-Z, a-z, 0-9, _ and - are allowed. The header is useful to ensure that the request comes from a webhook set by you.",
        name: :secret_token,
        required: false,
        type: :string
      }
    ],
    :boolean
  )

  defmethod(
    "deleteWebhook",
    "Use this method to remove webhook integration if you decide to switch back to getUpdates. Returns True on success.",
    [
      %{
        description: "Pass True to drop all pending updates",
        name: :drop_pending_updates,
        required: false,
        type: :boolean
      }
    ],
    :boolean
  )

  defmethod(
    "getWebhookInfo",
    "Use this method to get current webhook status. Requires no parameters. On success, returns a WebhookInfo object. If the bot is using getUpdates, will return an object with the url field empty.",
    [],
    Telegex.Type.WebhookInfo
  )

  defmethod(
    "getMe",
    "A simple method for testing your bot's authentication token. Requires no parameters. Returns basic information about the bot in form of a User object.",
    [],
    Telegex.Type.User
  )

  defmethod(
    "logOut",
    "Use this method to log out from the cloud Bot API server before launching the bot locally. You must log out the bot before running it locally, otherwise there is no guarantee that the bot will receive updates. After a successful call, you can immediately log in on a local server, but will not be able to log in back to the cloud Bot API server for 10 minutes. Returns True on success. Requires no parameters.",
    [],
    :boolean
  )

  defmethod(
    "close",
    "Use this method to close the bot instance before moving it from one local server to another. You need to delete the webhook before calling this method to ensure that the bot isn't launched again after server restart. The method will return error 429 in the first 10 minutes after the bot is launched. Returns True on success. Requires no parameters.",
    [],
    :boolean
  )

  defmethod(
    "sendMessage",
    "Use this method to send text messages. On success, the sent Message is returned.",
    [
      %{
        description:
          "Unique identifier of the business connection on behalf of which the message will be sent",
        name: :business_connection_id,
        required: false,
        type: :string
      },
      %{
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        name: :chat_id,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      },
      %{
        description:
          "Unique identifier for the target message thread (topic) of the forum; for forum supergroups only",
        name: :message_thread_id,
        required: false,
        type: :integer
      },
      %{
        description: "Text of the message to be sent, 1-4096 characters after entities parsing",
        name: :text,
        required: true,
        type: :string
      },
      %{
        description:
          "Mode for parsing entities in the message text. See formatting options for more details.",
        name: :parse_mode,
        required: false,
        type: :string
      },
      %{
        description:
          "A JSON-serialized list of special entities that appear in message text, which can be specified instead of parse_mode",
        name: :entities,
        required: false,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity}
      },
      %{
        description: "Link preview generation options for the message",
        name: :link_preview_options,
        required: false,
        type: Telegex.Type.LinkPreviewOptions
      },
      %{
        description:
          "Sends the message silently. Users will receive a notification with no sound.",
        name: :disable_notification,
        required: false,
        type: :boolean
      },
      %{
        description: "Protects the contents of the sent message from forwarding and saving",
        name: :protect_content,
        required: false,
        type: :boolean
      },
      %{
        description:
          "Pass True to allow up to 1000 messages per second, ignoring broadcasting limits for a fee of 0.1 Telegram Stars per message. The relevant Stars will be withdrawn from the bot's balance",
        name: :allow_paid_broadcast,
        required: false,
        type: :boolean
      },
      %{
        description:
          "Unique identifier of the message effect to be added to the message; for private chats only",
        name: :message_effect_id,
        required: false,
        type: :string
      },
      %{
        description: "Description of the message to reply to",
        name: :reply_parameters,
        required: false,
        type: Telegex.Type.ReplyParameters
      },
      %{
        description:
          "Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove a reply keyboard or to force a reply from the user",
        name: :reply_markup,
        required: false,
        type: %{
          __struct__: Telegex.TypeDefiner.UnionType,
          types: [
            Telegex.Type.InlineKeyboardMarkup,
            Telegex.Type.ReplyKeyboardMarkup,
            Telegex.Type.ReplyKeyboardRemove,
            Telegex.Type.ForceReply
          ]
        }
      }
    ],
    Telegex.Type.Message
  )

  defmethod(
    "forwardMessage",
    "Use this method to forward messages of any kind. Service messages and messages with protected content can't be forwarded. On success, the sent Message is returned.",
    [
      %{
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        name: :chat_id,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      },
      %{
        description:
          "Unique identifier for the target message thread (topic) of the forum; for forum supergroups only",
        name: :message_thread_id,
        required: false,
        type: :integer
      },
      %{
        description:
          "Unique identifier for the chat where the original message was sent (or channel username in the format @channelusername)",
        name: :from_chat_id,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      },
      %{
        description:
          "Sends the message silently. Users will receive a notification with no sound.",
        name: :disable_notification,
        required: false,
        type: :boolean
      },
      %{
        description: "Protects the contents of the forwarded message from forwarding and saving",
        name: :protect_content,
        required: false,
        type: :boolean
      },
      %{
        description: "Message identifier in the chat specified in from_chat_id",
        name: :message_id,
        required: true,
        type: :integer
      }
    ],
    Telegex.Type.Message
  )

  defmethod(
    "forwardMessages",
    "Use this method to forward multiple messages of any kind. If some of the specified messages can't be found or forwarded, they are skipped. Service messages and messages with protected content can't be forwarded. Album grouping is kept for forwarded messages. On success, an array of MessageId of the sent messages is returned.",
    [
      %{
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        name: :chat_id,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      },
      %{
        description:
          "Unique identifier for the target message thread (topic) of the forum; for forum supergroups only",
        name: :message_thread_id,
        required: false,
        type: :integer
      },
      %{
        description:
          "Unique identifier for the chat where the original messages were sent (or channel username in the format @channelusername)",
        name: :from_chat_id,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      },
      %{
        description:
          "A JSON-serialized list of 1-100 identifiers of messages in the chat from_chat_id to forward. The identifiers must be specified in a strictly increasing order.",
        name: :message_ids,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: :integer}
      },
      %{
        description:
          "Sends the messages silently. Users will receive a notification with no sound.",
        name: :disable_notification,
        required: false,
        type: :boolean
      },
      %{
        description: "Protects the contents of the forwarded messages from forwarding and saving",
        name: :protect_content,
        required: false,
        type: :boolean
      }
    ],
    %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageId}
  )

  defmethod(
    "copyMessage",
    "Use this method to copy messages of any kind. Service messages, paid media messages, giveaway messages, giveaway winners messages, and invoice messages can't be copied. A quiz poll can be copied only if the value of the field correct_option_id is known to the bot. The method is analogous to the method forwardMessage, but the copied message doesn't have a link to the original message. Returns the MessageId of the sent message on success.",
    [
      %{
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        name: :chat_id,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      },
      %{
        description:
          "Unique identifier for the target message thread (topic) of the forum; for forum supergroups only",
        name: :message_thread_id,
        required: false,
        type: :integer
      },
      %{
        description:
          "Unique identifier for the chat where the original message was sent (or channel username in the format @channelusername)",
        name: :from_chat_id,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      },
      %{
        description: "Message identifier in the chat specified in from_chat_id",
        name: :message_id,
        required: true,
        type: :integer
      },
      %{
        description:
          "New caption for media, 0-1024 characters after entities parsing. If not specified, the original caption is kept",
        name: :caption,
        required: false,
        type: :string
      },
      %{
        description:
          "Mode for parsing entities in the new caption. See formatting options for more details.",
        name: :parse_mode,
        required: false,
        type: :string
      },
      %{
        description:
          "A JSON-serialized list of special entities that appear in the new caption, which can be specified instead of parse_mode",
        name: :caption_entities,
        required: false,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity}
      },
      %{
        description:
          "Pass True, if the caption must be shown above the message media. Ignored if a new caption isn't specified.",
        name: :show_caption_above_media,
        required: false,
        type: :boolean
      },
      %{
        description:
          "Sends the message silently. Users will receive a notification with no sound.",
        name: :disable_notification,
        required: false,
        type: :boolean
      },
      %{
        description: "Protects the contents of the sent message from forwarding and saving",
        name: :protect_content,
        required: false,
        type: :boolean
      },
      %{
        description:
          "Pass True to allow up to 1000 messages per second, ignoring broadcasting limits for a fee of 0.1 Telegram Stars per message. The relevant Stars will be withdrawn from the bot's balance",
        name: :allow_paid_broadcast,
        required: false,
        type: :boolean
      },
      %{
        description: "Description of the message to reply to",
        name: :reply_parameters,
        required: false,
        type: Telegex.Type.ReplyParameters
      },
      %{
        description:
          "Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove a reply keyboard or to force a reply from the user",
        name: :reply_markup,
        required: false,
        type: %{
          __struct__: Telegex.TypeDefiner.UnionType,
          types: [
            Telegex.Type.InlineKeyboardMarkup,
            Telegex.Type.ReplyKeyboardMarkup,
            Telegex.Type.ReplyKeyboardRemove,
            Telegex.Type.ForceReply
          ]
        }
      }
    ],
    Telegex.Type.MessageId
  )

  defmethod(
    "copyMessages",
    "Use this method to copy messages of any kind. If some of the specified messages can't be found or copied, they are skipped. Service messages, paid media messages, giveaway messages, giveaway winners messages, and invoice messages can't be copied. A quiz poll can be copied only if the value of the field correct_option_id is known to the bot. The method is analogous to the method forwardMessages, but the copied messages don't have a link to the original message. Album grouping is kept for copied messages. On success, an array of MessageId of the sent messages is returned.",
    [
      %{
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        name: :chat_id,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      },
      %{
        description:
          "Unique identifier for the target message thread (topic) of the forum; for forum supergroups only",
        name: :message_thread_id,
        required: false,
        type: :integer
      },
      %{
        description:
          "Unique identifier for the chat where the original messages were sent (or channel username in the format @channelusername)",
        name: :from_chat_id,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      },
      %{
        description:
          "A JSON-serialized list of 1-100 identifiers of messages in the chat from_chat_id to copy. The identifiers must be specified in a strictly increasing order.",
        name: :message_ids,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: :integer}
      },
      %{
        description:
          "Sends the messages silently. Users will receive a notification with no sound.",
        name: :disable_notification,
        required: false,
        type: :boolean
      },
      %{
        description: "Protects the contents of the sent messages from forwarding and saving",
        name: :protect_content,
        required: false,
        type: :boolean
      },
      %{
        description: "Pass True to copy the messages without their captions",
        name: :remove_caption,
        required: false,
        type: :boolean
      }
    ],
    %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageId}
  )

  defmethod(
    "sendPhoto",
    "Use this method to send photos. On success, the sent Message is returned.",
    [
      %{
        description:
          "Unique identifier of the business connection on behalf of which the message will be sent",
        name: :business_connection_id,
        required: false,
        type: :string
      },
      %{
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        name: :chat_id,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      },
      %{
        description:
          "Unique identifier for the target message thread (topic) of the forum; for forum supergroups only",
        name: :message_thread_id,
        required: false,
        type: :integer
      },
      %{
        description:
          "Photo to send. Pass a file_id as String to send a photo that exists on the Telegram servers (recommended), pass an HTTP URL as a String for Telegram to get a photo from the Internet, or upload a new photo using multipart/form-data. The photo must be at most 10 MB in size. The photo's width and height must not exceed 10000 in total. Width and height ratio must be at most 20. More information on Sending Files »",
        name: :photo,
        required: true,
        type: %{
          __struct__: Telegex.TypeDefiner.UnionType,
          types: [Telegex.Type.InputFile, :string]
        }
      },
      %{
        description:
          "Photo caption (may also be used when resending photos by file_id), 0-1024 characters after entities parsing",
        name: :caption,
        required: false,
        type: :string
      },
      %{
        description:
          "Mode for parsing entities in the photo caption. See formatting options for more details.",
        name: :parse_mode,
        required: false,
        type: :string
      },
      %{
        description:
          "A JSON-serialized list of special entities that appear in the caption, which can be specified instead of parse_mode",
        name: :caption_entities,
        required: false,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity}
      },
      %{
        description: "Pass True, if the caption must be shown above the message media",
        name: :show_caption_above_media,
        required: false,
        type: :boolean
      },
      %{
        description: "Pass True if the photo needs to be covered with a spoiler animation",
        name: :has_spoiler,
        required: false,
        type: :boolean
      },
      %{
        description:
          "Sends the message silently. Users will receive a notification with no sound.",
        name: :disable_notification,
        required: false,
        type: :boolean
      },
      %{
        description: "Protects the contents of the sent message from forwarding and saving",
        name: :protect_content,
        required: false,
        type: :boolean
      },
      %{
        description:
          "Pass True to allow up to 1000 messages per second, ignoring broadcasting limits for a fee of 0.1 Telegram Stars per message. The relevant Stars will be withdrawn from the bot's balance",
        name: :allow_paid_broadcast,
        required: false,
        type: :boolean
      },
      %{
        description:
          "Unique identifier of the message effect to be added to the message; for private chats only",
        name: :message_effect_id,
        required: false,
        type: :string
      },
      %{
        description: "Description of the message to reply to",
        name: :reply_parameters,
        required: false,
        type: Telegex.Type.ReplyParameters
      },
      %{
        description:
          "Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove a reply keyboard or to force a reply from the user",
        name: :reply_markup,
        required: false,
        type: %{
          __struct__: Telegex.TypeDefiner.UnionType,
          types: [
            Telegex.Type.InlineKeyboardMarkup,
            Telegex.Type.ReplyKeyboardMarkup,
            Telegex.Type.ReplyKeyboardRemove,
            Telegex.Type.ForceReply
          ]
        }
      }
    ],
    Telegex.Type.Message
  )

  defmethod(
    "sendAudio",
    "Use this method to send audio files, if you want Telegram clients to display them in the music player. Your audio must be in the .MP3 or .M4A format. On success, the sent Message is returned. Bots can currently send audio files of up to 50 MB in size, this limit may be changed in the future.",
    [
      %{
        description:
          "Unique identifier of the business connection on behalf of which the message will be sent",
        name: :business_connection_id,
        required: false,
        type: :string
      },
      %{
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        name: :chat_id,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      },
      %{
        description:
          "Unique identifier for the target message thread (topic) of the forum; for forum supergroups only",
        name: :message_thread_id,
        required: false,
        type: :integer
      },
      %{
        description:
          "Audio file to send. Pass a file_id as String to send an audio file that exists on the Telegram servers (recommended), pass an HTTP URL as a String for Telegram to get an audio file from the Internet, or upload a new one using multipart/form-data. More information on Sending Files »",
        name: :audio,
        required: true,
        type: %{
          __struct__: Telegex.TypeDefiner.UnionType,
          types: [Telegex.Type.InputFile, :string]
        }
      },
      %{
        description: "Audio caption, 0-1024 characters after entities parsing",
        name: :caption,
        required: false,
        type: :string
      },
      %{
        description:
          "Mode for parsing entities in the audio caption. See formatting options for more details.",
        name: :parse_mode,
        required: false,
        type: :string
      },
      %{
        description:
          "A JSON-serialized list of special entities that appear in the caption, which can be specified instead of parse_mode",
        name: :caption_entities,
        required: false,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity}
      },
      %{
        description: "Duration of the audio in seconds",
        name: :duration,
        required: false,
        type: :integer
      },
      %{description: "Performer", name: :performer, required: false, type: :string},
      %{description: "Track name", name: :title, required: false, type: :string},
      %{
        description:
          "Thumbnail of the file sent; can be ignored if thumbnail generation for the file is supported server-side. The thumbnail should be in JPEG format and less than 200 kB in size. A thumbnail's width and height should not exceed 320. Ignored if the file is not uploaded using multipart/form-data. Thumbnails can't be reused and can be only uploaded as a new file, so you can pass “attach://<file_attach_name>” if the thumbnail was uploaded using multipart/form-data under <file_attach_name>. More information on Sending Files »",
        name: :thumbnail,
        required: false,
        type: %{
          __struct__: Telegex.TypeDefiner.UnionType,
          types: [Telegex.Type.InputFile, :string]
        }
      },
      %{
        description:
          "Sends the message silently. Users will receive a notification with no sound.",
        name: :disable_notification,
        required: false,
        type: :boolean
      },
      %{
        description: "Protects the contents of the sent message from forwarding and saving",
        name: :protect_content,
        required: false,
        type: :boolean
      },
      %{
        description:
          "Pass True to allow up to 1000 messages per second, ignoring broadcasting limits for a fee of 0.1 Telegram Stars per message. The relevant Stars will be withdrawn from the bot's balance",
        name: :allow_paid_broadcast,
        required: false,
        type: :boolean
      },
      %{
        description:
          "Unique identifier of the message effect to be added to the message; for private chats only",
        name: :message_effect_id,
        required: false,
        type: :string
      },
      %{
        description: "Description of the message to reply to",
        name: :reply_parameters,
        required: false,
        type: Telegex.Type.ReplyParameters
      },
      %{
        description:
          "Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove a reply keyboard or to force a reply from the user",
        name: :reply_markup,
        required: false,
        type: %{
          __struct__: Telegex.TypeDefiner.UnionType,
          types: [
            Telegex.Type.InlineKeyboardMarkup,
            Telegex.Type.ReplyKeyboardMarkup,
            Telegex.Type.ReplyKeyboardRemove,
            Telegex.Type.ForceReply
          ]
        }
      }
    ],
    Telegex.Type.Message
  )

  defmethod(
    "sendDocument",
    "Use this method to send general files. On success, the sent Message is returned. Bots can currently send files of any type of up to 50 MB in size, this limit may be changed in the future.",
    [
      %{
        description:
          "Unique identifier of the business connection on behalf of which the message will be sent",
        name: :business_connection_id,
        required: false,
        type: :string
      },
      %{
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        name: :chat_id,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      },
      %{
        description:
          "Unique identifier for the target message thread (topic) of the forum; for forum supergroups only",
        name: :message_thread_id,
        required: false,
        type: :integer
      },
      %{
        description:
          "File to send. Pass a file_id as String to send a file that exists on the Telegram servers (recommended), pass an HTTP URL as a String for Telegram to get a file from the Internet, or upload a new one using multipart/form-data. More information on Sending Files »",
        name: :document,
        required: true,
        type: %{
          __struct__: Telegex.TypeDefiner.UnionType,
          types: [Telegex.Type.InputFile, :string]
        }
      },
      %{
        description:
          "Thumbnail of the file sent; can be ignored if thumbnail generation for the file is supported server-side. The thumbnail should be in JPEG format and less than 200 kB in size. A thumbnail's width and height should not exceed 320. Ignored if the file is not uploaded using multipart/form-data. Thumbnails can't be reused and can be only uploaded as a new file, so you can pass “attach://<file_attach_name>” if the thumbnail was uploaded using multipart/form-data under <file_attach_name>. More information on Sending Files »",
        name: :thumbnail,
        required: false,
        type: %{
          __struct__: Telegex.TypeDefiner.UnionType,
          types: [Telegex.Type.InputFile, :string]
        }
      },
      %{
        description:
          "Document caption (may also be used when resending documents by file_id), 0-1024 characters after entities parsing",
        name: :caption,
        required: false,
        type: :string
      },
      %{
        description:
          "Mode for parsing entities in the document caption. See formatting options for more details.",
        name: :parse_mode,
        required: false,
        type: :string
      },
      %{
        description:
          "A JSON-serialized list of special entities that appear in the caption, which can be specified instead of parse_mode",
        name: :caption_entities,
        required: false,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity}
      },
      %{
        description:
          "Disables automatic server-side content type detection for files uploaded using multipart/form-data",
        name: :disable_content_type_detection,
        required: false,
        type: :boolean
      },
      %{
        description:
          "Sends the message silently. Users will receive a notification with no sound.",
        name: :disable_notification,
        required: false,
        type: :boolean
      },
      %{
        description: "Protects the contents of the sent message from forwarding and saving",
        name: :protect_content,
        required: false,
        type: :boolean
      },
      %{
        description:
          "Pass True to allow up to 1000 messages per second, ignoring broadcasting limits for a fee of 0.1 Telegram Stars per message. The relevant Stars will be withdrawn from the bot's balance",
        name: :allow_paid_broadcast,
        required: false,
        type: :boolean
      },
      %{
        description:
          "Unique identifier of the message effect to be added to the message; for private chats only",
        name: :message_effect_id,
        required: false,
        type: :string
      },
      %{
        description: "Description of the message to reply to",
        name: :reply_parameters,
        required: false,
        type: Telegex.Type.ReplyParameters
      },
      %{
        description:
          "Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove a reply keyboard or to force a reply from the user",
        name: :reply_markup,
        required: false,
        type: %{
          __struct__: Telegex.TypeDefiner.UnionType,
          types: [
            Telegex.Type.InlineKeyboardMarkup,
            Telegex.Type.ReplyKeyboardMarkup,
            Telegex.Type.ReplyKeyboardRemove,
            Telegex.Type.ForceReply
          ]
        }
      }
    ],
    Telegex.Type.Message
  )

  defmethod(
    "sendVideo",
    "Use this method to send video files, Telegram clients support MPEG4 videos (other formats may be sent as Document). On success, the sent Message is returned. Bots can currently send video files of up to 50 MB in size, this limit may be changed in the future.",
    [
      %{
        description:
          "Unique identifier of the business connection on behalf of which the message will be sent",
        name: :business_connection_id,
        required: false,
        type: :string
      },
      %{
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        name: :chat_id,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      },
      %{
        description:
          "Unique identifier for the target message thread (topic) of the forum; for forum supergroups only",
        name: :message_thread_id,
        required: false,
        type: :integer
      },
      %{
        description:
          "Video to send. Pass a file_id as String to send a video that exists on the Telegram servers (recommended), pass an HTTP URL as a String for Telegram to get a video from the Internet, or upload a new video using multipart/form-data. More information on Sending Files »",
        name: :video,
        required: true,
        type: %{
          __struct__: Telegex.TypeDefiner.UnionType,
          types: [Telegex.Type.InputFile, :string]
        }
      },
      %{
        description: "Duration of sent video in seconds",
        name: :duration,
        required: false,
        type: :integer
      },
      %{description: "Video width", name: :width, required: false, type: :integer},
      %{description: "Video height", name: :height, required: false, type: :integer},
      %{
        description:
          "Thumbnail of the file sent; can be ignored if thumbnail generation for the file is supported server-side. The thumbnail should be in JPEG format and less than 200 kB in size. A thumbnail's width and height should not exceed 320. Ignored if the file is not uploaded using multipart/form-data. Thumbnails can't be reused and can be only uploaded as a new file, so you can pass “attach://<file_attach_name>” if the thumbnail was uploaded using multipart/form-data under <file_attach_name>. More information on Sending Files »",
        name: :thumbnail,
        required: false,
        type: %{
          __struct__: Telegex.TypeDefiner.UnionType,
          types: [Telegex.Type.InputFile, :string]
        }
      },
      %{
        description:
          "Video caption (may also be used when resending videos by file_id), 0-1024 characters after entities parsing",
        name: :caption,
        required: false,
        type: :string
      },
      %{
        description:
          "Mode for parsing entities in the video caption. See formatting options for more details.",
        name: :parse_mode,
        required: false,
        type: :string
      },
      %{
        description:
          "A JSON-serialized list of special entities that appear in the caption, which can be specified instead of parse_mode",
        name: :caption_entities,
        required: false,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity}
      },
      %{
        description: "Pass True, if the caption must be shown above the message media",
        name: :show_caption_above_media,
        required: false,
        type: :boolean
      },
      %{
        description: "Pass True if the video needs to be covered with a spoiler animation",
        name: :has_spoiler,
        required: false,
        type: :boolean
      },
      %{
        description: "Pass True if the uploaded video is suitable for streaming",
        name: :supports_streaming,
        required: false,
        type: :boolean
      },
      %{
        description:
          "Sends the message silently. Users will receive a notification with no sound.",
        name: :disable_notification,
        required: false,
        type: :boolean
      },
      %{
        description: "Protects the contents of the sent message from forwarding and saving",
        name: :protect_content,
        required: false,
        type: :boolean
      },
      %{
        description:
          "Pass True to allow up to 1000 messages per second, ignoring broadcasting limits for a fee of 0.1 Telegram Stars per message. The relevant Stars will be withdrawn from the bot's balance",
        name: :allow_paid_broadcast,
        required: false,
        type: :boolean
      },
      %{
        description:
          "Unique identifier of the message effect to be added to the message; for private chats only",
        name: :message_effect_id,
        required: false,
        type: :string
      },
      %{
        description: "Description of the message to reply to",
        name: :reply_parameters,
        required: false,
        type: Telegex.Type.ReplyParameters
      },
      %{
        description:
          "Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove a reply keyboard or to force a reply from the user",
        name: :reply_markup,
        required: false,
        type: %{
          __struct__: Telegex.TypeDefiner.UnionType,
          types: [
            Telegex.Type.InlineKeyboardMarkup,
            Telegex.Type.ReplyKeyboardMarkup,
            Telegex.Type.ReplyKeyboardRemove,
            Telegex.Type.ForceReply
          ]
        }
      }
    ],
    Telegex.Type.Message
  )

  defmethod(
    "sendAnimation",
    "Use this method to send animation files (GIF or H.264/MPEG-4 AVC video without sound). On success, the sent Message is returned. Bots can currently send animation files of up to 50 MB in size, this limit may be changed in the future.",
    [
      %{
        description:
          "Unique identifier of the business connection on behalf of which the message will be sent",
        name: :business_connection_id,
        required: false,
        type: :string
      },
      %{
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        name: :chat_id,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      },
      %{
        description:
          "Unique identifier for the target message thread (topic) of the forum; for forum supergroups only",
        name: :message_thread_id,
        required: false,
        type: :integer
      },
      %{
        description:
          "Animation to send. Pass a file_id as String to send an animation that exists on the Telegram servers (recommended), pass an HTTP URL as a String for Telegram to get an animation from the Internet, or upload a new animation using multipart/form-data. More information on Sending Files »",
        name: :animation,
        required: true,
        type: %{
          __struct__: Telegex.TypeDefiner.UnionType,
          types: [Telegex.Type.InputFile, :string]
        }
      },
      %{
        description: "Duration of sent animation in seconds",
        name: :duration,
        required: false,
        type: :integer
      },
      %{description: "Animation width", name: :width, required: false, type: :integer},
      %{description: "Animation height", name: :height, required: false, type: :integer},
      %{
        description:
          "Thumbnail of the file sent; can be ignored if thumbnail generation for the file is supported server-side. The thumbnail should be in JPEG format and less than 200 kB in size. A thumbnail's width and height should not exceed 320. Ignored if the file is not uploaded using multipart/form-data. Thumbnails can't be reused and can be only uploaded as a new file, so you can pass “attach://<file_attach_name>” if the thumbnail was uploaded using multipart/form-data under <file_attach_name>. More information on Sending Files »",
        name: :thumbnail,
        required: false,
        type: %{
          __struct__: Telegex.TypeDefiner.UnionType,
          types: [Telegex.Type.InputFile, :string]
        }
      },
      %{
        description:
          "Animation caption (may also be used when resending animation by file_id), 0-1024 characters after entities parsing",
        name: :caption,
        required: false,
        type: :string
      },
      %{
        description:
          "Mode for parsing entities in the animation caption. See formatting options for more details.",
        name: :parse_mode,
        required: false,
        type: :string
      },
      %{
        description:
          "A JSON-serialized list of special entities that appear in the caption, which can be specified instead of parse_mode",
        name: :caption_entities,
        required: false,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity}
      },
      %{
        description: "Pass True, if the caption must be shown above the message media",
        name: :show_caption_above_media,
        required: false,
        type: :boolean
      },
      %{
        description: "Pass True if the animation needs to be covered with a spoiler animation",
        name: :has_spoiler,
        required: false,
        type: :boolean
      },
      %{
        description:
          "Sends the message silently. Users will receive a notification with no sound.",
        name: :disable_notification,
        required: false,
        type: :boolean
      },
      %{
        description: "Protects the contents of the sent message from forwarding and saving",
        name: :protect_content,
        required: false,
        type: :boolean
      },
      %{
        description:
          "Pass True to allow up to 1000 messages per second, ignoring broadcasting limits for a fee of 0.1 Telegram Stars per message. The relevant Stars will be withdrawn from the bot's balance",
        name: :allow_paid_broadcast,
        required: false,
        type: :boolean
      },
      %{
        description:
          "Unique identifier of the message effect to be added to the message; for private chats only",
        name: :message_effect_id,
        required: false,
        type: :string
      },
      %{
        description: "Description of the message to reply to",
        name: :reply_parameters,
        required: false,
        type: Telegex.Type.ReplyParameters
      },
      %{
        description:
          "Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove a reply keyboard or to force a reply from the user",
        name: :reply_markup,
        required: false,
        type: %{
          __struct__: Telegex.TypeDefiner.UnionType,
          types: [
            Telegex.Type.InlineKeyboardMarkup,
            Telegex.Type.ReplyKeyboardMarkup,
            Telegex.Type.ReplyKeyboardRemove,
            Telegex.Type.ForceReply
          ]
        }
      }
    ],
    Telegex.Type.Message
  )

  defmethod(
    "sendVoice",
    "Use this method to send audio files, if you want Telegram clients to display the file as a playable voice message. For this to work, your audio must be in an .OGG file encoded with OPUS, or in .MP3 format, or in .M4A format (other formats may be sent as Audio or Document). On success, the sent Message is returned. Bots can currently send voice messages of up to 50 MB in size, this limit may be changed in the future.",
    [
      %{
        description:
          "Unique identifier of the business connection on behalf of which the message will be sent",
        name: :business_connection_id,
        required: false,
        type: :string
      },
      %{
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        name: :chat_id,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      },
      %{
        description:
          "Unique identifier for the target message thread (topic) of the forum; for forum supergroups only",
        name: :message_thread_id,
        required: false,
        type: :integer
      },
      %{
        description:
          "Audio file to send. Pass a file_id as String to send a file that exists on the Telegram servers (recommended), pass an HTTP URL as a String for Telegram to get a file from the Internet, or upload a new one using multipart/form-data. More information on Sending Files »",
        name: :voice,
        required: true,
        type: %{
          __struct__: Telegex.TypeDefiner.UnionType,
          types: [Telegex.Type.InputFile, :string]
        }
      },
      %{
        description: "Voice message caption, 0-1024 characters after entities parsing",
        name: :caption,
        required: false,
        type: :string
      },
      %{
        description:
          "Mode for parsing entities in the voice message caption. See formatting options for more details.",
        name: :parse_mode,
        required: false,
        type: :string
      },
      %{
        description:
          "A JSON-serialized list of special entities that appear in the caption, which can be specified instead of parse_mode",
        name: :caption_entities,
        required: false,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity}
      },
      %{
        description: "Duration of the voice message in seconds",
        name: :duration,
        required: false,
        type: :integer
      },
      %{
        description:
          "Sends the message silently. Users will receive a notification with no sound.",
        name: :disable_notification,
        required: false,
        type: :boolean
      },
      %{
        description: "Protects the contents of the sent message from forwarding and saving",
        name: :protect_content,
        required: false,
        type: :boolean
      },
      %{
        description:
          "Pass True to allow up to 1000 messages per second, ignoring broadcasting limits for a fee of 0.1 Telegram Stars per message. The relevant Stars will be withdrawn from the bot's balance",
        name: :allow_paid_broadcast,
        required: false,
        type: :boolean
      },
      %{
        description:
          "Unique identifier of the message effect to be added to the message; for private chats only",
        name: :message_effect_id,
        required: false,
        type: :string
      },
      %{
        description: "Description of the message to reply to",
        name: :reply_parameters,
        required: false,
        type: Telegex.Type.ReplyParameters
      },
      %{
        description:
          "Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove a reply keyboard or to force a reply from the user",
        name: :reply_markup,
        required: false,
        type: %{
          __struct__: Telegex.TypeDefiner.UnionType,
          types: [
            Telegex.Type.InlineKeyboardMarkup,
            Telegex.Type.ReplyKeyboardMarkup,
            Telegex.Type.ReplyKeyboardRemove,
            Telegex.Type.ForceReply
          ]
        }
      }
    ],
    Telegex.Type.Message
  )

  defmethod(
    "sendVideoNote",
    "As of v.4.0, Telegram clients support rounded square MPEG4 videos of up to 1 minute long. Use this method to send video messages. On success, the sent Message is returned.",
    [
      %{
        description:
          "Unique identifier of the business connection on behalf of which the message will be sent",
        name: :business_connection_id,
        required: false,
        type: :string
      },
      %{
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        name: :chat_id,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      },
      %{
        description:
          "Unique identifier for the target message thread (topic) of the forum; for forum supergroups only",
        name: :message_thread_id,
        required: false,
        type: :integer
      },
      %{
        description:
          "Video note to send. Pass a file_id as String to send a video note that exists on the Telegram servers (recommended) or upload a new video using multipart/form-data. More information on Sending Files ». Sending video notes by a URL is currently unsupported",
        name: :video_note,
        required: true,
        type: %{
          __struct__: Telegex.TypeDefiner.UnionType,
          types: [Telegex.Type.InputFile, :string]
        }
      },
      %{
        description: "Duration of sent video in seconds",
        name: :duration,
        required: false,
        type: :integer
      },
      %{
        description: "Video width and height, i.e. diameter of the video message",
        name: :length,
        required: false,
        type: :integer
      },
      %{
        description:
          "Thumbnail of the file sent; can be ignored if thumbnail generation for the file is supported server-side. The thumbnail should be in JPEG format and less than 200 kB in size. A thumbnail's width and height should not exceed 320. Ignored if the file is not uploaded using multipart/form-data. Thumbnails can't be reused and can be only uploaded as a new file, so you can pass “attach://<file_attach_name>” if the thumbnail was uploaded using multipart/form-data under <file_attach_name>. More information on Sending Files »",
        name: :thumbnail,
        required: false,
        type: %{
          __struct__: Telegex.TypeDefiner.UnionType,
          types: [Telegex.Type.InputFile, :string]
        }
      },
      %{
        description:
          "Sends the message silently. Users will receive a notification with no sound.",
        name: :disable_notification,
        required: false,
        type: :boolean
      },
      %{
        description: "Protects the contents of the sent message from forwarding and saving",
        name: :protect_content,
        required: false,
        type: :boolean
      },
      %{
        description:
          "Pass True to allow up to 1000 messages per second, ignoring broadcasting limits for a fee of 0.1 Telegram Stars per message. The relevant Stars will be withdrawn from the bot's balance",
        name: :allow_paid_broadcast,
        required: false,
        type: :boolean
      },
      %{
        description:
          "Unique identifier of the message effect to be added to the message; for private chats only",
        name: :message_effect_id,
        required: false,
        type: :string
      },
      %{
        description: "Description of the message to reply to",
        name: :reply_parameters,
        required: false,
        type: Telegex.Type.ReplyParameters
      },
      %{
        description:
          "Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove a reply keyboard or to force a reply from the user",
        name: :reply_markup,
        required: false,
        type: %{
          __struct__: Telegex.TypeDefiner.UnionType,
          types: [
            Telegex.Type.InlineKeyboardMarkup,
            Telegex.Type.ReplyKeyboardMarkup,
            Telegex.Type.ReplyKeyboardRemove,
            Telegex.Type.ForceReply
          ]
        }
      }
    ],
    Telegex.Type.Message
  )

  defmethod(
    "sendPaidMedia",
    "Use this method to send paid media. On success, the sent Message is returned.",
    [
      %{
        description:
          "Unique identifier of the business connection on behalf of which the message will be sent",
        name: :business_connection_id,
        required: false,
        type: :string
      },
      %{
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername). If the chat is a channel, all Telegram Star proceeds from this media will be credited to the chat's balance. Otherwise, they will be credited to the bot's balance.",
        name: :chat_id,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      },
      %{
        description:
          "The number of Telegram Stars that must be paid to buy access to the media; 1-2500",
        name: :star_count,
        required: true,
        type: :integer
      },
      %{
        description: "A JSON-serialized array describing the media to be sent; up to 10 items",
        name: :media,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.InputPaidMedia}
      },
      %{
        description:
          "Bot-defined paid media payload, 0-128 bytes. This will not be displayed to the user, use it for your internal processes.",
        name: :payload,
        required: false,
        type: :string
      },
      %{
        description: "Media caption, 0-1024 characters after entities parsing",
        name: :caption,
        required: false,
        type: :string
      },
      %{
        description:
          "Mode for parsing entities in the media caption. See formatting options for more details.",
        name: :parse_mode,
        required: false,
        type: :string
      },
      %{
        description:
          "A JSON-serialized list of special entities that appear in the caption, which can be specified instead of parse_mode",
        name: :caption_entities,
        required: false,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity}
      },
      %{
        description: "Pass True, if the caption must be shown above the message media",
        name: :show_caption_above_media,
        required: false,
        type: :boolean
      },
      %{
        description:
          "Sends the message silently. Users will receive a notification with no sound.",
        name: :disable_notification,
        required: false,
        type: :boolean
      },
      %{
        description: "Protects the contents of the sent message from forwarding and saving",
        name: :protect_content,
        required: false,
        type: :boolean
      },
      %{
        description:
          "Pass True to allow up to 1000 messages per second, ignoring broadcasting limits for a fee of 0.1 Telegram Stars per message. The relevant Stars will be withdrawn from the bot's balance",
        name: :allow_paid_broadcast,
        required: false,
        type: :boolean
      },
      %{
        description: "Description of the message to reply to",
        name: :reply_parameters,
        required: false,
        type: Telegex.Type.ReplyParameters
      },
      %{
        description:
          "Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove a reply keyboard or to force a reply from the user",
        name: :reply_markup,
        required: false,
        type: %{
          __struct__: Telegex.TypeDefiner.UnionType,
          types: [
            Telegex.Type.InlineKeyboardMarkup,
            Telegex.Type.ReplyKeyboardMarkup,
            Telegex.Type.ReplyKeyboardRemove,
            Telegex.Type.ForceReply
          ]
        }
      }
    ],
    Telegex.Type.Message
  )

  defmethod(
    "sendMediaGroup",
    "Use this method to send a group of photos, videos, documents or audios as an album. Documents and audio files can be only grouped in an album with messages of the same type. On success, an array of Messages that were sent is returned.",
    [
      %{
        description:
          "Unique identifier of the business connection on behalf of which the message will be sent",
        name: :business_connection_id,
        required: false,
        type: :string
      },
      %{
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        name: :chat_id,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      },
      %{
        description:
          "Unique identifier for the target message thread (topic) of the forum; for forum supergroups only",
        name: :message_thread_id,
        required: false,
        type: :integer
      },
      %{
        description:
          "A JSON-serialized array describing messages to be sent, must include 2-10 items",
        name: :media,
        required: true,
        type: %{
          __struct__: Telegex.TypeDefiner.UnionType,
          types: [
            %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.InputMediaAudio},
            %{
              __struct__: Telegex.TypeDefiner.ArrayType,
              elem_type: Telegex.Type.InputMediaDocument
            },
            %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.InputMediaPhoto},
            %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.InputMediaVideo}
          ]
        }
      },
      %{
        description: "Sends messages silently. Users will receive a notification with no sound.",
        name: :disable_notification,
        required: false,
        type: :boolean
      },
      %{
        description: "Protects the contents of the sent messages from forwarding and saving",
        name: :protect_content,
        required: false,
        type: :boolean
      },
      %{
        description:
          "Pass True to allow up to 1000 messages per second, ignoring broadcasting limits for a fee of 0.1 Telegram Stars per message. The relevant Stars will be withdrawn from the bot's balance",
        name: :allow_paid_broadcast,
        required: false,
        type: :boolean
      },
      %{
        description:
          "Unique identifier of the message effect to be added to the message; for private chats only",
        name: :message_effect_id,
        required: false,
        type: :string
      },
      %{
        description: "Description of the message to reply to",
        name: :reply_parameters,
        required: false,
        type: Telegex.Type.ReplyParameters
      }
    ],
    %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.Message}
  )

  defmethod(
    "sendLocation",
    "Use this method to send point on the map. On success, the sent Message is returned.",
    [
      %{
        description:
          "Unique identifier of the business connection on behalf of which the message will be sent",
        name: :business_connection_id,
        required: false,
        type: :string
      },
      %{
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        name: :chat_id,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      },
      %{
        description:
          "Unique identifier for the target message thread (topic) of the forum; for forum supergroups only",
        name: :message_thread_id,
        required: false,
        type: :integer
      },
      %{description: "Latitude of the location", name: :latitude, required: true, type: :float},
      %{description: "Longitude of the location", name: :longitude, required: true, type: :float},
      %{
        description: "The radius of uncertainty for the location, measured in meters; 0-1500",
        name: :horizontal_accuracy,
        required: false,
        type: :float
      },
      %{
        description:
          "Period in seconds during which the location will be updated (see Live Locations, should be between 60 and 86400, or 0x7FFFFFFF for live locations that can be edited indefinitely.",
        name: :live_period,
        required: false,
        type: :integer
      },
      %{
        description:
          "For live locations, a direction in which the user is moving, in degrees. Must be between 1 and 360 if specified.",
        name: :heading,
        required: false,
        type: :integer
      },
      %{
        description:
          "For live locations, a maximum distance for proximity alerts about approaching another chat member, in meters. Must be between 1 and 100000 if specified.",
        name: :proximity_alert_radius,
        required: false,
        type: :integer
      },
      %{
        description:
          "Sends the message silently. Users will receive a notification with no sound.",
        name: :disable_notification,
        required: false,
        type: :boolean
      },
      %{
        description: "Protects the contents of the sent message from forwarding and saving",
        name: :protect_content,
        required: false,
        type: :boolean
      },
      %{
        description:
          "Pass True to allow up to 1000 messages per second, ignoring broadcasting limits for a fee of 0.1 Telegram Stars per message. The relevant Stars will be withdrawn from the bot's balance",
        name: :allow_paid_broadcast,
        required: false,
        type: :boolean
      },
      %{
        description:
          "Unique identifier of the message effect to be added to the message; for private chats only",
        name: :message_effect_id,
        required: false,
        type: :string
      },
      %{
        description: "Description of the message to reply to",
        name: :reply_parameters,
        required: false,
        type: Telegex.Type.ReplyParameters
      },
      %{
        description:
          "Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove a reply keyboard or to force a reply from the user",
        name: :reply_markup,
        required: false,
        type: %{
          __struct__: Telegex.TypeDefiner.UnionType,
          types: [
            Telegex.Type.InlineKeyboardMarkup,
            Telegex.Type.ReplyKeyboardMarkup,
            Telegex.Type.ReplyKeyboardRemove,
            Telegex.Type.ForceReply
          ]
        }
      }
    ],
    Telegex.Type.Message
  )

  defmethod(
    "sendVenue",
    "Use this method to send information about a venue. On success, the sent Message is returned.",
    [
      %{
        description:
          "Unique identifier of the business connection on behalf of which the message will be sent",
        name: :business_connection_id,
        required: false,
        type: :string
      },
      %{
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        name: :chat_id,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      },
      %{
        description:
          "Unique identifier for the target message thread (topic) of the forum; for forum supergroups only",
        name: :message_thread_id,
        required: false,
        type: :integer
      },
      %{description: "Latitude of the venue", name: :latitude, required: true, type: :float},
      %{description: "Longitude of the venue", name: :longitude, required: true, type: :float},
      %{description: "Name of the venue", name: :title, required: true, type: :string},
      %{description: "Address of the venue", name: :address, required: true, type: :string},
      %{
        description: "Foursquare identifier of the venue",
        name: :foursquare_id,
        required: false,
        type: :string
      },
      %{
        description:
          "Foursquare type of the venue, if known. (For example, “arts_entertainment/default”, “arts_entertainment/aquarium” or “food/icecream”.)",
        name: :foursquare_type,
        required: false,
        type: :string
      },
      %{
        description: "Google Places identifier of the venue",
        name: :google_place_id,
        required: false,
        type: :string
      },
      %{
        description: "Google Places type of the venue. (See supported types.)",
        name: :google_place_type,
        required: false,
        type: :string
      },
      %{
        description:
          "Sends the message silently. Users will receive a notification with no sound.",
        name: :disable_notification,
        required: false,
        type: :boolean
      },
      %{
        description: "Protects the contents of the sent message from forwarding and saving",
        name: :protect_content,
        required: false,
        type: :boolean
      },
      %{
        description:
          "Pass True to allow up to 1000 messages per second, ignoring broadcasting limits for a fee of 0.1 Telegram Stars per message. The relevant Stars will be withdrawn from the bot's balance",
        name: :allow_paid_broadcast,
        required: false,
        type: :boolean
      },
      %{
        description:
          "Unique identifier of the message effect to be added to the message; for private chats only",
        name: :message_effect_id,
        required: false,
        type: :string
      },
      %{
        description: "Description of the message to reply to",
        name: :reply_parameters,
        required: false,
        type: Telegex.Type.ReplyParameters
      },
      %{
        description:
          "Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove a reply keyboard or to force a reply from the user",
        name: :reply_markup,
        required: false,
        type: %{
          __struct__: Telegex.TypeDefiner.UnionType,
          types: [
            Telegex.Type.InlineKeyboardMarkup,
            Telegex.Type.ReplyKeyboardMarkup,
            Telegex.Type.ReplyKeyboardRemove,
            Telegex.Type.ForceReply
          ]
        }
      }
    ],
    Telegex.Type.Message
  )

  defmethod(
    "sendContact",
    "Use this method to send phone contacts. On success, the sent Message is returned.",
    [
      %{
        description:
          "Unique identifier of the business connection on behalf of which the message will be sent",
        name: :business_connection_id,
        required: false,
        type: :string
      },
      %{
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        name: :chat_id,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      },
      %{
        description:
          "Unique identifier for the target message thread (topic) of the forum; for forum supergroups only",
        name: :message_thread_id,
        required: false,
        type: :integer
      },
      %{
        description: "Contact's phone number",
        name: :phone_number,
        required: true,
        type: :string
      },
      %{description: "Contact's first name", name: :first_name, required: true, type: :string},
      %{description: "Contact's last name", name: :last_name, required: false, type: :string},
      %{
        description: "Additional data about the contact in the form of a vCard, 0-2048 bytes",
        name: :vcard,
        required: false,
        type: :string
      },
      %{
        description:
          "Sends the message silently. Users will receive a notification with no sound.",
        name: :disable_notification,
        required: false,
        type: :boolean
      },
      %{
        description: "Protects the contents of the sent message from forwarding and saving",
        name: :protect_content,
        required: false,
        type: :boolean
      },
      %{
        description:
          "Pass True to allow up to 1000 messages per second, ignoring broadcasting limits for a fee of 0.1 Telegram Stars per message. The relevant Stars will be withdrawn from the bot's balance",
        name: :allow_paid_broadcast,
        required: false,
        type: :boolean
      },
      %{
        description:
          "Unique identifier of the message effect to be added to the message; for private chats only",
        name: :message_effect_id,
        required: false,
        type: :string
      },
      %{
        description: "Description of the message to reply to",
        name: :reply_parameters,
        required: false,
        type: Telegex.Type.ReplyParameters
      },
      %{
        description:
          "Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove a reply keyboard or to force a reply from the user",
        name: :reply_markup,
        required: false,
        type: %{
          __struct__: Telegex.TypeDefiner.UnionType,
          types: [
            Telegex.Type.InlineKeyboardMarkup,
            Telegex.Type.ReplyKeyboardMarkup,
            Telegex.Type.ReplyKeyboardRemove,
            Telegex.Type.ForceReply
          ]
        }
      }
    ],
    Telegex.Type.Message
  )

  defmethod(
    "sendPoll",
    "Use this method to send a native poll. On success, the sent Message is returned.",
    [
      %{
        description:
          "Unique identifier of the business connection on behalf of which the message will be sent",
        name: :business_connection_id,
        required: false,
        type: :string
      },
      %{
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        name: :chat_id,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      },
      %{
        description:
          "Unique identifier for the target message thread (topic) of the forum; for forum supergroups only",
        name: :message_thread_id,
        required: false,
        type: :integer
      },
      %{
        description: "Poll question, 1-300 characters",
        name: :question,
        required: true,
        type: :string
      },
      %{
        description:
          "Mode for parsing entities in the question. See formatting options for more details. Currently, only custom emoji entities are allowed",
        name: :question_parse_mode,
        required: false,
        type: :string
      },
      %{
        description:
          "A JSON-serialized list of special entities that appear in the poll question. It can be specified instead of question_parse_mode",
        name: :question_entities,
        required: false,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity}
      },
      %{
        description: "A JSON-serialized list of 2-10 answer options",
        name: :options,
        required: true,
        type: %{
          __struct__: Telegex.TypeDefiner.ArrayType,
          elem_type: Telegex.Type.InputPollOption
        }
      },
      %{
        description: "True, if the poll needs to be anonymous, defaults to True",
        name: :is_anonymous,
        required: false,
        type: :boolean
      },
      %{
        description: "Poll type, “quiz” or “regular”, defaults to “regular”",
        name: :type,
        required: false,
        type: :string
      },
      %{
        description:
          "True, if the poll allows multiple answers, ignored for polls in quiz mode, defaults to False",
        name: :allows_multiple_answers,
        required: false,
        type: :boolean
      },
      %{
        description:
          "0-based identifier of the correct answer option, required for polls in quiz mode",
        name: :correct_option_id,
        required: false,
        type: :integer
      },
      %{
        description:
          "Text that is shown when a user chooses an incorrect answer or taps on the lamp icon in a quiz-style poll, 0-200 characters with at most 2 line feeds after entities parsing",
        name: :explanation,
        required: false,
        type: :string
      },
      %{
        description:
          "Mode for parsing entities in the explanation. See formatting options for more details.",
        name: :explanation_parse_mode,
        required: false,
        type: :string
      },
      %{
        description:
          "A JSON-serialized list of special entities that appear in the poll explanation. It can be specified instead of explanation_parse_mode",
        name: :explanation_entities,
        required: false,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity}
      },
      %{
        description:
          "Amount of time in seconds the poll will be active after creation, 5-600. Can't be used together with close_date.",
        name: :open_period,
        required: false,
        type: :integer
      },
      %{
        description:
          "Point in time (Unix timestamp) when the poll will be automatically closed. Must be at least 5 and no more than 600 seconds in the future. Can't be used together with open_period.",
        name: :close_date,
        required: false,
        type: :integer
      },
      %{
        description:
          "Pass True if the poll needs to be immediately closed. This can be useful for poll preview.",
        name: :is_closed,
        required: false,
        type: :boolean
      },
      %{
        description:
          "Sends the message silently. Users will receive a notification with no sound.",
        name: :disable_notification,
        required: false,
        type: :boolean
      },
      %{
        description: "Protects the contents of the sent message from forwarding and saving",
        name: :protect_content,
        required: false,
        type: :boolean
      },
      %{
        description:
          "Pass True to allow up to 1000 messages per second, ignoring broadcasting limits for a fee of 0.1 Telegram Stars per message. The relevant Stars will be withdrawn from the bot's balance",
        name: :allow_paid_broadcast,
        required: false,
        type: :boolean
      },
      %{
        description:
          "Unique identifier of the message effect to be added to the message; for private chats only",
        name: :message_effect_id,
        required: false,
        type: :string
      },
      %{
        description: "Description of the message to reply to",
        name: :reply_parameters,
        required: false,
        type: Telegex.Type.ReplyParameters
      },
      %{
        description:
          "Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove a reply keyboard or to force a reply from the user",
        name: :reply_markup,
        required: false,
        type: %{
          __struct__: Telegex.TypeDefiner.UnionType,
          types: [
            Telegex.Type.InlineKeyboardMarkup,
            Telegex.Type.ReplyKeyboardMarkup,
            Telegex.Type.ReplyKeyboardRemove,
            Telegex.Type.ForceReply
          ]
        }
      }
    ],
    Telegex.Type.Message
  )

  defmethod(
    "sendDice",
    "Use this method to send an animated emoji that will display a random value. On success, the sent Message is returned.",
    [
      %{
        description:
          "Unique identifier of the business connection on behalf of which the message will be sent",
        name: :business_connection_id,
        required: false,
        type: :string
      },
      %{
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        name: :chat_id,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      },
      %{
        description:
          "Unique identifier for the target message thread (topic) of the forum; for forum supergroups only",
        name: :message_thread_id,
        required: false,
        type: :integer
      },
      %{
        description:
          "Emoji on which the dice throw animation is based. Currently, must be one of “”, “”, “”, “”, “”, or “”. Dice can have values 1-6 for “”, “” and “”, values 1-5 for “” and “”, and values 1-64 for “”. Defaults to “”",
        name: :emoji,
        required: false,
        type: :string
      },
      %{
        description:
          "Sends the message silently. Users will receive a notification with no sound.",
        name: :disable_notification,
        required: false,
        type: :boolean
      },
      %{
        description: "Protects the contents of the sent message from forwarding",
        name: :protect_content,
        required: false,
        type: :boolean
      },
      %{
        description:
          "Pass True to allow up to 1000 messages per second, ignoring broadcasting limits for a fee of 0.1 Telegram Stars per message. The relevant Stars will be withdrawn from the bot's balance",
        name: :allow_paid_broadcast,
        required: false,
        type: :boolean
      },
      %{
        description:
          "Unique identifier of the message effect to be added to the message; for private chats only",
        name: :message_effect_id,
        required: false,
        type: :string
      },
      %{
        description: "Description of the message to reply to",
        name: :reply_parameters,
        required: false,
        type: Telegex.Type.ReplyParameters
      },
      %{
        description:
          "Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove a reply keyboard or to force a reply from the user",
        name: :reply_markup,
        required: false,
        type: %{
          __struct__: Telegex.TypeDefiner.UnionType,
          types: [
            Telegex.Type.InlineKeyboardMarkup,
            Telegex.Type.ReplyKeyboardMarkup,
            Telegex.Type.ReplyKeyboardRemove,
            Telegex.Type.ForceReply
          ]
        }
      }
    ],
    Telegex.Type.Message
  )

  defmethod(
    "sendChatAction",
    "Use this method when you need to tell the user that something is happening on the bot's side. The status is set for 5 seconds or less (when a message arrives from your bot, Telegram clients clear its typing status). Returns True on success.",
    [
      %{
        description:
          "Unique identifier of the business connection on behalf of which the action will be sent",
        name: :business_connection_id,
        required: false,
        type: :string
      },
      %{
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        name: :chat_id,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      },
      %{
        description: "Unique identifier for the target message thread; for supergroups only",
        name: :message_thread_id,
        required: false,
        type: :integer
      },
      %{
        description:
          "Type of action to broadcast. Choose one, depending on what the user is about to receive: typing for text messages, upload_photo for photos, record_video or upload_video for videos, record_voice or upload_voice for voice notes, upload_document for general files, choose_sticker for stickers, find_location for location data, record_video_note or upload_video_note for video notes.",
        name: :action,
        required: true,
        type: :string
      }
    ],
    :boolean
  )

  defmethod(
    "setMessageReaction",
    "Use this method to change the chosen reactions on a message. Service messages can't be reacted to. Automatically forwarded messages from a channel to its discussion group have the same available reactions as messages in the channel. Bots can't use paid reactions. Returns True on success.",
    [
      %{
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        name: :chat_id,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      },
      %{
        description:
          "Identifier of the target message. If the message belongs to a media group, the reaction is set to the first non-deleted message in the group instead.",
        name: :message_id,
        required: true,
        type: :integer
      },
      %{
        description:
          "A JSON-serialized list of reaction types to set on the message. Currently, as non-premium users, bots can set up to one reaction per message. A custom emoji reaction can be used if it is either already present on the message or explicitly allowed by chat administrators. Paid reactions can't be used by bots.",
        name: :reaction,
        required: false,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.ReactionType}
      },
      %{
        description: "Pass True to set the reaction with a big animation",
        name: :is_big,
        required: false,
        type: :boolean
      }
    ],
    :boolean
  )

  defmethod(
    "getUserProfilePhotos",
    "Use this method to get a list of profile pictures for a user. Returns a UserProfilePhotos object.",
    [
      %{
        description: "Unique identifier of the target user",
        name: :user_id,
        required: true,
        type: :integer
      },
      %{
        description:
          "Sequential number of the first photo to be returned. By default, all photos are returned.",
        name: :offset,
        required: false,
        type: :integer
      },
      %{
        description:
          "Limits the number of photos to be retrieved. Values between 1-100 are accepted. Defaults to 100.",
        name: :limit,
        required: false,
        type: :integer
      }
    ],
    Telegex.Type.UserProfilePhotos
  )

  defmethod(
    "getFile",
    "Use this method to get basic information about a file and prepare it for downloading. For the moment, bots can download files of up to 20MB in size. On success, a File object is returned. The file can then be downloaded via the link https://api.telegram.org/file/bot<token>/<file_path>, where <file_path> is taken from the response. It is guaranteed that the link will be valid for at least 1 hour. When the link expires, a new one can be requested by calling getFile again.",
    [
      %{
        description: "File identifier to get information about",
        name: :file_id,
        required: true,
        type: :string
      }
    ],
    Telegex.Type.File
  )

  defmethod(
    "banChatMember",
    "Use this method to ban a user in a group, a supergroup or a channel. In the case of supergroups and channels, the user will not be able to return to the chat on their own using invite links, etc., unless unbanned first. The bot must be an administrator in the chat for this to work and must have the appropriate administrator rights. Returns True on success.",
    [
      %{
        description:
          "Unique identifier for the target group or username of the target supergroup or channel (in the format @channelusername)",
        name: :chat_id,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      },
      %{
        description: "Unique identifier of the target user",
        name: :user_id,
        required: true,
        type: :integer
      },
      %{
        description:
          "Date when the user will be unbanned; Unix time. If user is banned for more than 366 days or less than 30 seconds from the current time they are considered to be banned forever. Applied for supergroups and channels only.",
        name: :until_date,
        required: false,
        type: :integer
      },
      %{
        description:
          "Pass True to delete all messages from the chat for the user that is being removed. If False, the user will be able to see messages in the group that were sent before the user was removed. Always True for supergroups and channels.",
        name: :revoke_messages,
        required: false,
        type: :boolean
      }
    ],
    :boolean
  )

  defmethod(
    "unbanChatMember",
    "Use this method to unban a previously banned user in a supergroup or channel. The user will not return to the group or channel automatically, but will be able to join via link, etc. The bot must be an administrator for this to work. By default, this method guarantees that after the call the user is not a member of the chat, but will be able to join it. So if the user is a member of the chat they will also be removed from the chat. If you don't want this, use the parameter only_if_banned. Returns True on success.",
    [
      %{
        description:
          "Unique identifier for the target group or username of the target supergroup or channel (in the format @channelusername)",
        name: :chat_id,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      },
      %{
        description: "Unique identifier of the target user",
        name: :user_id,
        required: true,
        type: :integer
      },
      %{
        description: "Do nothing if the user is not banned",
        name: :only_if_banned,
        required: false,
        type: :boolean
      }
    ],
    :boolean
  )

  defmethod(
    "restrictChatMember",
    "Use this method to restrict a user in a supergroup. The bot must be an administrator in the supergroup for this to work and must have the appropriate administrator rights. Pass True for all permissions to lift restrictions from a user. Returns True on success.",
    [
      %{
        description:
          "Unique identifier for the target chat or username of the target supergroup (in the format @supergroupusername)",
        name: :chat_id,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      },
      %{
        description: "Unique identifier of the target user",
        name: :user_id,
        required: true,
        type: :integer
      },
      %{
        description: "A JSON-serialized object for new user permissions",
        name: :permissions,
        required: true,
        type: Telegex.Type.ChatPermissions
      },
      %{
        description:
          "Pass True if chat permissions are set independently. Otherwise, the can_send_other_messages and can_add_web_page_previews permissions will imply the can_send_messages, can_send_audios, can_send_documents, can_send_photos, can_send_videos, can_send_video_notes, and can_send_voice_notes permissions; the can_send_polls permission will imply the can_send_messages permission.",
        name: :use_independent_chat_permissions,
        required: false,
        type: :boolean
      },
      %{
        description:
          "Date when restrictions will be lifted for the user; Unix time. If user is restricted for more than 366 days or less than 30 seconds from the current time, they are considered to be restricted forever",
        name: :until_date,
        required: false,
        type: :integer
      }
    ],
    :boolean
  )

  defmethod(
    "promoteChatMember",
    "Use this method to promote or demote a user in a supergroup or a channel. The bot must be an administrator in the chat for this to work and must have the appropriate administrator rights. Pass False for all boolean parameters to demote a user. Returns True on success.",
    [
      %{
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        name: :chat_id,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      },
      %{
        description: "Unique identifier of the target user",
        name: :user_id,
        required: true,
        type: :integer
      },
      %{
        description: "Pass True if the administrator's presence in the chat is hidden",
        name: :is_anonymous,
        required: false,
        type: :boolean
      },
      %{
        description:
          "Pass True if the administrator can access the chat event log, get boost list, see hidden supergroup and channel members, report spam messages and ignore slow mode. Implied by any other administrator privilege.",
        name: :can_manage_chat,
        required: false,
        type: :boolean
      },
      %{
        description: "Pass True if the administrator can delete messages of other users",
        name: :can_delete_messages,
        required: false,
        type: :boolean
      },
      %{
        description: "Pass True if the administrator can manage video chats",
        name: :can_manage_video_chats,
        required: false,
        type: :boolean
      },
      %{
        description:
          "Pass True if the administrator can restrict, ban or unban chat members, or access supergroup statistics",
        name: :can_restrict_members,
        required: false,
        type: :boolean
      },
      %{
        description:
          "Pass True if the administrator can add new administrators with a subset of their own privileges or demote administrators that they have promoted, directly or indirectly (promoted by administrators that were appointed by him)",
        name: :can_promote_members,
        required: false,
        type: :boolean
      },
      %{
        description:
          "Pass True if the administrator can change chat title, photo and other settings",
        name: :can_change_info,
        required: false,
        type: :boolean
      },
      %{
        description: "Pass True if the administrator can invite new users to the chat",
        name: :can_invite_users,
        required: false,
        type: :boolean
      },
      %{
        description: "Pass True if the administrator can post stories to the chat",
        name: :can_post_stories,
        required: false,
        type: :boolean
      },
      %{
        description:
          "Pass True if the administrator can edit stories posted by other users, post stories to the chat page, pin chat stories, and access the chat's story archive",
        name: :can_edit_stories,
        required: false,
        type: :boolean
      },
      %{
        description: "Pass True if the administrator can delete stories posted by other users",
        name: :can_delete_stories,
        required: false,
        type: :boolean
      },
      %{
        description:
          "Pass True if the administrator can post messages in the channel, or access channel statistics; for channels only",
        name: :can_post_messages,
        required: false,
        type: :boolean
      },
      %{
        description:
          "Pass True if the administrator can edit messages of other users and can pin messages; for channels only",
        name: :can_edit_messages,
        required: false,
        type: :boolean
      },
      %{
        description: "Pass True if the administrator can pin messages; for supergroups only",
        name: :can_pin_messages,
        required: false,
        type: :boolean
      },
      %{
        description:
          "Pass True if the user is allowed to create, rename, close, and reopen forum topics; for supergroups only",
        name: :can_manage_topics,
        required: false,
        type: :boolean
      }
    ],
    :boolean
  )

  defmethod(
    "setChatAdministratorCustomTitle",
    "Use this method to set a custom title for an administrator in a supergroup promoted by the bot. Returns True on success.",
    [
      %{
        description:
          "Unique identifier for the target chat or username of the target supergroup (in the format @supergroupusername)",
        name: :chat_id,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      },
      %{
        description: "Unique identifier of the target user",
        name: :user_id,
        required: true,
        type: :integer
      },
      %{
        description:
          "New custom title for the administrator; 0-16 characters, emoji are not allowed",
        name: :custom_title,
        required: true,
        type: :string
      }
    ],
    :boolean
  )

  defmethod(
    "banChatSenderChat",
    "Use this method to ban a channel chat in a supergroup or a channel. Until the chat is unbanned, the owner of the banned chat won't be able to send messages on behalf of any of their channels. The bot must be an administrator in the supergroup or channel for this to work and must have the appropriate administrator rights. Returns True on success.",
    [
      %{
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        name: :chat_id,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      },
      %{
        description: "Unique identifier of the target sender chat",
        name: :sender_chat_id,
        required: true,
        type: :integer
      }
    ],
    :boolean
  )

  defmethod(
    "unbanChatSenderChat",
    "Use this method to unban a previously banned channel chat in a supergroup or channel. The bot must be an administrator for this to work and must have the appropriate administrator rights. Returns True on success.",
    [
      %{
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        name: :chat_id,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      },
      %{
        description: "Unique identifier of the target sender chat",
        name: :sender_chat_id,
        required: true,
        type: :integer
      }
    ],
    :boolean
  )

  defmethod(
    "setChatPermissions",
    "Use this method to set default chat permissions for all members. The bot must be an administrator in the group or a supergroup for this to work and must have the can_restrict_members administrator rights. Returns True on success.",
    [
      %{
        description:
          "Unique identifier for the target chat or username of the target supergroup (in the format @supergroupusername)",
        name: :chat_id,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      },
      %{
        description: "A JSON-serialized object for new default chat permissions",
        name: :permissions,
        required: true,
        type: Telegex.Type.ChatPermissions
      },
      %{
        description:
          "Pass True if chat permissions are set independently. Otherwise, the can_send_other_messages and can_add_web_page_previews permissions will imply the can_send_messages, can_send_audios, can_send_documents, can_send_photos, can_send_videos, can_send_video_notes, and can_send_voice_notes permissions; the can_send_polls permission will imply the can_send_messages permission.",
        name: :use_independent_chat_permissions,
        required: false,
        type: :boolean
      }
    ],
    :boolean
  )

  defmethod(
    "exportChatInviteLink",
    "Use this method to generate a new primary invite link for a chat; any previously generated primary link is revoked. The bot must be an administrator in the chat for this to work and must have the appropriate administrator rights. Returns the new invite link as String on success.",
    [
      %{
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        name: :chat_id,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      }
    ],
    :string
  )

  defmethod(
    "createChatInviteLink",
    "Use this method to create an additional invite link for a chat. The bot must be an administrator in the chat for this to work and must have the appropriate administrator rights. The link can be revoked using the method revokeChatInviteLink. Returns the new invite link as ChatInviteLink object.",
    [
      %{
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        name: :chat_id,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      },
      %{
        description: "Invite link name; 0-32 characters",
        name: :name,
        required: false,
        type: :string
      },
      %{
        description: "Point in time (Unix timestamp) when the link will expire",
        name: :expire_date,
        required: false,
        type: :integer
      },
      %{
        description:
          "The maximum number of users that can be members of the chat simultaneously after joining the chat via this invite link; 1-99999",
        name: :member_limit,
        required: false,
        type: :integer
      },
      %{
        description:
          "True, if users joining the chat via the link need to be approved by chat administrators. If True, member_limit can't be specified",
        name: :creates_join_request,
        required: false,
        type: :boolean
      }
    ],
    Telegex.Type.ChatInviteLink
  )

  defmethod(
    "editChatInviteLink",
    "Use this method to edit a non-primary invite link created by the bot. The bot must be an administrator in the chat for this to work and must have the appropriate administrator rights. Returns the edited invite link as a ChatInviteLink object.",
    [
      %{
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        name: :chat_id,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      },
      %{
        description: "The invite link to edit",
        name: :invite_link,
        required: true,
        type: :string
      },
      %{
        description: "Invite link name; 0-32 characters",
        name: :name,
        required: false,
        type: :string
      },
      %{
        description: "Point in time (Unix timestamp) when the link will expire",
        name: :expire_date,
        required: false,
        type: :integer
      },
      %{
        description:
          "The maximum number of users that can be members of the chat simultaneously after joining the chat via this invite link; 1-99999",
        name: :member_limit,
        required: false,
        type: :integer
      },
      %{
        description:
          "True, if users joining the chat via the link need to be approved by chat administrators. If True, member_limit can't be specified",
        name: :creates_join_request,
        required: false,
        type: :boolean
      }
    ],
    Telegex.Type.ChatInviteLink
  )

  defmethod(
    "createChatSubscriptionInviteLink",
    "Use this method to create a subscription invite link for a channel chat. The bot must have the can_invite_users administrator rights. The link can be edited using the method editChatSubscriptionInviteLink or revoked using the method revokeChatInviteLink. Returns the new invite link as a ChatInviteLink object.",
    [
      %{
        description:
          "Unique identifier for the target channel chat or username of the target channel (in the format @channelusername)",
        name: :chat_id,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      },
      %{
        description: "Invite link name; 0-32 characters",
        name: :name,
        required: false,
        type: :string
      },
      %{
        description:
          "The number of seconds the subscription will be active for before the next payment. Currently, it must always be 2592000 (30 days).",
        name: :subscription_period,
        required: true,
        type: :integer
      },
      %{
        description:
          "The amount of Telegram Stars a user must pay initially and after each subsequent subscription period to be a member of the chat; 1-2500",
        name: :subscription_price,
        required: true,
        type: :integer
      }
    ],
    Telegex.Type.ChatInviteLink
  )

  defmethod(
    "editChatSubscriptionInviteLink",
    "Use this method to edit a subscription invite link created by the bot. The bot must have the can_invite_users administrator rights. Returns the edited invite link as a ChatInviteLink object.",
    [
      %{
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        name: :chat_id,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      },
      %{
        description: "The invite link to edit",
        name: :invite_link,
        required: true,
        type: :string
      },
      %{
        description: "Invite link name; 0-32 characters",
        name: :name,
        required: false,
        type: :string
      }
    ],
    Telegex.Type.ChatInviteLink
  )

  defmethod(
    "revokeChatInviteLink",
    "Use this method to revoke an invite link created by the bot. If the primary link is revoked, a new link is automatically generated. The bot must be an administrator in the chat for this to work and must have the appropriate administrator rights. Returns the revoked invite link as ChatInviteLink object.",
    [
      %{
        description:
          "Unique identifier of the target chat or username of the target channel (in the format @channelusername)",
        name: :chat_id,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      },
      %{
        description: "The invite link to revoke",
        name: :invite_link,
        required: true,
        type: :string
      }
    ],
    Telegex.Type.ChatInviteLink
  )

  defmethod(
    "approveChatJoinRequest",
    "Use this method to approve a chat join request. The bot must be an administrator in the chat for this to work and must have the can_invite_users administrator right. Returns True on success.",
    [
      %{
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        name: :chat_id,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      },
      %{
        description: "Unique identifier of the target user",
        name: :user_id,
        required: true,
        type: :integer
      }
    ],
    :boolean
  )

  defmethod(
    "declineChatJoinRequest",
    "Use this method to decline a chat join request. The bot must be an administrator in the chat for this to work and must have the can_invite_users administrator right. Returns True on success.",
    [
      %{
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        name: :chat_id,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      },
      %{
        description: "Unique identifier of the target user",
        name: :user_id,
        required: true,
        type: :integer
      }
    ],
    :boolean
  )

  defmethod(
    "setChatPhoto",
    "Use this method to set a new profile photo for the chat. Photos can't be changed for private chats. The bot must be an administrator in the chat for this to work and must have the appropriate administrator rights. Returns True on success.",
    [
      %{
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        name: :chat_id,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      },
      %{
        description: "New chat photo, uploaded using multipart/form-data",
        name: :photo,
        required: true,
        type: Telegex.Type.InputFile
      }
    ],
    :boolean
  )

  defmethod(
    "deleteChatPhoto",
    "Use this method to delete a chat photo. Photos can't be changed for private chats. The bot must be an administrator in the chat for this to work and must have the appropriate administrator rights. Returns True on success.",
    [
      %{
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        name: :chat_id,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      }
    ],
    :boolean
  )

  defmethod(
    "setChatTitle",
    "Use this method to change the title of a chat. Titles can't be changed for private chats. The bot must be an administrator in the chat for this to work and must have the appropriate administrator rights. Returns True on success.",
    [
      %{
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        name: :chat_id,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      },
      %{
        description: "New chat title, 1-128 characters",
        name: :title,
        required: true,
        type: :string
      }
    ],
    :boolean
  )

  defmethod(
    "setChatDescription",
    "Use this method to change the description of a group, a supergroup or a channel. The bot must be an administrator in the chat for this to work and must have the appropriate administrator rights. Returns True on success.",
    [
      %{
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        name: :chat_id,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      },
      %{
        description: "New chat description, 0-255 characters",
        name: :description,
        required: false,
        type: :string
      }
    ],
    :boolean
  )

  defmethod(
    "pinChatMessage",
    "Use this method to add a message to the list of pinned messages in a chat. If the chat is not a private chat, the bot must be an administrator in the chat for this to work and must have the 'can_pin_messages' administrator right in a supergroup or 'can_edit_messages' administrator right in a channel. Returns True on success.",
    [
      %{
        description:
          "Unique identifier of the business connection on behalf of which the message will be pinned",
        name: :business_connection_id,
        required: false,
        type: :string
      },
      %{
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        name: :chat_id,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      },
      %{
        description: "Identifier of a message to pin",
        name: :message_id,
        required: true,
        type: :integer
      },
      %{
        description:
          "Pass True if it is not necessary to send a notification to all chat members about the new pinned message. Notifications are always disabled in channels and private chats.",
        name: :disable_notification,
        required: false,
        type: :boolean
      }
    ],
    :boolean
  )

  defmethod(
    "unpinChatMessage",
    "Use this method to remove a message from the list of pinned messages in a chat. If the chat is not a private chat, the bot must be an administrator in the chat for this to work and must have the 'can_pin_messages' administrator right in a supergroup or 'can_edit_messages' administrator right in a channel. Returns True on success.",
    [
      %{
        description:
          "Unique identifier of the business connection on behalf of which the message will be unpinned",
        name: :business_connection_id,
        required: false,
        type: :string
      },
      %{
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        name: :chat_id,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      },
      %{
        description:
          "Identifier of the message to unpin. Required if business_connection_id is specified. If not specified, the most recent pinned message (by sending date) will be unpinned.",
        name: :message_id,
        required: false,
        type: :integer
      }
    ],
    :boolean
  )

  defmethod(
    "unpinAllChatMessages",
    "Use this method to clear the list of pinned messages in a chat. If the chat is not a private chat, the bot must be an administrator in the chat for this to work and must have the 'can_pin_messages' administrator right in a supergroup or 'can_edit_messages' administrator right in a channel. Returns True on success.",
    [
      %{
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        name: :chat_id,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      }
    ],
    :boolean
  )

  defmethod(
    "leaveChat",
    "Use this method for your bot to leave a group, supergroup or channel. Returns True on success.",
    [
      %{
        description:
          "Unique identifier for the target chat or username of the target supergroup or channel (in the format @channelusername)",
        name: :chat_id,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      }
    ],
    :boolean
  )

  defmethod(
    "getChat",
    "Use this method to get up-to-date information about the chat. Returns a ChatFullInfo object on success.",
    [
      %{
        description:
          "Unique identifier for the target chat or username of the target supergroup or channel (in the format @channelusername)",
        name: :chat_id,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      }
    ],
    Telegex.Type.ChatFullInfo
  )

  defmethod(
    "getChatAdministrators",
    "Use this method to get a list of administrators in a chat, which aren't bots. Returns an Array of ChatMember objects.",
    [
      %{
        description:
          "Unique identifier for the target chat or username of the target supergroup or channel (in the format @channelusername)",
        name: :chat_id,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      }
    ],
    %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.ChatMember}
  )

  defmethod(
    "getChatMemberCount",
    "Use this method to get the number of members in a chat. Returns Int on success.",
    [
      %{
        description:
          "Unique identifier for the target chat or username of the target supergroup or channel (in the format @channelusername)",
        name: :chat_id,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      }
    ],
    :integer
  )

  defmethod(
    "getChatMember",
    "Use this method to get information about a member of a chat. The method is only guaranteed to work for other users if the bot is an administrator in the chat. Returns a ChatMember object on success.",
    [
      %{
        description:
          "Unique identifier for the target chat or username of the target supergroup or channel (in the format @channelusername)",
        name: :chat_id,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      },
      %{
        description: "Unique identifier of the target user",
        name: :user_id,
        required: true,
        type: :integer
      }
    ],
    Telegex.Type.ChatMember
  )

  defmethod(
    "setChatStickerSet",
    "Use this method to set a new group sticker set for a supergroup. The bot must be an administrator in the chat for this to work and must have the appropriate administrator rights. Use the field can_set_sticker_set optionally returned in getChat requests to check if the bot can use this method. Returns True on success.",
    [
      %{
        description:
          "Unique identifier for the target chat or username of the target supergroup (in the format @supergroupusername)",
        name: :chat_id,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      },
      %{
        description: "Name of the sticker set to be set as the group sticker set",
        name: :sticker_set_name,
        required: true,
        type: :string
      }
    ],
    :boolean
  )

  defmethod(
    "deleteChatStickerSet",
    "Use this method to delete a group sticker set from a supergroup. The bot must be an administrator in the chat for this to work and must have the appropriate administrator rights. Use the field can_set_sticker_set optionally returned in getChat requests to check if the bot can use this method. Returns True on success.",
    [
      %{
        description:
          "Unique identifier for the target chat or username of the target supergroup (in the format @supergroupusername)",
        name: :chat_id,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      }
    ],
    :boolean
  )

  defmethod(
    "getForumTopicIconStickers",
    "Use this method to get custom emoji stickers, which can be used as a forum topic icon by any user. Requires no parameters. Returns an Array of Sticker objects.",
    [],
    %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.Sticker}
  )

  defmethod(
    "createForumTopic",
    "Use this method to create a topic in a forum supergroup chat. The bot must be an administrator in the chat for this to work and must have the can_manage_topics administrator rights. Returns information about the created topic as a ForumTopic object.",
    [
      %{
        description:
          "Unique identifier for the target chat or username of the target supergroup (in the format @supergroupusername)",
        name: :chat_id,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      },
      %{description: "Topic name, 1-128 characters", name: :name, required: true, type: :string},
      %{
        description:
          "Color of the topic icon in RGB format. Currently, must be one of 7322096 (0x6FB9F0), 16766590 (0xFFD67E), 13338331 (0xCB86DB), 9367192 (0x8EEE98), 16749490 (0xFF93B2), or 16478047 (0xFB6F5F)",
        name: :icon_color,
        required: false,
        type: :integer
      },
      %{
        description:
          "Unique identifier of the custom emoji shown as the topic icon. Use getForumTopicIconStickers to get all allowed custom emoji identifiers.",
        name: :icon_custom_emoji_id,
        required: false,
        type: :string
      }
    ],
    Telegex.Type.ForumTopic
  )

  defmethod(
    "editForumTopic",
    "Use this method to edit name and icon of a topic in a forum supergroup chat. The bot must be an administrator in the chat for this to work and must have the can_manage_topics administrator rights, unless it is the creator of the topic. Returns True on success.",
    [
      %{
        description:
          "Unique identifier for the target chat or username of the target supergroup (in the format @supergroupusername)",
        name: :chat_id,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      },
      %{
        description: "Unique identifier for the target message thread of the forum topic",
        name: :message_thread_id,
        required: true,
        type: :integer
      },
      %{
        description:
          "New topic name, 0-128 characters. If not specified or empty, the current name of the topic will be kept",
        name: :name,
        required: false,
        type: :string
      },
      %{
        description:
          "New unique identifier of the custom emoji shown as the topic icon. Use getForumTopicIconStickers to get all allowed custom emoji identifiers. Pass an empty string to remove the icon. If not specified, the current icon will be kept",
        name: :icon_custom_emoji_id,
        required: false,
        type: :string
      }
    ],
    :boolean
  )

  defmethod(
    "closeForumTopic",
    "Use this method to close an open topic in a forum supergroup chat. The bot must be an administrator in the chat for this to work and must have the can_manage_topics administrator rights, unless it is the creator of the topic. Returns True on success.",
    [
      %{
        description:
          "Unique identifier for the target chat or username of the target supergroup (in the format @supergroupusername)",
        name: :chat_id,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      },
      %{
        description: "Unique identifier for the target message thread of the forum topic",
        name: :message_thread_id,
        required: true,
        type: :integer
      }
    ],
    :boolean
  )

  defmethod(
    "reopenForumTopic",
    "Use this method to reopen a closed topic in a forum supergroup chat. The bot must be an administrator in the chat for this to work and must have the can_manage_topics administrator rights, unless it is the creator of the topic. Returns True on success.",
    [
      %{
        description:
          "Unique identifier for the target chat or username of the target supergroup (in the format @supergroupusername)",
        name: :chat_id,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      },
      %{
        description: "Unique identifier for the target message thread of the forum topic",
        name: :message_thread_id,
        required: true,
        type: :integer
      }
    ],
    :boolean
  )

  defmethod(
    "deleteForumTopic",
    "Use this method to delete a forum topic along with all its messages in a forum supergroup chat. The bot must be an administrator in the chat for this to work and must have the can_delete_messages administrator rights. Returns True on success.",
    [
      %{
        description:
          "Unique identifier for the target chat or username of the target supergroup (in the format @supergroupusername)",
        name: :chat_id,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      },
      %{
        description: "Unique identifier for the target message thread of the forum topic",
        name: :message_thread_id,
        required: true,
        type: :integer
      }
    ],
    :boolean
  )

  defmethod(
    "unpinAllForumTopicMessages",
    "Use this method to clear the list of pinned messages in a forum topic. The bot must be an administrator in the chat for this to work and must have the can_pin_messages administrator right in the supergroup. Returns True on success.",
    [
      %{
        description:
          "Unique identifier for the target chat or username of the target supergroup (in the format @supergroupusername)",
        name: :chat_id,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      },
      %{
        description: "Unique identifier for the target message thread of the forum topic",
        name: :message_thread_id,
        required: true,
        type: :integer
      }
    ],
    :boolean
  )

  defmethod(
    "editGeneralForumTopic",
    "Use this method to edit the name of the 'General' topic in a forum supergroup chat. The bot must be an administrator in the chat for this to work and must have the can_manage_topics administrator rights. Returns True on success.",
    [
      %{
        description:
          "Unique identifier for the target chat or username of the target supergroup (in the format @supergroupusername)",
        name: :chat_id,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      },
      %{
        description: "New topic name, 1-128 characters",
        name: :name,
        required: true,
        type: :string
      }
    ],
    :boolean
  )

  defmethod(
    "closeGeneralForumTopic",
    "Use this method to close an open 'General' topic in a forum supergroup chat. The bot must be an administrator in the chat for this to work and must have the can_manage_topics administrator rights. Returns True on success.",
    [
      %{
        description:
          "Unique identifier for the target chat or username of the target supergroup (in the format @supergroupusername)",
        name: :chat_id,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      }
    ],
    :boolean
  )

  defmethod(
    "reopenGeneralForumTopic",
    "Use this method to reopen a closed 'General' topic in a forum supergroup chat. The bot must be an administrator in the chat for this to work and must have the can_manage_topics administrator rights. The topic will be automatically unhidden if it was hidden. Returns True on success.",
    [
      %{
        description:
          "Unique identifier for the target chat or username of the target supergroup (in the format @supergroupusername)",
        name: :chat_id,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      }
    ],
    :boolean
  )

  defmethod(
    "hideGeneralForumTopic",
    "Use this method to hide the 'General' topic in a forum supergroup chat. The bot must be an administrator in the chat for this to work and must have the can_manage_topics administrator rights. The topic will be automatically closed if it was open. Returns True on success.",
    [
      %{
        description:
          "Unique identifier for the target chat or username of the target supergroup (in the format @supergroupusername)",
        name: :chat_id,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      }
    ],
    :boolean
  )

  defmethod(
    "unhideGeneralForumTopic",
    "Use this method to unhide the 'General' topic in a forum supergroup chat. The bot must be an administrator in the chat for this to work and must have the can_manage_topics administrator rights. Returns True on success.",
    [
      %{
        description:
          "Unique identifier for the target chat or username of the target supergroup (in the format @supergroupusername)",
        name: :chat_id,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      }
    ],
    :boolean
  )

  defmethod(
    "unpinAllGeneralForumTopicMessages",
    "Use this method to clear the list of pinned messages in a General forum topic. The bot must be an administrator in the chat for this to work and must have the can_pin_messages administrator right in the supergroup. Returns True on success.",
    [
      %{
        description:
          "Unique identifier for the target chat or username of the target supergroup (in the format @supergroupusername)",
        name: :chat_id,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      }
    ],
    :boolean
  )

  defmethod(
    "answerCallbackQuery",
    "Use this method to send answers to callback queries sent from inline keyboards. The answer will be displayed to the user as a notification at the top of the chat screen or as an alert. On success, True is returned.",
    [
      %{
        description: "Unique identifier for the query to be answered",
        name: :callback_query_id,
        required: true,
        type: :string
      },
      %{
        description:
          "Text of the notification. If not specified, nothing will be shown to the user, 0-200 characters",
        name: :text,
        required: false,
        type: :string
      },
      %{
        description:
          "If True, an alert will be shown by the client instead of a notification at the top of the chat screen. Defaults to false.",
        name: :show_alert,
        required: false,
        type: :boolean
      },
      %{
        description:
          "URL that will be opened by the user's client. If you have created a Game and accepted the conditions via @BotFather, specify the URL that opens your game - note that this will only work if the query comes from a callback_game button.\n\nOtherwise, you may use links like t.me/your_bot?start=XXXX that open your bot with a parameter.",
        name: :url,
        required: false,
        type: :string
      },
      %{
        description:
          "The maximum amount of time in seconds that the result of the callback query may be cached client-side. Telegram apps will support caching starting in version 3.14. Defaults to 0.",
        name: :cache_time,
        required: false,
        type: :integer
      }
    ],
    :boolean
  )

  defmethod(
    "getUserChatBoosts",
    "Use this method to get the list of boosts added to a chat by a user. Requires administrator rights in the chat. Returns a UserChatBoosts object.",
    [
      %{
        description:
          "Unique identifier for the chat or username of the channel (in the format @channelusername)",
        name: :chat_id,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      },
      %{
        description: "Unique identifier of the target user",
        name: :user_id,
        required: true,
        type: :integer
      }
    ],
    Telegex.Type.UserChatBoosts
  )

  defmethod(
    "getBusinessConnection",
    "Use this method to get information about the connection of the bot with a business account. Returns a BusinessConnection object on success.",
    [
      %{
        description: "Unique identifier of the business connection",
        name: :business_connection_id,
        required: true,
        type: :string
      }
    ],
    Telegex.Type.BusinessConnection
  )

  defmethod(
    "setMyCommands",
    "Use this method to change the list of the bot's commands. See this manual for more details about bot commands. Returns True on success.",
    [
      %{
        description:
          "A JSON-serialized list of bot commands to be set as the list of the bot's commands. At most 100 commands can be specified.",
        name: :commands,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.BotCommand}
      },
      %{
        description:
          "A JSON-serialized object, describing scope of users for which the commands are relevant. Defaults to BotCommandScopeDefault.",
        name: :scope,
        required: false,
        type: Telegex.Type.BotCommandScope
      },
      %{
        description:
          "A two-letter ISO 639-1 language code. If empty, commands will be applied to all users from the given scope, for whose language there are no dedicated commands",
        name: :language_code,
        required: false,
        type: :string
      }
    ],
    :boolean
  )

  defmethod(
    "deleteMyCommands",
    "Use this method to delete the list of the bot's commands for the given scope and user language. After deletion, higher level commands will be shown to affected users. Returns True on success.",
    [
      %{
        description:
          "A JSON-serialized object, describing scope of users for which the commands are relevant. Defaults to BotCommandScopeDefault.",
        name: :scope,
        required: false,
        type: Telegex.Type.BotCommandScope
      },
      %{
        description:
          "A two-letter ISO 639-1 language code. If empty, commands will be applied to all users from the given scope, for whose language there are no dedicated commands",
        name: :language_code,
        required: false,
        type: :string
      }
    ],
    :boolean
  )

  defmethod(
    "getMyCommands",
    "Use this method to get the current list of the bot's commands for the given scope and user language. Returns an Array of BotCommand objects. If commands aren't set, an empty list is returned.",
    [
      %{
        description:
          "A JSON-serialized object, describing scope of users. Defaults to BotCommandScopeDefault.",
        name: :scope,
        required: false,
        type: Telegex.Type.BotCommandScope
      },
      %{
        description: "A two-letter ISO 639-1 language code or an empty string",
        name: :language_code,
        required: false,
        type: :string
      }
    ],
    %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.BotCommand}
  )

  defmethod(
    "setMyName",
    "Use this method to change the bot's name. Returns True on success.",
    [
      %{
        description:
          "New bot name; 0-64 characters. Pass an empty string to remove the dedicated name for the given language.",
        name: :name,
        required: false,
        type: :string
      },
      %{
        description:
          "A two-letter ISO 639-1 language code. If empty, the name will be shown to all users for whose language there is no dedicated name.",
        name: :language_code,
        required: false,
        type: :string
      }
    ],
    :boolean
  )

  defmethod(
    "getMyName",
    "Use this method to get the current bot name for the given user language. Returns BotName on success.",
    [
      %{
        description: "A two-letter ISO 639-1 language code or an empty string",
        name: :language_code,
        required: false,
        type: :string
      }
    ],
    Telegex.Type.BotName
  )

  defmethod(
    "setMyDescription",
    "Use this method to change the bot's description, which is shown in the chat with the bot if the chat is empty. Returns True on success.",
    [
      %{
        description:
          "New bot description; 0-512 characters. Pass an empty string to remove the dedicated description for the given language.",
        name: :description,
        required: false,
        type: :string
      },
      %{
        description:
          "A two-letter ISO 639-1 language code. If empty, the description will be applied to all users for whose language there is no dedicated description.",
        name: :language_code,
        required: false,
        type: :string
      }
    ],
    :boolean
  )

  defmethod(
    "getMyDescription",
    "Use this method to get the current bot description for the given user language. Returns BotDescription on success.",
    [
      %{
        description: "A two-letter ISO 639-1 language code or an empty string",
        name: :language_code,
        required: false,
        type: :string
      }
    ],
    Telegex.Type.BotDescription
  )

  defmethod(
    "setMyShortDescription",
    "Use this method to change the bot's short description, which is shown on the bot's profile page and is sent together with the link when users share the bot. Returns True on success.",
    [
      %{
        description:
          "New short description for the bot; 0-120 characters. Pass an empty string to remove the dedicated short description for the given language.",
        name: :short_description,
        required: false,
        type: :string
      },
      %{
        description:
          "A two-letter ISO 639-1 language code. If empty, the short description will be applied to all users for whose language there is no dedicated short description.",
        name: :language_code,
        required: false,
        type: :string
      }
    ],
    :boolean
  )

  defmethod(
    "getMyShortDescription",
    "Use this method to get the current bot short description for the given user language. Returns BotShortDescription on success.",
    [
      %{
        description: "A two-letter ISO 639-1 language code or an empty string",
        name: :language_code,
        required: false,
        type: :string
      }
    ],
    Telegex.Type.BotShortDescription
  )

  defmethod(
    "setChatMenuButton",
    "Use this method to change the bot's menu button in a private chat, or the default menu button. Returns True on success.",
    [
      %{
        description:
          "Unique identifier for the target private chat. If not specified, default bot's menu button will be changed",
        name: :chat_id,
        required: false,
        type: :integer
      },
      %{
        description:
          "A JSON-serialized object for the bot's new menu button. Defaults to MenuButtonDefault",
        name: :menu_button,
        required: false,
        type: Telegex.Type.MenuButton
      }
    ],
    :boolean
  )

  defmethod(
    "getChatMenuButton",
    "Use this method to get the current value of the bot's menu button in a private chat, or the default menu button. Returns MenuButton on success.",
    [
      %{
        description:
          "Unique identifier for the target private chat. If not specified, default bot's menu button will be returned",
        name: :chat_id,
        required: false,
        type: :integer
      }
    ],
    Telegex.Type.MenuButton
  )

  defmethod(
    "setMyDefaultAdministratorRights",
    "Use this method to change the default administrator rights requested by the bot when it's added as an administrator to groups or channels. These rights will be suggested to users, but they are free to modify the list before adding the bot. Returns True on success.",
    [
      %{
        description:
          "A JSON-serialized object describing new default administrator rights. If not specified, the default administrator rights will be cleared.",
        name: :rights,
        required: false,
        type: Telegex.Type.ChatAdministratorRights
      },
      %{
        description:
          "Pass True to change the default administrator rights of the bot in channels. Otherwise, the default administrator rights of the bot for groups and supergroups will be changed.",
        name: :for_channels,
        required: false,
        type: :boolean
      }
    ],
    :boolean
  )

  defmethod(
    "getMyDefaultAdministratorRights",
    "Use this method to get the current default administrator rights of the bot. Returns ChatAdministratorRights on success.",
    [
      %{
        description:
          "Pass True to get default administrator rights of the bot in channels. Otherwise, default administrator rights of the bot for groups and supergroups will be returned.",
        name: :for_channels,
        required: false,
        type: :boolean
      }
    ],
    Telegex.Type.ChatAdministratorRights
  )

  defmethod(
    "editMessageText",
    "Use this method to edit text and game messages. On success, if the edited message is not an inline message, the edited Message is returned, otherwise True is returned. Note that business messages that were not sent by the bot and do not contain an inline keyboard can only be edited within 48 hours from the time they were sent.",
    [
      %{
        description:
          "Unique identifier of the business connection on behalf of which the message to be edited was sent",
        name: :business_connection_id,
        required: false,
        type: :string
      },
      %{
        description:
          "Required if inline_message_id is not specified. Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        name: :chat_id,
        required: false,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      },
      %{
        description:
          "Required if inline_message_id is not specified. Identifier of the message to edit",
        name: :message_id,
        required: false,
        type: :integer
      },
      %{
        description:
          "Required if chat_id and message_id are not specified. Identifier of the inline message",
        name: :inline_message_id,
        required: false,
        type: :string
      },
      %{
        description: "New text of the message, 1-4096 characters after entities parsing",
        name: :text,
        required: true,
        type: :string
      },
      %{
        description:
          "Mode for parsing entities in the message text. See formatting options for more details.",
        name: :parse_mode,
        required: false,
        type: :string
      },
      %{
        description:
          "A JSON-serialized list of special entities that appear in message text, which can be specified instead of parse_mode",
        name: :entities,
        required: false,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity}
      },
      %{
        description: "Link preview generation options for the message",
        name: :link_preview_options,
        required: false,
        type: Telegex.Type.LinkPreviewOptions
      },
      %{
        description: "A JSON-serialized object for an inline keyboard.",
        name: :reply_markup,
        required: false,
        type: Telegex.Type.InlineKeyboardMarkup
      }
    ],
    %{__struct__: Telegex.TypeDefiner.UnionType, types: [Telegex.Type.Message, :boolean]}
  )

  defmethod(
    "editMessageCaption",
    "Use this method to edit captions of messages. On success, if the edited message is not an inline message, the edited Message is returned, otherwise True is returned. Note that business messages that were not sent by the bot and do not contain an inline keyboard can only be edited within 48 hours from the time they were sent.",
    [
      %{
        description:
          "Unique identifier of the business connection on behalf of which the message to be edited was sent",
        name: :business_connection_id,
        required: false,
        type: :string
      },
      %{
        description:
          "Required if inline_message_id is not specified. Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        name: :chat_id,
        required: false,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      },
      %{
        description:
          "Required if inline_message_id is not specified. Identifier of the message to edit",
        name: :message_id,
        required: false,
        type: :integer
      },
      %{
        description:
          "Required if chat_id and message_id are not specified. Identifier of the inline message",
        name: :inline_message_id,
        required: false,
        type: :string
      },
      %{
        description: "New caption of the message, 0-1024 characters after entities parsing",
        name: :caption,
        required: false,
        type: :string
      },
      %{
        description:
          "Mode for parsing entities in the message caption. See formatting options for more details.",
        name: :parse_mode,
        required: false,
        type: :string
      },
      %{
        description:
          "A JSON-serialized list of special entities that appear in the caption, which can be specified instead of parse_mode",
        name: :caption_entities,
        required: false,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity}
      },
      %{
        description:
          "Pass True, if the caption must be shown above the message media. Supported only for animation, photo and video messages.",
        name: :show_caption_above_media,
        required: false,
        type: :boolean
      },
      %{
        description: "A JSON-serialized object for an inline keyboard.",
        name: :reply_markup,
        required: false,
        type: Telegex.Type.InlineKeyboardMarkup
      }
    ],
    %{__struct__: Telegex.TypeDefiner.UnionType, types: [Telegex.Type.Message, :boolean]}
  )

  defmethod(
    "editMessageMedia",
    "Use this method to edit animation, audio, document, photo, or video messages, or to add media to text messages. If a message is part of a message album, then it can be edited only to an audio for audio albums, only to a document for document albums and to a photo or a video otherwise. When an inline message is edited, a new file can't be uploaded; use a previously uploaded file via its file_id or specify a URL. On success, if the edited message is not an inline message, the edited Message is returned, otherwise True is returned. Note that business messages that were not sent by the bot and do not contain an inline keyboard can only be edited within 48 hours from the time they were sent.",
    [
      %{
        description:
          "Unique identifier of the business connection on behalf of which the message to be edited was sent",
        name: :business_connection_id,
        required: false,
        type: :string
      },
      %{
        description:
          "Required if inline_message_id is not specified. Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        name: :chat_id,
        required: false,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      },
      %{
        description:
          "Required if inline_message_id is not specified. Identifier of the message to edit",
        name: :message_id,
        required: false,
        type: :integer
      },
      %{
        description:
          "Required if chat_id and message_id are not specified. Identifier of the inline message",
        name: :inline_message_id,
        required: false,
        type: :string
      },
      %{
        description: "A JSON-serialized object for a new media content of the message",
        name: :media,
        required: true,
        type: Telegex.Type.InputMedia
      },
      %{
        description: "A JSON-serialized object for a new inline keyboard.",
        name: :reply_markup,
        required: false,
        type: Telegex.Type.InlineKeyboardMarkup
      }
    ],
    %{__struct__: Telegex.TypeDefiner.UnionType, types: [Telegex.Type.Message, :boolean]}
  )

  defmethod(
    "editMessageLiveLocation",
    "Use this method to edit live location messages. A location can be edited until its live_period expires or editing is explicitly disabled by a call to stopMessageLiveLocation. On success, if the edited message is not an inline message, the edited Message is returned, otherwise True is returned.",
    [
      %{
        description:
          "Unique identifier of the business connection on behalf of which the message to be edited was sent",
        name: :business_connection_id,
        required: false,
        type: :string
      },
      %{
        description:
          "Required if inline_message_id is not specified. Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        name: :chat_id,
        required: false,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      },
      %{
        description:
          "Required if inline_message_id is not specified. Identifier of the message to edit",
        name: :message_id,
        required: false,
        type: :integer
      },
      %{
        description:
          "Required if chat_id and message_id are not specified. Identifier of the inline message",
        name: :inline_message_id,
        required: false,
        type: :string
      },
      %{description: "Latitude of new location", name: :latitude, required: true, type: :float},
      %{description: "Longitude of new location", name: :longitude, required: true, type: :float},
      %{
        description:
          "New period in seconds during which the location can be updated, starting from the message send date. If 0x7FFFFFFF is specified, then the location can be updated forever. Otherwise, the new value must not exceed the current live_period by more than a day, and the live location expiration date must remain within the next 90 days. If not specified, then live_period remains unchanged",
        name: :live_period,
        required: false,
        type: :integer
      },
      %{
        description: "The radius of uncertainty for the location, measured in meters; 0-1500",
        name: :horizontal_accuracy,
        required: false,
        type: :float
      },
      %{
        description:
          "Direction in which the user is moving, in degrees. Must be between 1 and 360 if specified.",
        name: :heading,
        required: false,
        type: :integer
      },
      %{
        description:
          "The maximum distance for proximity alerts about approaching another chat member, in meters. Must be between 1 and 100000 if specified.",
        name: :proximity_alert_radius,
        required: false,
        type: :integer
      },
      %{
        description: "A JSON-serialized object for a new inline keyboard.",
        name: :reply_markup,
        required: false,
        type: Telegex.Type.InlineKeyboardMarkup
      }
    ],
    %{__struct__: Telegex.TypeDefiner.UnionType, types: [Telegex.Type.Message, :boolean]}
  )

  defmethod(
    "stopMessageLiveLocation",
    "Use this method to stop updating a live location message before live_period expires. On success, if the message is not an inline message, the edited Message is returned, otherwise True is returned.",
    [
      %{
        description:
          "Unique identifier of the business connection on behalf of which the message to be edited was sent",
        name: :business_connection_id,
        required: false,
        type: :string
      },
      %{
        description:
          "Required if inline_message_id is not specified. Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        name: :chat_id,
        required: false,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      },
      %{
        description:
          "Required if inline_message_id is not specified. Identifier of the message with live location to stop",
        name: :message_id,
        required: false,
        type: :integer
      },
      %{
        description:
          "Required if chat_id and message_id are not specified. Identifier of the inline message",
        name: :inline_message_id,
        required: false,
        type: :string
      },
      %{
        description: "A JSON-serialized object for a new inline keyboard.",
        name: :reply_markup,
        required: false,
        type: Telegex.Type.InlineKeyboardMarkup
      }
    ],
    %{__struct__: Telegex.TypeDefiner.UnionType, types: [Telegex.Type.Message, :boolean]}
  )

  defmethod(
    "editMessageReplyMarkup",
    "Use this method to edit only the reply markup of messages. On success, if the edited message is not an inline message, the edited Message is returned, otherwise True is returned. Note that business messages that were not sent by the bot and do not contain an inline keyboard can only be edited within 48 hours from the time they were sent.",
    [
      %{
        description:
          "Unique identifier of the business connection on behalf of which the message to be edited was sent",
        name: :business_connection_id,
        required: false,
        type: :string
      },
      %{
        description:
          "Required if inline_message_id is not specified. Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        name: :chat_id,
        required: false,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      },
      %{
        description:
          "Required if inline_message_id is not specified. Identifier of the message to edit",
        name: :message_id,
        required: false,
        type: :integer
      },
      %{
        description:
          "Required if chat_id and message_id are not specified. Identifier of the inline message",
        name: :inline_message_id,
        required: false,
        type: :string
      },
      %{
        description: "A JSON-serialized object for an inline keyboard.",
        name: :reply_markup,
        required: false,
        type: Telegex.Type.InlineKeyboardMarkup
      }
    ],
    %{__struct__: Telegex.TypeDefiner.UnionType, types: [Telegex.Type.Message, :boolean]}
  )

  defmethod(
    "stopPoll",
    "Use this method to stop a poll which was sent by the bot. On success, the stopped Poll is returned.",
    [
      %{
        description:
          "Unique identifier of the business connection on behalf of which the message to be edited was sent",
        name: :business_connection_id,
        required: false,
        type: :string
      },
      %{
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        name: :chat_id,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      },
      %{
        description: "Identifier of the original message with the poll",
        name: :message_id,
        required: true,
        type: :integer
      },
      %{
        description: "A JSON-serialized object for a new message inline keyboard.",
        name: :reply_markup,
        required: false,
        type: Telegex.Type.InlineKeyboardMarkup
      }
    ],
    Telegex.Type.Poll
  )

  defmethod(
    "deleteMessage",
    "Use this method to delete a message, including service messages, with the following limitations:
- A message can only be deleted if it was sent less than 48 hours ago.
- Service messages about a supergroup, channel, or forum topic creation can't be deleted.
- A dice message in a private chat can only be deleted if it was sent more than 24 hours ago.
- Bots can delete outgoing messages in private chats, groups, and supergroups.
- Bots can delete incoming messages in private chats.
- Bots granted can_post_messages permissions can delete outgoing messages in channels.
- If the bot is an administrator of a group, it can delete any message there.
- If the bot has can_delete_messages permission in a supergroup or a channel, it can delete any message there.
Returns True on success.",
    [
      %{
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        name: :chat_id,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      },
      %{
        description: "Identifier of the message to delete",
        name: :message_id,
        required: true,
        type: :integer
      }
    ],
    :boolean
  )

  defmethod(
    "deleteMessages",
    "Use this method to delete multiple messages simultaneously. If some of the specified messages can't be found, they are skipped. Returns True on success.",
    [
      %{
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        name: :chat_id,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      },
      %{
        description:
          "A JSON-serialized list of 1-100 identifiers of messages to delete. See deleteMessage for limitations on which messages can be deleted",
        name: :message_ids,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: :integer}
      }
    ],
    :boolean
  )

  defmethod(
    "sendSticker",
    "Use this method to send static .WEBP, animated .TGS, or video .WEBM stickers. On success, the sent Message is returned.",
    [
      %{
        description:
          "Unique identifier of the business connection on behalf of which the message will be sent",
        name: :business_connection_id,
        required: false,
        type: :string
      },
      %{
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        name: :chat_id,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      },
      %{
        description:
          "Unique identifier for the target message thread (topic) of the forum; for forum supergroups only",
        name: :message_thread_id,
        required: false,
        type: :integer
      },
      %{
        description:
          "Sticker to send. Pass a file_id as String to send a file that exists on the Telegram servers (recommended), pass an HTTP URL as a String for Telegram to get a .WEBP sticker from the Internet, or upload a new .WEBP, .TGS, or .WEBM sticker using multipart/form-data. More information on Sending Files ». Video and animated stickers can't be sent via an HTTP URL.",
        name: :sticker,
        required: true,
        type: %{
          __struct__: Telegex.TypeDefiner.UnionType,
          types: [Telegex.Type.InputFile, :string]
        }
      },
      %{
        description: "Emoji associated with the sticker; only for just uploaded stickers",
        name: :emoji,
        required: false,
        type: :string
      },
      %{
        description:
          "Sends the message silently. Users will receive a notification with no sound.",
        name: :disable_notification,
        required: false,
        type: :boolean
      },
      %{
        description: "Protects the contents of the sent message from forwarding and saving",
        name: :protect_content,
        required: false,
        type: :boolean
      },
      %{
        description:
          "Pass True to allow up to 1000 messages per second, ignoring broadcasting limits for a fee of 0.1 Telegram Stars per message. The relevant Stars will be withdrawn from the bot's balance",
        name: :allow_paid_broadcast,
        required: false,
        type: :boolean
      },
      %{
        description:
          "Unique identifier of the message effect to be added to the message; for private chats only",
        name: :message_effect_id,
        required: false,
        type: :string
      },
      %{
        description: "Description of the message to reply to",
        name: :reply_parameters,
        required: false,
        type: Telegex.Type.ReplyParameters
      },
      %{
        description:
          "Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove a reply keyboard or to force a reply from the user",
        name: :reply_markup,
        required: false,
        type: %{
          __struct__: Telegex.TypeDefiner.UnionType,
          types: [
            Telegex.Type.InlineKeyboardMarkup,
            Telegex.Type.ReplyKeyboardMarkup,
            Telegex.Type.ReplyKeyboardRemove,
            Telegex.Type.ForceReply
          ]
        }
      }
    ],
    Telegex.Type.Message
  )

  defmethod(
    "getStickerSet",
    "Use this method to get a sticker set. On success, a StickerSet object is returned.",
    [%{description: "Name of the sticker set", name: :name, required: true, type: :string}],
    Telegex.Type.StickerSet
  )

  defmethod(
    "getCustomEmojiStickers",
    "Use this method to get information about custom emoji stickers by their identifiers. Returns an Array of Sticker objects.",
    [
      %{
        description:
          "A JSON-serialized list of custom emoji identifiers. At most 200 custom emoji identifiers can be specified.",
        name: :custom_emoji_ids,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: :string}
      }
    ],
    %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.Sticker}
  )

  defmethod(
    "uploadStickerFile",
    "Use this method to upload a file with a sticker for later use in the createNewStickerSet, addStickerToSet, or replaceStickerInSet methods (the file can be used multiple times). Returns the uploaded File on success.",
    [
      %{
        description: "User identifier of sticker file owner",
        name: :user_id,
        required: true,
        type: :integer
      },
      %{
        description:
          "A file with the sticker in .WEBP, .PNG, .TGS, or .WEBM format. See https://core.telegram.org/stickers for technical requirements. More information on Sending Files »",
        name: :sticker,
        required: true,
        type: Telegex.Type.InputFile
      },
      %{
        description: "Format of the sticker, must be one of “static”, “animated”, “video”",
        name: :sticker_format,
        required: true,
        type: :string
      }
    ],
    Telegex.Type.File
  )

  defmethod(
    "createNewStickerSet",
    "Use this method to create a new sticker set owned by a user. The bot will be able to edit the sticker set thus created. Returns True on success.",
    [
      %{
        description: "User identifier of created sticker set owner",
        name: :user_id,
        required: true,
        type: :integer
      },
      %{
        description:
          "Short name of sticker set, to be used in t.me/addstickers/ URLs (e.g., animals). Can contain only English letters, digits and underscores. Must begin with a letter, can't contain consecutive underscores and must end in \"_by_<bot_username>\". <bot_username> is case insensitive. 1-64 characters.",
        name: :name,
        required: true,
        type: :string
      },
      %{
        description: "Sticker set title, 1-64 characters",
        name: :title,
        required: true,
        type: :string
      },
      %{
        description:
          "A JSON-serialized list of 1-50 initial stickers to be added to the sticker set",
        name: :stickers,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.InputSticker}
      },
      %{
        description:
          "Type of stickers in the set, pass “regular”, “mask”, or “custom_emoji”. By default, a regular sticker set is created.",
        name: :sticker_type,
        required: false,
        type: :string
      },
      %{
        description:
          "Pass True if stickers in the sticker set must be repainted to the color of text when used in messages, the accent color if used as emoji status, white on chat photos, or another appropriate color based on context; for custom emoji sticker sets only",
        name: :needs_repainting,
        required: false,
        type: :boolean
      }
    ],
    :boolean
  )

  defmethod(
    "addStickerToSet",
    "Use this method to add a new sticker to a set created by the bot. Emoji sticker sets can have up to 200 stickers. Other sticker sets can have up to 120 stickers. Returns True on success.",
    [
      %{
        description: "User identifier of sticker set owner",
        name: :user_id,
        required: true,
        type: :integer
      },
      %{description: "Sticker set name", name: :name, required: true, type: :string},
      %{
        description:
          "A JSON-serialized object with information about the added sticker. If exactly the same sticker had already been added to the set, then the set isn't changed.",
        name: :sticker,
        required: true,
        type: Telegex.Type.InputSticker
      }
    ],
    :boolean
  )

  defmethod(
    "setStickerPositionInSet",
    "Use this method to move a sticker in a set created by the bot to a specific position. Returns True on success.",
    [
      %{
        description: "File identifier of the sticker",
        name: :sticker,
        required: true,
        type: :string
      },
      %{
        description: "New sticker position in the set, zero-based",
        name: :position,
        required: true,
        type: :integer
      }
    ],
    :boolean
  )

  defmethod(
    "deleteStickerFromSet",
    "Use this method to delete a sticker from a set created by the bot. Returns True on success.",
    [
      %{
        description: "File identifier of the sticker",
        name: :sticker,
        required: true,
        type: :string
      }
    ],
    :boolean
  )

  defmethod(
    "replaceStickerInSet",
    "Use this method to replace an existing sticker in a sticker set with a new one. The method is equivalent to calling deleteStickerFromSet, then addStickerToSet, then setStickerPositionInSet. Returns True on success.",
    [
      %{
        description: "User identifier of the sticker set owner",
        name: :user_id,
        required: true,
        type: :integer
      },
      %{description: "Sticker set name", name: :name, required: true, type: :string},
      %{
        description: "File identifier of the replaced sticker",
        name: :old_sticker,
        required: true,
        type: :string
      },
      %{
        description:
          "A JSON-serialized object with information about the added sticker. If exactly the same sticker had already been added to the set, then the set remains unchanged.",
        name: :sticker,
        required: true,
        type: Telegex.Type.InputSticker
      }
    ],
    :boolean
  )

  defmethod(
    "setStickerEmojiList",
    "Use this method to change the list of emoji assigned to a regular or custom emoji sticker. The sticker must belong to a sticker set created by the bot. Returns True on success.",
    [
      %{
        description: "File identifier of the sticker",
        name: :sticker,
        required: true,
        type: :string
      },
      %{
        description: "A JSON-serialized list of 1-20 emoji associated with the sticker",
        name: :emoji_list,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: :string}
      }
    ],
    :boolean
  )

  defmethod(
    "setStickerKeywords",
    "Use this method to change search keywords assigned to a regular or custom emoji sticker. The sticker must belong to a sticker set created by the bot. Returns True on success.",
    [
      %{
        description: "File identifier of the sticker",
        name: :sticker,
        required: true,
        type: :string
      },
      %{
        description:
          "A JSON-serialized list of 0-20 search keywords for the sticker with total length of up to 64 characters",
        name: :keywords,
        required: false,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: :string}
      }
    ],
    :boolean
  )

  defmethod(
    "setStickerMaskPosition",
    "Use this method to change the mask position of a mask sticker. The sticker must belong to a sticker set that was created by the bot. Returns True on success.",
    [
      %{
        description: "File identifier of the sticker",
        name: :sticker,
        required: true,
        type: :string
      },
      %{
        description:
          "A JSON-serialized object with the position where the mask should be placed on faces. Omit the parameter to remove the mask position.",
        name: :mask_position,
        required: false,
        type: Telegex.Type.MaskPosition
      }
    ],
    :boolean
  )

  defmethod(
    "setStickerSetTitle",
    "Use this method to set the title of a created sticker set. Returns True on success.",
    [
      %{description: "Sticker set name", name: :name, required: true, type: :string},
      %{
        description: "Sticker set title, 1-64 characters",
        name: :title,
        required: true,
        type: :string
      }
    ],
    :boolean
  )

  defmethod(
    "setStickerSetThumbnail",
    "Use this method to set the thumbnail of a regular or mask sticker set. The format of the thumbnail file must match the format of the stickers in the set. Returns True on success.",
    [
      %{description: "Sticker set name", name: :name, required: true, type: :string},
      %{
        description: "User identifier of the sticker set owner",
        name: :user_id,
        required: true,
        type: :integer
      },
      %{
        description:
          "A .WEBP or .PNG image with the thumbnail, must be up to 128 kilobytes in size and have a width and height of exactly 100px, or a .TGS animation with a thumbnail up to 32 kilobytes in size (see https://core.telegram.org/stickers#animation-requirements for animated sticker technical requirements), or a WEBM video with the thumbnail up to 32 kilobytes in size; see https://core.telegram.org/stickers#video-requirements for video sticker technical requirements. Pass a file_id as a String to send a file that already exists on the Telegram servers, pass an HTTP URL as a String for Telegram to get a file from the Internet, or upload a new one using multipart/form-data. More information on Sending Files ». Animated and video sticker set thumbnails can't be uploaded via HTTP URL. If omitted, then the thumbnail is dropped and the first sticker is used as the thumbnail.",
        name: :thumbnail,
        required: false,
        type: %{
          __struct__: Telegex.TypeDefiner.UnionType,
          types: [Telegex.Type.InputFile, :string]
        }
      },
      %{
        description:
          "Format of the thumbnail, must be one of “static” for a .WEBP or .PNG image, “animated” for a .TGS animation, or “video” for a WEBM video",
        name: :format,
        required: true,
        type: :string
      }
    ],
    :boolean
  )

  defmethod(
    "setCustomEmojiStickerSetThumbnail",
    "Use this method to set the thumbnail of a custom emoji sticker set. Returns True on success.",
    [
      %{description: "Sticker set name", name: :name, required: true, type: :string},
      %{
        description:
          "Custom emoji identifier of a sticker from the sticker set; pass an empty string to drop the thumbnail and use the first sticker as the thumbnail.",
        name: :custom_emoji_id,
        required: false,
        type: :string
      }
    ],
    :boolean
  )

  defmethod(
    "deleteStickerSet",
    "Use this method to delete a sticker set that was created by the bot. Returns True on success.",
    [%{description: "Sticker set name", name: :name, required: true, type: :string}],
    :boolean
  )

  defmethod(
    "answerInlineQuery",
    "Use this method to send answers to an inline query. On success, True is returned.
No more than 50 results per query are allowed.",
    [
      %{
        description: "Unique identifier for the answered query",
        name: :inline_query_id,
        required: true,
        type: :string
      },
      %{
        description: "A JSON-serialized array of results for the inline query",
        name: :results,
        required: true,
        type: %{
          __struct__: Telegex.TypeDefiner.ArrayType,
          elem_type: Telegex.Type.InlineQueryResult
        }
      },
      %{
        description:
          "The maximum amount of time in seconds that the result of the inline query may be cached on the server. Defaults to 300.",
        name: :cache_time,
        required: false,
        type: :integer
      },
      %{
        description:
          "Pass True if results may be cached on the server side only for the user that sent the query. By default, results may be returned to any user who sends the same query.",
        name: :is_personal,
        required: false,
        type: :boolean
      },
      %{
        description:
          "Pass the offset that a client should send in the next query with the same text to receive more results. Pass an empty string if there are no more results or if you don't support pagination. Offset length can't exceed 64 bytes.",
        name: :next_offset,
        required: false,
        type: :string
      },
      %{
        description:
          "A JSON-serialized object describing a button to be shown above inline query results",
        name: :button,
        required: false,
        type: Telegex.Type.InlineQueryResultsButton
      }
    ],
    :boolean
  )

  defmethod(
    "answerWebAppQuery",
    "Use this method to set the result of an interaction with a Web App and send a corresponding message on behalf of the user to the chat from which the query originated. On success, a SentWebAppMessage object is returned.",
    [
      %{
        description: "Unique identifier for the query to be answered",
        name: :web_app_query_id,
        required: true,
        type: :string
      },
      %{
        description: "A JSON-serialized object describing the message to be sent",
        name: :result,
        required: true,
        type: Telegex.Type.InlineQueryResult
      }
    ],
    Telegex.Type.SentWebAppMessage
  )

  defmethod(
    "sendInvoice",
    "Use this method to send invoices. On success, the sent Message is returned.",
    [
      %{
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        name: :chat_id,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      },
      %{
        description:
          "Unique identifier for the target message thread (topic) of the forum; for forum supergroups only",
        name: :message_thread_id,
        required: false,
        type: :integer
      },
      %{
        description: "Product name, 1-32 characters",
        name: :title,
        required: true,
        type: :string
      },
      %{
        description: "Product description, 1-255 characters",
        name: :description,
        required: true,
        type: :string
      },
      %{
        description:
          "Bot-defined invoice payload, 1-128 bytes. This will not be displayed to the user, use it for your internal processes.",
        name: :payload,
        required: true,
        type: :string
      },
      %{
        description:
          "Payment provider token, obtained via @BotFather. Pass an empty string for payments in Telegram Stars.",
        name: :provider_token,
        required: false,
        type: :string
      },
      %{
        description:
          "Three-letter ISO 4217 currency code, see more on currencies. Pass “XTR” for payments in Telegram Stars.",
        name: :currency,
        required: true,
        type: :string
      },
      %{
        description:
          "Price breakdown, a JSON-serialized list of components (e.g. product price, tax, discount, delivery cost, delivery tax, bonus, etc.). Must contain exactly one item for payments in Telegram Stars.",
        name: :prices,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.LabeledPrice}
      },
      %{
        description:
          "The maximum accepted amount for tips in the smallest units of the currency (integer, not float/double). For example, for a maximum tip of US$ 1.45 pass max_tip_amount = 145. See the exp parameter in currencies.json, it shows the number of digits past the decimal point for each currency (2 for the majority of currencies). Defaults to 0. Not supported for payments in Telegram Stars.",
        name: :max_tip_amount,
        required: false,
        type: :integer
      },
      %{
        description:
          "A JSON-serialized array of suggested amounts of tips in the smallest units of the currency (integer, not float/double). At most 4 suggested tip amounts can be specified. The suggested tip amounts must be positive, passed in a strictly increased order and must not exceed max_tip_amount.",
        name: :suggested_tip_amounts,
        required: false,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: :integer}
      },
      %{
        description:
          "Unique deep-linking parameter. If left empty, forwarded copies of the sent message will have a Pay button, allowing multiple users to pay directly from the forwarded message, using the same invoice. If non-empty, forwarded copies of the sent message will have a URL button with a deep link to the bot (instead of a Pay button), with the value used as the start parameter",
        name: :start_parameter,
        required: false,
        type: :string
      },
      %{
        description:
          "JSON-serialized data about the invoice, which will be shared with the payment provider. A detailed description of required fields should be provided by the payment provider.",
        name: :provider_data,
        required: false,
        type: :string
      },
      %{
        description:
          "URL of the product photo for the invoice. Can be a photo of the goods or a marketing image for a service. People like it better when they see what they are paying for.",
        name: :photo_url,
        required: false,
        type: :string
      },
      %{description: "Photo size in bytes", name: :photo_size, required: false, type: :integer},
      %{description: "Photo width", name: :photo_width, required: false, type: :integer},
      %{description: "Photo height", name: :photo_height, required: false, type: :integer},
      %{
        description:
          "Pass True if you require the user's full name to complete the order. Ignored for payments in Telegram Stars.",
        name: :need_name,
        required: false,
        type: :boolean
      },
      %{
        description:
          "Pass True if you require the user's phone number to complete the order. Ignored for payments in Telegram Stars.",
        name: :need_phone_number,
        required: false,
        type: :boolean
      },
      %{
        description:
          "Pass True if you require the user's email address to complete the order. Ignored for payments in Telegram Stars.",
        name: :need_email,
        required: false,
        type: :boolean
      },
      %{
        description:
          "Pass True if you require the user's shipping address to complete the order. Ignored for payments in Telegram Stars.",
        name: :need_shipping_address,
        required: false,
        type: :boolean
      },
      %{
        description:
          "Pass True if the user's phone number should be sent to the provider. Ignored for payments in Telegram Stars.",
        name: :send_phone_number_to_provider,
        required: false,
        type: :boolean
      },
      %{
        description:
          "Pass True if the user's email address should be sent to the provider. Ignored for payments in Telegram Stars.",
        name: :send_email_to_provider,
        required: false,
        type: :boolean
      },
      %{
        description:
          "Pass True if the final price depends on the shipping method. Ignored for payments in Telegram Stars.",
        name: :is_flexible,
        required: false,
        type: :boolean
      },
      %{
        description:
          "Sends the message silently. Users will receive a notification with no sound.",
        name: :disable_notification,
        required: false,
        type: :boolean
      },
      %{
        description: "Protects the contents of the sent message from forwarding and saving",
        name: :protect_content,
        required: false,
        type: :boolean
      },
      %{
        description:
          "Pass True to allow up to 1000 messages per second, ignoring broadcasting limits for a fee of 0.1 Telegram Stars per message. The relevant Stars will be withdrawn from the bot's balance",
        name: :allow_paid_broadcast,
        required: false,
        type: :boolean
      },
      %{
        description:
          "Unique identifier of the message effect to be added to the message; for private chats only",
        name: :message_effect_id,
        required: false,
        type: :string
      },
      %{
        description: "Description of the message to reply to",
        name: :reply_parameters,
        required: false,
        type: Telegex.Type.ReplyParameters
      },
      %{
        description:
          "A JSON-serialized object for an inline keyboard. If empty, one 'Pay total price' button will be shown. If not empty, the first button must be a Pay button.",
        name: :reply_markup,
        required: false,
        type: Telegex.Type.InlineKeyboardMarkup
      }
    ],
    Telegex.Type.Message
  )

  defmethod(
    "createInvoiceLink",
    "Use this method to create a link for an invoice. Returns the created invoice link as String on success.",
    [
      %{
        description: "Product name, 1-32 characters",
        name: :title,
        required: true,
        type: :string
      },
      %{
        description: "Product description, 1-255 characters",
        name: :description,
        required: true,
        type: :string
      },
      %{
        description:
          "Bot-defined invoice payload, 1-128 bytes. This will not be displayed to the user, use it for your internal processes.",
        name: :payload,
        required: true,
        type: :string
      },
      %{
        description:
          "Payment provider token, obtained via @BotFather. Pass an empty string for payments in Telegram Stars.",
        name: :provider_token,
        required: false,
        type: :string
      },
      %{
        description:
          "Three-letter ISO 4217 currency code, see more on currencies. Pass “XTR” for payments in Telegram Stars.",
        name: :currency,
        required: true,
        type: :string
      },
      %{
        description:
          "Price breakdown, a JSON-serialized list of components (e.g. product price, tax, discount, delivery cost, delivery tax, bonus, etc.). Must contain exactly one item for payments in Telegram Stars.",
        name: :prices,
        required: true,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.LabeledPrice}
      },
      %{
        description:
          "The maximum accepted amount for tips in the smallest units of the currency (integer, not float/double). For example, for a maximum tip of US$ 1.45 pass max_tip_amount = 145. See the exp parameter in currencies.json, it shows the number of digits past the decimal point for each currency (2 for the majority of currencies). Defaults to 0. Not supported for payments in Telegram Stars.",
        name: :max_tip_amount,
        required: false,
        type: :integer
      },
      %{
        description:
          "A JSON-serialized array of suggested amounts of tips in the smallest units of the currency (integer, not float/double). At most 4 suggested tip amounts can be specified. The suggested tip amounts must be positive, passed in a strictly increased order and must not exceed max_tip_amount.",
        name: :suggested_tip_amounts,
        required: false,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: :integer}
      },
      %{
        description:
          "JSON-serialized data about the invoice, which will be shared with the payment provider. A detailed description of required fields should be provided by the payment provider.",
        name: :provider_data,
        required: false,
        type: :string
      },
      %{
        description:
          "URL of the product photo for the invoice. Can be a photo of the goods or a marketing image for a service.",
        name: :photo_url,
        required: false,
        type: :string
      },
      %{description: "Photo size in bytes", name: :photo_size, required: false, type: :integer},
      %{description: "Photo width", name: :photo_width, required: false, type: :integer},
      %{description: "Photo height", name: :photo_height, required: false, type: :integer},
      %{
        description:
          "Pass True if you require the user's full name to complete the order. Ignored for payments in Telegram Stars.",
        name: :need_name,
        required: false,
        type: :boolean
      },
      %{
        description:
          "Pass True if you require the user's phone number to complete the order. Ignored for payments in Telegram Stars.",
        name: :need_phone_number,
        required: false,
        type: :boolean
      },
      %{
        description:
          "Pass True if you require the user's email address to complete the order. Ignored for payments in Telegram Stars.",
        name: :need_email,
        required: false,
        type: :boolean
      },
      %{
        description:
          "Pass True if you require the user's shipping address to complete the order. Ignored for payments in Telegram Stars.",
        name: :need_shipping_address,
        required: false,
        type: :boolean
      },
      %{
        description:
          "Pass True if the user's phone number should be sent to the provider. Ignored for payments in Telegram Stars.",
        name: :send_phone_number_to_provider,
        required: false,
        type: :boolean
      },
      %{
        description:
          "Pass True if the user's email address should be sent to the provider. Ignored for payments in Telegram Stars.",
        name: :send_email_to_provider,
        required: false,
        type: :boolean
      },
      %{
        description:
          "Pass True if the final price depends on the shipping method. Ignored for payments in Telegram Stars.",
        name: :is_flexible,
        required: false,
        type: :boolean
      }
    ],
    :string
  )

  defmethod(
    "answerShippingQuery",
    "If you sent an invoice requesting a shipping address and the parameter is_flexible was specified, the Bot API will send an Update with a shipping_query field to the bot. Use this method to reply to shipping queries. On success, True is returned.",
    [
      %{
        description: "Unique identifier for the query to be answered",
        name: :shipping_query_id,
        required: true,
        type: :string
      },
      %{
        description:
          "Pass True if delivery to the specified address is possible and False if there are any problems (for example, if delivery to the specified address is not possible)",
        name: :ok,
        required: true,
        type: :boolean
      },
      %{
        description:
          "Required if ok is True. A JSON-serialized array of available shipping options.",
        name: :shipping_options,
        required: false,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.ShippingOption}
      },
      %{
        description:
          "Required if ok is False. Error message in human readable form that explains why it is impossible to complete the order (e.g. \"Sorry, delivery to your desired address is unavailable'). Telegram will display this message to the user.",
        name: :error_message,
        required: false,
        type: :string
      }
    ],
    :boolean
  )

  defmethod(
    "answerPreCheckoutQuery",
    "Once the user has confirmed their payment and shipping details, the Bot API sends the final confirmation in the form of an Update with the field pre_checkout_query. Use this method to respond to such pre-checkout queries. On success, True is returned. Note: The Bot API must receive an answer within 10 seconds after the pre-checkout query was sent.",
    [
      %{
        description: "Unique identifier for the query to be answered",
        name: :pre_checkout_query_id,
        required: true,
        type: :string
      },
      %{
        description:
          "Specify True if everything is alright (goods are available, etc.) and the bot is ready to proceed with the order. Use False if there are any problems.",
        name: :ok,
        required: true,
        type: :boolean
      },
      %{
        description:
          "Required if ok is False. Error message in human readable form that explains the reason for failure to proceed with the checkout (e.g. \"Sorry, somebody just bought the last of our amazing black T-shirts while you were busy filling out your payment details. Please choose a different color or garment!\"). Telegram will display this message to the user.",
        name: :error_message,
        required: false,
        type: :string
      }
    ],
    :boolean
  )

  defmethod(
    "getStarTransactions",
    "Returns the bot's Telegram Star transactions in chronological order. On success, returns a StarTransactions object.",
    [
      %{
        description: "Number of transactions to skip in the response",
        name: :offset,
        required: false,
        type: :integer
      },
      %{
        description:
          "The maximum number of transactions to be retrieved. Values between 1-100 are accepted. Defaults to 100.",
        name: :limit,
        required: false,
        type: :integer
      }
    ],
    Telegex.Type.StarTransactions
  )

  defmethod(
    "refundStarPayment",
    "Refunds a successful payment in Telegram Stars. Returns True on success.",
    [
      %{
        description: "Identifier of the user whose payment will be refunded",
        name: :user_id,
        required: true,
        type: :integer
      },
      %{
        description: "Telegram payment identifier",
        name: :telegram_payment_charge_id,
        required: true,
        type: :string
      }
    ],
    :boolean
  )

  defmethod(
    "setPassportDataErrors",
    "Informs a user that some of the Telegram Passport elements they provided contains errors. The user will not be able to re-submit their Passport to you until the errors are fixed (the contents of the field for which you returned the error must change). Returns True on success.",
    [
      %{description: "User identifier", name: :user_id, required: true, type: :integer},
      %{
        description: "A JSON-serialized array describing the errors",
        name: :errors,
        required: true,
        type: %{
          __struct__: Telegex.TypeDefiner.ArrayType,
          elem_type: Telegex.Type.PassportElementError
        }
      }
    ],
    :boolean
  )

  defmethod(
    "sendGame",
    "Use this method to send a game. On success, the sent Message is returned.",
    [
      %{
        description:
          "Unique identifier of the business connection on behalf of which the message will be sent",
        name: :business_connection_id,
        required: false,
        type: :string
      },
      %{
        description: "Unique identifier for the target chat",
        name: :chat_id,
        required: true,
        type: :integer
      },
      %{
        description:
          "Unique identifier for the target message thread (topic) of the forum; for forum supergroups only",
        name: :message_thread_id,
        required: false,
        type: :integer
      },
      %{
        description:
          "Short name of the game, serves as the unique identifier for the game. Set up your games via @BotFather.",
        name: :game_short_name,
        required: true,
        type: :string
      },
      %{
        description:
          "Sends the message silently. Users will receive a notification with no sound.",
        name: :disable_notification,
        required: false,
        type: :boolean
      },
      %{
        description: "Protects the contents of the sent message from forwarding and saving",
        name: :protect_content,
        required: false,
        type: :boolean
      },
      %{
        description:
          "Pass True to allow up to 1000 messages per second, ignoring broadcasting limits for a fee of 0.1 Telegram Stars per message. The relevant Stars will be withdrawn from the bot's balance",
        name: :allow_paid_broadcast,
        required: false,
        type: :boolean
      },
      %{
        description:
          "Unique identifier of the message effect to be added to the message; for private chats only",
        name: :message_effect_id,
        required: false,
        type: :string
      },
      %{
        description: "Description of the message to reply to",
        name: :reply_parameters,
        required: false,
        type: Telegex.Type.ReplyParameters
      },
      %{
        description:
          "A JSON-serialized object for an inline keyboard. If empty, one 'Play game_title' button will be shown. If not empty, the first button must launch the game.",
        name: :reply_markup,
        required: false,
        type: Telegex.Type.InlineKeyboardMarkup
      }
    ],
    Telegex.Type.Message
  )

  defmethod(
    "setGameScore",
    "Use this method to set the score of the specified user in a game message. On success, if the message is not an inline message, the Message is returned, otherwise True is returned. Returns an error, if the new score is not greater than the user's current score in the chat and force is False.",
    [
      %{description: "User identifier", name: :user_id, required: true, type: :integer},
      %{
        description: "New score, must be non-negative",
        name: :score,
        required: true,
        type: :integer
      },
      %{
        description:
          "Pass True if the high score is allowed to decrease. This can be useful when fixing mistakes or banning cheaters",
        name: :force,
        required: false,
        type: :boolean
      },
      %{
        description:
          "Pass True if the game message should not be automatically edited to include the current scoreboard",
        name: :disable_edit_message,
        required: false,
        type: :boolean
      },
      %{
        description:
          "Required if inline_message_id is not specified. Unique identifier for the target chat",
        name: :chat_id,
        required: false,
        type: :integer
      },
      %{
        description:
          "Required if inline_message_id is not specified. Identifier of the sent message",
        name: :message_id,
        required: false,
        type: :integer
      },
      %{
        description:
          "Required if chat_id and message_id are not specified. Identifier of the inline message",
        name: :inline_message_id,
        required: false,
        type: :string
      }
    ],
    %{__struct__: Telegex.TypeDefiner.UnionType, types: [Telegex.Type.Message, :boolean]}
  )

  defmethod(
    "getGameHighScores",
    "Use this method to get data for high score tables. Will return the score of the specified user and several of their neighbors in a game. Returns an Array of GameHighScore objects.",
    [
      %{description: "Target user id", name: :user_id, required: true, type: :integer},
      %{
        description:
          "Required if inline_message_id is not specified. Unique identifier for the target chat",
        name: :chat_id,
        required: false,
        type: :integer
      },
      %{
        description:
          "Required if inline_message_id is not specified. Identifier of the sent message",
        name: :message_id,
        required: false,
        type: :integer
      },
      %{
        description:
          "Required if chat_id and message_id are not specified. Identifier of the inline message",
        name: :inline_message_id,
        required: false,
        type: :string
      }
    ],
    %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.GameHighScore}
  )
end
