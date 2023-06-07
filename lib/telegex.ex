defmodule Telegex do
  @moduledoc "All methods in the Bot API."

  use Telegex.MethodDefiner

  defmethod(
    "getUpdates",
    "Use this method to receive incoming updates using long polling (wiki). Returns an Array of Update objects.",
    [
      %{
        name: :offset,
        type: :integer,
        description:
          "Identifier of the first update to be returned. Must be greater by one than the highest among the identifiers of previously received updates. By default, updates starting with the earliest unconfirmed update are returned. An update is considered confirmed as soon as getUpdates is called with an offset higher than its update_id. The negative offset can be specified to retrieve updates starting from -offset update from the end of the updates queue. All previous updates will be forgotten.",
        required: false
      },
      %{
        name: :limit,
        type: :integer,
        description:
          "Limits the number of updates to be retrieved. Values between 1-100 are accepted. Defaults to 100.",
        required: false
      },
      %{
        name: :timeout,
        type: :integer,
        description:
          "Timeout in seconds for long polling. Defaults to 0, i.e. usual short polling. Should be positive, short polling should be used for testing purposes only.",
        required: false
      },
      %{
        name: :allowed_updates,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: :string},
        description:
          "A JSON-serialized list of the update types you want your bot to receive. For example, specify [“message”, “edited_channel_post”, “callback_query”] to only receive updates of these types. See Update for a complete list of available update types. Specify an empty list to receive all update types except chat_member (default). If not specified, the previous setting will be used.\n\nPlease note that this parameter doesn't affect updates created before the call to the getUpdates, so unwanted updates may be received for a short period of time.",
        required: false
      }
    ],
    %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.Update}
  )

  defmethod(
    "setWebhook",
    "Use this method to specify a URL and receive incoming updates via an outgoing webhook. Whenever there is an update for the bot, we will send an HTTPS POST request to the specified URL, containing a JSON-serialized Update. In case of an unsuccessful request, we will give up after a reasonable amount of attempts. Returns True on success.",
    [
      %{
        name: :url,
        type: :string,
        description:
          "HTTPS URL to send updates to. Use an empty string to remove webhook integration",
        required: true
      },
      %{
        name: :certificate,
        type: Telegex.Type.InputFile,
        description:
          "Upload your public key certificate so that the root certificate in use can be checked. See our self-signed guide for details.",
        required: false
      },
      %{
        name: :ip_address,
        type: :string,
        description:
          "The fixed IP address which will be used to send webhook requests instead of the IP address resolved through DNS",
        required: false
      },
      %{
        name: :max_connections,
        type: :integer,
        description:
          "The maximum allowed number of simultaneous HTTPS connections to the webhook for update delivery, 1-100. Defaults to 40. Use lower values to limit the load on your bot's server, and higher values to increase your bot's throughput.",
        required: false
      },
      %{
        name: :allowed_updates,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: :string},
        description:
          "A JSON-serialized list of the update types you want your bot to receive. For example, specify [“message”, “edited_channel_post”, “callback_query”] to only receive updates of these types. See Update for a complete list of available update types. Specify an empty list to receive all update types except chat_member (default). If not specified, the previous setting will be used.\nPlease note that this parameter doesn't affect updates created before the call to the setWebhook, so unwanted updates may be received for a short period of time.",
        required: false
      },
      %{
        name: :drop_pending_updates,
        type: :boolean,
        description: "Pass True to drop all pending updates",
        required: false
      },
      %{
        name: :secret_token,
        type: :string,
        description:
          "A secret token to be sent in a header “X-Telegram-Bot-Api-Secret-Token” in every webhook request, 1-256 characters. Only characters A-Z, a-z, 0-9, _ and - are allowed. The header is useful to ensure that the request comes from a webhook set by you.",
        required: false
      }
    ],
    :boolean
  )

  defmethod(
    "deleteWebhook",
    "Use this method to remove webhook integration if you decide to switch back to getUpdates. Returns True on success.",
    [
      %{
        name: :drop_pending_updates,
        type: :boolean,
        description: "Pass True to drop all pending updates",
        required: false
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
        name: :chat_id,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]},
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        required: true
      },
      %{
        name: :message_thread_id,
        type: :integer,
        description:
          "Unique identifier for the target message thread (topic) of the forum; for forum supergroups only",
        required: false
      },
      %{
        name: :text,
        type: :string,
        description: "Text of the message to be sent, 1-4096 characters after entities parsing",
        required: true
      },
      %{
        name: :parse_mode,
        type: :string,
        description:
          "Mode for parsing entities in the message text. See formatting options for more details.",
        required: false
      },
      %{
        name: :entities,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity},
        description:
          "A JSON-serialized list of special entities that appear in message text, which can be specified instead of parse_mode",
        required: false
      },
      %{
        name: :disable_web_page_preview,
        type: :boolean,
        description: "Disables link previews for links in this message",
        required: false
      },
      %{
        name: :disable_notification,
        type: :boolean,
        description:
          "Sends the message silently. Users will receive a notification with no sound.",
        required: false
      },
      %{
        name: :protect_content,
        type: :boolean,
        description: "Protects the contents of the sent message from forwarding and saving",
        required: false
      },
      %{
        name: :reply_to_message_id,
        type: :integer,
        description: "If the message is a reply, ID of the original message",
        required: false
      },
      %{
        name: :allow_sending_without_reply,
        type: :boolean,
        description:
          "Pass True if the message should be sent even if the specified replied-to message is not found",
        required: false
      },
      %{
        name: :reply_markup,
        type: %{
          __struct__: Telegex.TypeDefiner.UnionType,
          types: [
            Telegex.Type.InlineKeyboardMarkup,
            Telegex.Type.ReplyKeyboardMarkup,
            Telegex.Type.ReplyKeyboardRemove,
            Telegex.Type.ForceReply
          ]
        },
        description:
          "Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.",
        required: false
      }
    ],
    Telegex.Type.Message
  )

  defmethod(
    "forwardMessage",
    "Use this method to forward messages of any kind. Service messages can't be forwarded. On success, the sent Message is returned.",
    [
      %{
        name: :chat_id,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]},
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        required: true
      },
      %{
        name: :message_thread_id,
        type: :integer,
        description:
          "Unique identifier for the target message thread (topic) of the forum; for forum supergroups only",
        required: false
      },
      %{
        name: :from_chat_id,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]},
        description:
          "Unique identifier for the chat where the original message was sent (or channel username in the format @channelusername)",
        required: true
      },
      %{
        name: :disable_notification,
        type: :boolean,
        description:
          "Sends the message silently. Users will receive a notification with no sound.",
        required: false
      },
      %{
        name: :protect_content,
        type: :boolean,
        description: "Protects the contents of the forwarded message from forwarding and saving",
        required: false
      },
      %{
        name: :message_id,
        type: :integer,
        description: "Message identifier in the chat specified in from_chat_id",
        required: true
      }
    ],
    Telegex.Type.Message
  )

  defmethod(
    "copyMessage",
    "Use this method to copy messages of any kind. Service messages and invoice messages can't be copied. A quiz poll can be copied only if the value of the field correct_option_id is known to the bot. The method is analogous to the method forwardMessage, but the copied message doesn't have a link to the original message. Returns the MessageId of the sent message on success.",
    [
      %{
        name: :chat_id,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]},
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        required: true
      },
      %{
        name: :message_thread_id,
        type: :integer,
        description:
          "Unique identifier for the target message thread (topic) of the forum; for forum supergroups only",
        required: false
      },
      %{
        name: :from_chat_id,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]},
        description:
          "Unique identifier for the chat where the original message was sent (or channel username in the format @channelusername)",
        required: true
      },
      %{
        name: :message_id,
        type: :integer,
        description: "Message identifier in the chat specified in from_chat_id",
        required: true
      },
      %{
        name: :caption,
        type: :string,
        description:
          "New caption for media, 0-1024 characters after entities parsing. If not specified, the original caption is kept",
        required: false
      },
      %{
        name: :parse_mode,
        type: :string,
        description:
          "Mode for parsing entities in the new caption. See formatting options for more details.",
        required: false
      },
      %{
        name: :caption_entities,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity},
        description:
          "A JSON-serialized list of special entities that appear in the new caption, which can be specified instead of parse_mode",
        required: false
      },
      %{
        name: :disable_notification,
        type: :boolean,
        description:
          "Sends the message silently. Users will receive a notification with no sound.",
        required: false
      },
      %{
        name: :protect_content,
        type: :boolean,
        description: "Protects the contents of the sent message from forwarding and saving",
        required: false
      },
      %{
        name: :reply_to_message_id,
        type: :integer,
        description: "If the message is a reply, ID of the original message",
        required: false
      },
      %{
        name: :allow_sending_without_reply,
        type: :boolean,
        description:
          "Pass True if the message should be sent even if the specified replied-to message is not found",
        required: false
      },
      %{
        name: :reply_markup,
        type: %{
          __struct__: Telegex.TypeDefiner.UnionType,
          types: [
            Telegex.Type.InlineKeyboardMarkup,
            Telegex.Type.ReplyKeyboardMarkup,
            Telegex.Type.ReplyKeyboardRemove,
            Telegex.Type.ForceReply
          ]
        },
        description:
          "Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.",
        required: false
      }
    ],
    Telegex.Type.MessageId
  )

  defmethod(
    "sendPhoto",
    "Use this method to send photos. On success, the sent Message is returned.",
    [
      %{
        name: :chat_id,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]},
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        required: true
      },
      %{
        name: :message_thread_id,
        type: :integer,
        description:
          "Unique identifier for the target message thread (topic) of the forum; for forum supergroups only",
        required: false
      },
      %{
        name: :photo,
        type: %{
          __struct__: Telegex.TypeDefiner.UnionType,
          types: [Telegex.Type.InputFile, :string]
        },
        description:
          "Photo to send. Pass a file_id as String to send a photo that exists on the Telegram servers (recommended), pass an HTTP URL as a String for Telegram to get a photo from the Internet, or upload a new photo using multipart/form-data. The photo must be at most 10 MB in size. The photo's width and height must not exceed 10000 in total. Width and height ratio must be at most 20. More information on Sending Files »",
        required: true
      },
      %{
        name: :caption,
        type: :string,
        description:
          "Photo caption (may also be used when resending photos by file_id), 0-1024 characters after entities parsing",
        required: false
      },
      %{
        name: :parse_mode,
        type: :string,
        description:
          "Mode for parsing entities in the photo caption. See formatting options for more details.",
        required: false
      },
      %{
        name: :caption_entities,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity},
        description:
          "A JSON-serialized list of special entities that appear in the caption, which can be specified instead of parse_mode",
        required: false
      },
      %{
        name: :has_spoiler,
        type: :boolean,
        description: "Pass True if the photo needs to be covered with a spoiler animation",
        required: false
      },
      %{
        name: :disable_notification,
        type: :boolean,
        description:
          "Sends the message silently. Users will receive a notification with no sound.",
        required: false
      },
      %{
        name: :protect_content,
        type: :boolean,
        description: "Protects the contents of the sent message from forwarding and saving",
        required: false
      },
      %{
        name: :reply_to_message_id,
        type: :integer,
        description: "If the message is a reply, ID of the original message",
        required: false
      },
      %{
        name: :allow_sending_without_reply,
        type: :boolean,
        description:
          "Pass True if the message should be sent even if the specified replied-to message is not found",
        required: false
      },
      %{
        name: :reply_markup,
        type: %{
          __struct__: Telegex.TypeDefiner.UnionType,
          types: [
            Telegex.Type.InlineKeyboardMarkup,
            Telegex.Type.ReplyKeyboardMarkup,
            Telegex.Type.ReplyKeyboardRemove,
            Telegex.Type.ForceReply
          ]
        },
        description:
          "Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.",
        required: false
      }
    ],
    Telegex.Type.Message
  )

  defmethod(
    "sendAudio",
    "Use this method to send audio files, if you want Telegram clients to display them in the music player. Your audio must be in the .MP3 or .M4A format. On success, the sent Message is returned. Bots can currently send audio files of up to 50 MB in size, this limit may be changed in the future.",
    [
      %{
        name: :chat_id,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]},
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        required: true
      },
      %{
        name: :message_thread_id,
        type: :integer,
        description:
          "Unique identifier for the target message thread (topic) of the forum; for forum supergroups only",
        required: false
      },
      %{
        name: :audio,
        type: %{
          __struct__: Telegex.TypeDefiner.UnionType,
          types: [Telegex.Type.InputFile, :string]
        },
        description:
          "Audio file to send. Pass a file_id as String to send an audio file that exists on the Telegram servers (recommended), pass an HTTP URL as a String for Telegram to get an audio file from the Internet, or upload a new one using multipart/form-data. More information on Sending Files »",
        required: true
      },
      %{
        name: :caption,
        type: :string,
        description: "Audio caption, 0-1024 characters after entities parsing",
        required: false
      },
      %{
        name: :parse_mode,
        type: :string,
        description:
          "Mode for parsing entities in the audio caption. See formatting options for more details.",
        required: false
      },
      %{
        name: :caption_entities,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity},
        description:
          "A JSON-serialized list of special entities that appear in the caption, which can be specified instead of parse_mode",
        required: false
      },
      %{
        name: :duration,
        type: :integer,
        description: "Duration of the audio in seconds",
        required: false
      },
      %{name: :performer, type: :string, description: "Performer", required: false},
      %{name: :title, type: :string, description: "Track name", required: false},
      %{
        name: :thumbnail,
        type: %{
          __struct__: Telegex.TypeDefiner.UnionType,
          types: [Telegex.Type.InputFile, :string]
        },
        description:
          "Thumbnail of the file sent; can be ignored if thumbnail generation for the file is supported server-side. The thumbnail should be in JPEG format and less than 200 kB in size. A thumbnail's width and height should not exceed 320. Ignored if the file is not uploaded using multipart/form-data. Thumbnails can't be reused and can be only uploaded as a new file, so you can pass “attach://<file_attach_name>” if the thumbnail was uploaded using multipart/form-data under <file_attach_name>. More information on Sending Files »",
        required: false
      },
      %{
        name: :disable_notification,
        type: :boolean,
        description:
          "Sends the message silently. Users will receive a notification with no sound.",
        required: false
      },
      %{
        name: :protect_content,
        type: :boolean,
        description: "Protects the contents of the sent message from forwarding and saving",
        required: false
      },
      %{
        name: :reply_to_message_id,
        type: :integer,
        description: "If the message is a reply, ID of the original message",
        required: false
      },
      %{
        name: :allow_sending_without_reply,
        type: :boolean,
        description:
          "Pass True if the message should be sent even if the specified replied-to message is not found",
        required: false
      },
      %{
        name: :reply_markup,
        type: %{
          __struct__: Telegex.TypeDefiner.UnionType,
          types: [
            Telegex.Type.InlineKeyboardMarkup,
            Telegex.Type.ReplyKeyboardMarkup,
            Telegex.Type.ReplyKeyboardRemove,
            Telegex.Type.ForceReply
          ]
        },
        description:
          "Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.",
        required: false
      }
    ],
    Telegex.Type.Message
  )

  defmethod(
    "sendDocument",
    "Use this method to send general files. On success, the sent Message is returned. Bots can currently send files of any type of up to 50 MB in size, this limit may be changed in the future.",
    [
      %{
        name: :chat_id,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]},
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        required: true
      },
      %{
        name: :message_thread_id,
        type: :integer,
        description:
          "Unique identifier for the target message thread (topic) of the forum; for forum supergroups only",
        required: false
      },
      %{
        name: :document,
        type: %{
          __struct__: Telegex.TypeDefiner.UnionType,
          types: [Telegex.Type.InputFile, :string]
        },
        description:
          "File to send. Pass a file_id as String to send a file that exists on the Telegram servers (recommended), pass an HTTP URL as a String for Telegram to get a file from the Internet, or upload a new one using multipart/form-data. More information on Sending Files »",
        required: true
      },
      %{
        name: :thumbnail,
        type: %{
          __struct__: Telegex.TypeDefiner.UnionType,
          types: [Telegex.Type.InputFile, :string]
        },
        description:
          "Thumbnail of the file sent; can be ignored if thumbnail generation for the file is supported server-side. The thumbnail should be in JPEG format and less than 200 kB in size. A thumbnail's width and height should not exceed 320. Ignored if the file is not uploaded using multipart/form-data. Thumbnails can't be reused and can be only uploaded as a new file, so you can pass “attach://<file_attach_name>” if the thumbnail was uploaded using multipart/form-data under <file_attach_name>. More information on Sending Files »",
        required: false
      },
      %{
        name: :caption,
        type: :string,
        description:
          "Document caption (may also be used when resending documents by file_id), 0-1024 characters after entities parsing",
        required: false
      },
      %{
        name: :parse_mode,
        type: :string,
        description:
          "Mode for parsing entities in the document caption. See formatting options for more details.",
        required: false
      },
      %{
        name: :caption_entities,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity},
        description:
          "A JSON-serialized list of special entities that appear in the caption, which can be specified instead of parse_mode",
        required: false
      },
      %{
        name: :disable_content_type_detection,
        type: :boolean,
        description:
          "Disables automatic server-side content type detection for files uploaded using multipart/form-data",
        required: false
      },
      %{
        name: :disable_notification,
        type: :boolean,
        description:
          "Sends the message silently. Users will receive a notification with no sound.",
        required: false
      },
      %{
        name: :protect_content,
        type: :boolean,
        description: "Protects the contents of the sent message from forwarding and saving",
        required: false
      },
      %{
        name: :reply_to_message_id,
        type: :integer,
        description: "If the message is a reply, ID of the original message",
        required: false
      },
      %{
        name: :allow_sending_without_reply,
        type: :boolean,
        description:
          "Pass True if the message should be sent even if the specified replied-to message is not found",
        required: false
      },
      %{
        name: :reply_markup,
        type: %{
          __struct__: Telegex.TypeDefiner.UnionType,
          types: [
            Telegex.Type.InlineKeyboardMarkup,
            Telegex.Type.ReplyKeyboardMarkup,
            Telegex.Type.ReplyKeyboardRemove,
            Telegex.Type.ForceReply
          ]
        },
        description:
          "Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.",
        required: false
      }
    ],
    Telegex.Type.Message
  )

  defmethod(
    "sendVideo",
    "Use this method to send video files, Telegram clients support MPEG4 videos (other formats may be sent as Document). On success, the sent Message is returned. Bots can currently send video files of up to 50 MB in size, this limit may be changed in the future.",
    [
      %{
        name: :chat_id,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]},
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        required: true
      },
      %{
        name: :message_thread_id,
        type: :integer,
        description:
          "Unique identifier for the target message thread (topic) of the forum; for forum supergroups only",
        required: false
      },
      %{
        name: :video,
        type: %{
          __struct__: Telegex.TypeDefiner.UnionType,
          types: [Telegex.Type.InputFile, :string]
        },
        description:
          "Video to send. Pass a file_id as String to send a video that exists on the Telegram servers (recommended), pass an HTTP URL as a String for Telegram to get a video from the Internet, or upload a new video using multipart/form-data. More information on Sending Files »",
        required: true
      },
      %{
        name: :duration,
        type: :integer,
        description: "Duration of sent video in seconds",
        required: false
      },
      %{name: :width, type: :integer, description: "Video width", required: false},
      %{name: :height, type: :integer, description: "Video height", required: false},
      %{
        name: :thumbnail,
        type: %{
          __struct__: Telegex.TypeDefiner.UnionType,
          types: [Telegex.Type.InputFile, :string]
        },
        description:
          "Thumbnail of the file sent; can be ignored if thumbnail generation for the file is supported server-side. The thumbnail should be in JPEG format and less than 200 kB in size. A thumbnail's width and height should not exceed 320. Ignored if the file is not uploaded using multipart/form-data. Thumbnails can't be reused and can be only uploaded as a new file, so you can pass “attach://<file_attach_name>” if the thumbnail was uploaded using multipart/form-data under <file_attach_name>. More information on Sending Files »",
        required: false
      },
      %{
        name: :caption,
        type: :string,
        description:
          "Video caption (may also be used when resending videos by file_id), 0-1024 characters after entities parsing",
        required: false
      },
      %{
        name: :parse_mode,
        type: :string,
        description:
          "Mode for parsing entities in the video caption. See formatting options for more details.",
        required: false
      },
      %{
        name: :caption_entities,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity},
        description:
          "A JSON-serialized list of special entities that appear in the caption, which can be specified instead of parse_mode",
        required: false
      },
      %{
        name: :has_spoiler,
        type: :boolean,
        description: "Pass True if the video needs to be covered with a spoiler animation",
        required: false
      },
      %{
        name: :supports_streaming,
        type: :boolean,
        description: "Pass True if the uploaded video is suitable for streaming",
        required: false
      },
      %{
        name: :disable_notification,
        type: :boolean,
        description:
          "Sends the message silently. Users will receive a notification with no sound.",
        required: false
      },
      %{
        name: :protect_content,
        type: :boolean,
        description: "Protects the contents of the sent message from forwarding and saving",
        required: false
      },
      %{
        name: :reply_to_message_id,
        type: :integer,
        description: "If the message is a reply, ID of the original message",
        required: false
      },
      %{
        name: :allow_sending_without_reply,
        type: :boolean,
        description:
          "Pass True if the message should be sent even if the specified replied-to message is not found",
        required: false
      },
      %{
        name: :reply_markup,
        type: %{
          __struct__: Telegex.TypeDefiner.UnionType,
          types: [
            Telegex.Type.InlineKeyboardMarkup,
            Telegex.Type.ReplyKeyboardMarkup,
            Telegex.Type.ReplyKeyboardRemove,
            Telegex.Type.ForceReply
          ]
        },
        description:
          "Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.",
        required: false
      }
    ],
    Telegex.Type.Message
  )

  defmethod(
    "sendAnimation",
    "Use this method to send animation files (GIF or H.264/MPEG-4 AVC video without sound). On success, the sent Message is returned. Bots can currently send animation files of up to 50 MB in size, this limit may be changed in the future.",
    [
      %{
        name: :chat_id,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]},
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        required: true
      },
      %{
        name: :message_thread_id,
        type: :integer,
        description:
          "Unique identifier for the target message thread (topic) of the forum; for forum supergroups only",
        required: false
      },
      %{
        name: :animation,
        type: %{
          __struct__: Telegex.TypeDefiner.UnionType,
          types: [Telegex.Type.InputFile, :string]
        },
        description:
          "Animation to send. Pass a file_id as String to send an animation that exists on the Telegram servers (recommended), pass an HTTP URL as a String for Telegram to get an animation from the Internet, or upload a new animation using multipart/form-data. More information on Sending Files »",
        required: true
      },
      %{
        name: :duration,
        type: :integer,
        description: "Duration of sent animation in seconds",
        required: false
      },
      %{name: :width, type: :integer, description: "Animation width", required: false},
      %{name: :height, type: :integer, description: "Animation height", required: false},
      %{
        name: :thumbnail,
        type: %{
          __struct__: Telegex.TypeDefiner.UnionType,
          types: [Telegex.Type.InputFile, :string]
        },
        description:
          "Thumbnail of the file sent; can be ignored if thumbnail generation for the file is supported server-side. The thumbnail should be in JPEG format and less than 200 kB in size. A thumbnail's width and height should not exceed 320. Ignored if the file is not uploaded using multipart/form-data. Thumbnails can't be reused and can be only uploaded as a new file, so you can pass “attach://<file_attach_name>” if the thumbnail was uploaded using multipart/form-data under <file_attach_name>. More information on Sending Files »",
        required: false
      },
      %{
        name: :caption,
        type: :string,
        description:
          "Animation caption (may also be used when resending animation by file_id), 0-1024 characters after entities parsing",
        required: false
      },
      %{
        name: :parse_mode,
        type: :string,
        description:
          "Mode for parsing entities in the animation caption. See formatting options for more details.",
        required: false
      },
      %{
        name: :caption_entities,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity},
        description:
          "A JSON-serialized list of special entities that appear in the caption, which can be specified instead of parse_mode",
        required: false
      },
      %{
        name: :has_spoiler,
        type: :boolean,
        description: "Pass True if the animation needs to be covered with a spoiler animation",
        required: false
      },
      %{
        name: :disable_notification,
        type: :boolean,
        description:
          "Sends the message silently. Users will receive a notification with no sound.",
        required: false
      },
      %{
        name: :protect_content,
        type: :boolean,
        description: "Protects the contents of the sent message from forwarding and saving",
        required: false
      },
      %{
        name: :reply_to_message_id,
        type: :integer,
        description: "If the message is a reply, ID of the original message",
        required: false
      },
      %{
        name: :allow_sending_without_reply,
        type: :boolean,
        description:
          "Pass True if the message should be sent even if the specified replied-to message is not found",
        required: false
      },
      %{
        name: :reply_markup,
        type: %{
          __struct__: Telegex.TypeDefiner.UnionType,
          types: [
            Telegex.Type.InlineKeyboardMarkup,
            Telegex.Type.ReplyKeyboardMarkup,
            Telegex.Type.ReplyKeyboardRemove,
            Telegex.Type.ForceReply
          ]
        },
        description:
          "Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.",
        required: false
      }
    ],
    Telegex.Type.Message
  )

  defmethod(
    "sendVoice",
    "Use this method to send audio files, if you want Telegram clients to display the file as a playable voice message. For this to work, your audio must be in an .OGG file encoded with OPUS (other formats may be sent as Audio or Document). On success, the sent Message is returned. Bots can currently send voice messages of up to 50 MB in size, this limit may be changed in the future.",
    [
      %{
        name: :chat_id,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]},
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        required: true
      },
      %{
        name: :message_thread_id,
        type: :integer,
        description:
          "Unique identifier for the target message thread (topic) of the forum; for forum supergroups only",
        required: false
      },
      %{
        name: :voice,
        type: %{
          __struct__: Telegex.TypeDefiner.UnionType,
          types: [Telegex.Type.InputFile, :string]
        },
        description:
          "Audio file to send. Pass a file_id as String to send a file that exists on the Telegram servers (recommended), pass an HTTP URL as a String for Telegram to get a file from the Internet, or upload a new one using multipart/form-data. More information on Sending Files »",
        required: true
      },
      %{
        name: :caption,
        type: :string,
        description: "Voice message caption, 0-1024 characters after entities parsing",
        required: false
      },
      %{
        name: :parse_mode,
        type: :string,
        description:
          "Mode for parsing entities in the voice message caption. See formatting options for more details.",
        required: false
      },
      %{
        name: :caption_entities,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity},
        description:
          "A JSON-serialized list of special entities that appear in the caption, which can be specified instead of parse_mode",
        required: false
      },
      %{
        name: :duration,
        type: :integer,
        description: "Duration of the voice message in seconds",
        required: false
      },
      %{
        name: :disable_notification,
        type: :boolean,
        description:
          "Sends the message silently. Users will receive a notification with no sound.",
        required: false
      },
      %{
        name: :protect_content,
        type: :boolean,
        description: "Protects the contents of the sent message from forwarding and saving",
        required: false
      },
      %{
        name: :reply_to_message_id,
        type: :integer,
        description: "If the message is a reply, ID of the original message",
        required: false
      },
      %{
        name: :allow_sending_without_reply,
        type: :boolean,
        description:
          "Pass True if the message should be sent even if the specified replied-to message is not found",
        required: false
      },
      %{
        name: :reply_markup,
        type: %{
          __struct__: Telegex.TypeDefiner.UnionType,
          types: [
            Telegex.Type.InlineKeyboardMarkup,
            Telegex.Type.ReplyKeyboardMarkup,
            Telegex.Type.ReplyKeyboardRemove,
            Telegex.Type.ForceReply
          ]
        },
        description:
          "Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.",
        required: false
      }
    ],
    Telegex.Type.Message
  )

  defmethod(
    "sendVideoNote",
    "As of v.4.0, Telegram clients support rounded square MPEG4 videos of up to 1 minute long. Use this method to send video messages. On success, the sent Message is returned.",
    [
      %{
        name: :chat_id,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]},
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        required: true
      },
      %{
        name: :message_thread_id,
        type: :integer,
        description:
          "Unique identifier for the target message thread (topic) of the forum; for forum supergroups only",
        required: false
      },
      %{
        name: :video_note,
        type: %{
          __struct__: Telegex.TypeDefiner.UnionType,
          types: [Telegex.Type.InputFile, :string]
        },
        description:
          "Video note to send. Pass a file_id as String to send a video note that exists on the Telegram servers (recommended) or upload a new video using multipart/form-data. More information on Sending Files ». Sending video notes by a URL is currently unsupported",
        required: true
      },
      %{
        name: :duration,
        type: :integer,
        description: "Duration of sent video in seconds",
        required: false
      },
      %{
        name: :length,
        type: :integer,
        description: "Video width and height, i.e. diameter of the video message",
        required: false
      },
      %{
        name: :thumbnail,
        type: %{
          __struct__: Telegex.TypeDefiner.UnionType,
          types: [Telegex.Type.InputFile, :string]
        },
        description:
          "Thumbnail of the file sent; can be ignored if thumbnail generation for the file is supported server-side. The thumbnail should be in JPEG format and less than 200 kB in size. A thumbnail's width and height should not exceed 320. Ignored if the file is not uploaded using multipart/form-data. Thumbnails can't be reused and can be only uploaded as a new file, so you can pass “attach://<file_attach_name>” if the thumbnail was uploaded using multipart/form-data under <file_attach_name>. More information on Sending Files »",
        required: false
      },
      %{
        name: :disable_notification,
        type: :boolean,
        description:
          "Sends the message silently. Users will receive a notification with no sound.",
        required: false
      },
      %{
        name: :protect_content,
        type: :boolean,
        description: "Protects the contents of the sent message from forwarding and saving",
        required: false
      },
      %{
        name: :reply_to_message_id,
        type: :integer,
        description: "If the message is a reply, ID of the original message",
        required: false
      },
      %{
        name: :allow_sending_without_reply,
        type: :boolean,
        description:
          "Pass True if the message should be sent even if the specified replied-to message is not found",
        required: false
      },
      %{
        name: :reply_markup,
        type: %{
          __struct__: Telegex.TypeDefiner.UnionType,
          types: [
            Telegex.Type.InlineKeyboardMarkup,
            Telegex.Type.ReplyKeyboardMarkup,
            Telegex.Type.ReplyKeyboardRemove,
            Telegex.Type.ForceReply
          ]
        },
        description:
          "Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.",
        required: false
      }
    ],
    Telegex.Type.Message
  )

  defmethod(
    "sendMediaGroup",
    "Use this method to send a group of photos, videos, documents or audios as an album. Documents and audio files can be only grouped in an album with messages of the same type. On success, an array of Messages that were sent is returned.",
    [
      %{
        name: :chat_id,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]},
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        required: true
      },
      %{
        name: :message_thread_id,
        type: :integer,
        description:
          "Unique identifier for the target message thread (topic) of the forum; for forum supergroups only",
        required: false
      },
      %{
        name: :media,
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
        },
        description:
          "A JSON-serialized array describing messages to be sent, must include 2-10 items",
        required: true
      },
      %{
        name: :disable_notification,
        type: :boolean,
        description: "Sends messages silently. Users will receive a notification with no sound.",
        required: false
      },
      %{
        name: :protect_content,
        type: :boolean,
        description: "Protects the contents of the sent messages from forwarding and saving",
        required: false
      },
      %{
        name: :reply_to_message_id,
        type: :integer,
        description: "If the messages are a reply, ID of the original message",
        required: false
      },
      %{
        name: :allow_sending_without_reply,
        type: :boolean,
        description:
          "Pass True if the message should be sent even if the specified replied-to message is not found",
        required: false
      }
    ],
    %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.Message}
  )

  defmethod(
    "sendLocation",
    "Use this method to send point on the map. On success, the sent Message is returned.",
    [
      %{
        name: :chat_id,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]},
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        required: true
      },
      %{
        name: :message_thread_id,
        type: :integer,
        description:
          "Unique identifier for the target message thread (topic) of the forum; for forum supergroups only",
        required: false
      },
      %{name: :latitude, type: :float, description: "Latitude of the location", required: true},
      %{name: :longitude, type: :float, description: "Longitude of the location", required: true},
      %{
        name: :horizontal_accuracy,
        type: :float,
        description: "The radius of uncertainty for the location, measured in meters; 0-1500",
        required: false
      },
      %{
        name: :live_period,
        type: :integer,
        description:
          "Period in seconds for which the location will be updated (see Live Locations, should be between 60 and 86400.",
        required: false
      },
      %{
        name: :heading,
        type: :integer,
        description:
          "For live locations, a direction in which the user is moving, in degrees. Must be between 1 and 360 if specified.",
        required: false
      },
      %{
        name: :proximity_alert_radius,
        type: :integer,
        description:
          "For live locations, a maximum distance for proximity alerts about approaching another chat member, in meters. Must be between 1 and 100000 if specified.",
        required: false
      },
      %{
        name: :disable_notification,
        type: :boolean,
        description:
          "Sends the message silently. Users will receive a notification with no sound.",
        required: false
      },
      %{
        name: :protect_content,
        type: :boolean,
        description: "Protects the contents of the sent message from forwarding and saving",
        required: false
      },
      %{
        name: :reply_to_message_id,
        type: :integer,
        description: "If the message is a reply, ID of the original message",
        required: false
      },
      %{
        name: :allow_sending_without_reply,
        type: :boolean,
        description:
          "Pass True if the message should be sent even if the specified replied-to message is not found",
        required: false
      },
      %{
        name: :reply_markup,
        type: %{
          __struct__: Telegex.TypeDefiner.UnionType,
          types: [
            Telegex.Type.InlineKeyboardMarkup,
            Telegex.Type.ReplyKeyboardMarkup,
            Telegex.Type.ReplyKeyboardRemove,
            Telegex.Type.ForceReply
          ]
        },
        description:
          "Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.",
        required: false
      }
    ],
    Telegex.Type.Message
  )

  defmethod(
    "sendVenue",
    "Use this method to send information about a venue. On success, the sent Message is returned.",
    [
      %{
        name: :chat_id,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]},
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        required: true
      },
      %{
        name: :message_thread_id,
        type: :integer,
        description:
          "Unique identifier for the target message thread (topic) of the forum; for forum supergroups only",
        required: false
      },
      %{name: :latitude, type: :float, description: "Latitude of the venue", required: true},
      %{name: :longitude, type: :float, description: "Longitude of the venue", required: true},
      %{name: :title, type: :string, description: "Name of the venue", required: true},
      %{name: :address, type: :string, description: "Address of the venue", required: true},
      %{
        name: :foursquare_id,
        type: :string,
        description: "Foursquare identifier of the venue",
        required: false
      },
      %{
        name: :foursquare_type,
        type: :string,
        description:
          "Foursquare type of the venue, if known. (For example, “arts_entertainment/default”, “arts_entertainment/aquarium” or “food/icecream”.)",
        required: false
      },
      %{
        name: :google_place_id,
        type: :string,
        description: "Google Places identifier of the venue",
        required: false
      },
      %{
        name: :google_place_type,
        type: :string,
        description: "Google Places type of the venue. (See supported types.)",
        required: false
      },
      %{
        name: :disable_notification,
        type: :boolean,
        description:
          "Sends the message silently. Users will receive a notification with no sound.",
        required: false
      },
      %{
        name: :protect_content,
        type: :boolean,
        description: "Protects the contents of the sent message from forwarding and saving",
        required: false
      },
      %{
        name: :reply_to_message_id,
        type: :integer,
        description: "If the message is a reply, ID of the original message",
        required: false
      },
      %{
        name: :allow_sending_without_reply,
        type: :boolean,
        description:
          "Pass True if the message should be sent even if the specified replied-to message is not found",
        required: false
      },
      %{
        name: :reply_markup,
        type: %{
          __struct__: Telegex.TypeDefiner.UnionType,
          types: [
            Telegex.Type.InlineKeyboardMarkup,
            Telegex.Type.ReplyKeyboardMarkup,
            Telegex.Type.ReplyKeyboardRemove,
            Telegex.Type.ForceReply
          ]
        },
        description:
          "Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.",
        required: false
      }
    ],
    Telegex.Type.Message
  )

  defmethod(
    "sendContact",
    "Use this method to send phone contacts. On success, the sent Message is returned.",
    [
      %{
        name: :chat_id,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]},
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        required: true
      },
      %{
        name: :message_thread_id,
        type: :integer,
        description:
          "Unique identifier for the target message thread (topic) of the forum; for forum supergroups only",
        required: false
      },
      %{
        name: :phone_number,
        type: :string,
        description: "Contact's phone number",
        required: true
      },
      %{name: :first_name, type: :string, description: "Contact's first name", required: true},
      %{name: :last_name, type: :string, description: "Contact's last name", required: false},
      %{
        name: :vcard,
        type: :string,
        description: "Additional data about the contact in the form of a vCard, 0-2048 bytes",
        required: false
      },
      %{
        name: :disable_notification,
        type: :boolean,
        description:
          "Sends the message silently. Users will receive a notification with no sound.",
        required: false
      },
      %{
        name: :protect_content,
        type: :boolean,
        description: "Protects the contents of the sent message from forwarding and saving",
        required: false
      },
      %{
        name: :reply_to_message_id,
        type: :integer,
        description: "If the message is a reply, ID of the original message",
        required: false
      },
      %{
        name: :allow_sending_without_reply,
        type: :boolean,
        description:
          "Pass True if the message should be sent even if the specified replied-to message is not found",
        required: false
      },
      %{
        name: :reply_markup,
        type: %{
          __struct__: Telegex.TypeDefiner.UnionType,
          types: [
            Telegex.Type.InlineKeyboardMarkup,
            Telegex.Type.ReplyKeyboardMarkup,
            Telegex.Type.ReplyKeyboardRemove,
            Telegex.Type.ForceReply
          ]
        },
        description:
          "Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.",
        required: false
      }
    ],
    Telegex.Type.Message
  )

  defmethod(
    "sendPoll",
    "Use this method to send a native poll. On success, the sent Message is returned.",
    [
      %{
        name: :chat_id,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]},
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        required: true
      },
      %{
        name: :message_thread_id,
        type: :integer,
        description:
          "Unique identifier for the target message thread (topic) of the forum; for forum supergroups only",
        required: false
      },
      %{
        name: :question,
        type: :string,
        description: "Poll question, 1-300 characters",
        required: true
      },
      %{
        name: :options,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: :string},
        description:
          "A JSON-serialized list of answer options, 2-10 strings 1-100 characters each",
        required: true
      },
      %{
        name: :is_anonymous,
        type: :boolean,
        description: "True, if the poll needs to be anonymous, defaults to True",
        required: false
      },
      %{
        name: :type,
        type: :string,
        description: "Poll type, “quiz” or “regular”, defaults to “regular”",
        required: false
      },
      %{
        name: :allows_multiple_answers,
        type: :boolean,
        description:
          "True, if the poll allows multiple answers, ignored for polls in quiz mode, defaults to False",
        required: false
      },
      %{
        name: :correct_option_id,
        type: :integer,
        description:
          "0-based identifier of the correct answer option, required for polls in quiz mode",
        required: false
      },
      %{
        name: :explanation,
        type: :string,
        description:
          "Text that is shown when a user chooses an incorrect answer or taps on the lamp icon in a quiz-style poll, 0-200 characters with at most 2 line feeds after entities parsing",
        required: false
      },
      %{
        name: :explanation_parse_mode,
        type: :string,
        description:
          "Mode for parsing entities in the explanation. See formatting options for more details.",
        required: false
      },
      %{
        name: :explanation_entities,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity},
        description:
          "A JSON-serialized list of special entities that appear in the poll explanation, which can be specified instead of parse_mode",
        required: false
      },
      %{
        name: :open_period,
        type: :integer,
        description:
          "Amount of time in seconds the poll will be active after creation, 5-600. Can't be used together with close_date.",
        required: false
      },
      %{
        name: :close_date,
        type: :integer,
        description:
          "Point in time (Unix timestamp) when the poll will be automatically closed. Must be at least 5 and no more than 600 seconds in the future. Can't be used together with open_period.",
        required: false
      },
      %{
        name: :is_closed,
        type: :boolean,
        description:
          "Pass True if the poll needs to be immediately closed. This can be useful for poll preview.",
        required: false
      },
      %{
        name: :disable_notification,
        type: :boolean,
        description:
          "Sends the message silently. Users will receive a notification with no sound.",
        required: false
      },
      %{
        name: :protect_content,
        type: :boolean,
        description: "Protects the contents of the sent message from forwarding and saving",
        required: false
      },
      %{
        name: :reply_to_message_id,
        type: :integer,
        description: "If the message is a reply, ID of the original message",
        required: false
      },
      %{
        name: :allow_sending_without_reply,
        type: :boolean,
        description:
          "Pass True if the message should be sent even if the specified replied-to message is not found",
        required: false
      },
      %{
        name: :reply_markup,
        type: %{
          __struct__: Telegex.TypeDefiner.UnionType,
          types: [
            Telegex.Type.InlineKeyboardMarkup,
            Telegex.Type.ReplyKeyboardMarkup,
            Telegex.Type.ReplyKeyboardRemove,
            Telegex.Type.ForceReply
          ]
        },
        description:
          "Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.",
        required: false
      }
    ],
    Telegex.Type.Message
  )

  defmethod(
    "sendDice",
    "Use this method to send an animated emoji that will display a random value. On success, the sent Message is returned.",
    [
      %{
        name: :chat_id,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]},
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        required: true
      },
      %{
        name: :message_thread_id,
        type: :integer,
        description:
          "Unique identifier for the target message thread (topic) of the forum; for forum supergroups only",
        required: false
      },
      %{
        name: :emoji,
        type: :string,
        description:
          "Emoji on which the dice throw animation is based. Currently, must be one of “”, “”, “”, “”, “”, or “”. Dice can have values 1-6 for “”, “” and “”, values 1-5 for “” and “”, and values 1-64 for “”. Defaults to “”",
        required: false
      },
      %{
        name: :disable_notification,
        type: :boolean,
        description:
          "Sends the message silently. Users will receive a notification with no sound.",
        required: false
      },
      %{
        name: :protect_content,
        type: :boolean,
        description: "Protects the contents of the sent message from forwarding",
        required: false
      },
      %{
        name: :reply_to_message_id,
        type: :integer,
        description: "If the message is a reply, ID of the original message",
        required: false
      },
      %{
        name: :allow_sending_without_reply,
        type: :boolean,
        description:
          "Pass True if the message should be sent even if the specified replied-to message is not found",
        required: false
      },
      %{
        name: :reply_markup,
        type: %{
          __struct__: Telegex.TypeDefiner.UnionType,
          types: [
            Telegex.Type.InlineKeyboardMarkup,
            Telegex.Type.ReplyKeyboardMarkup,
            Telegex.Type.ReplyKeyboardRemove,
            Telegex.Type.ForceReply
          ]
        },
        description:
          "Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.",
        required: false
      }
    ],
    Telegex.Type.Message
  )

  defmethod(
    "sendChatAction",
    "Use this method when you need to tell the user that something is happening on the bot's side. The status is set for 5 seconds or less (when a message arrives from your bot, Telegram clients clear its typing status). Returns True on success.",
    [
      %{
        name: :chat_id,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]},
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        required: true
      },
      %{
        name: :message_thread_id,
        type: :integer,
        description: "Unique identifier for the target message thread; supergroups only",
        required: false
      },
      %{
        name: :action,
        type: :string,
        description:
          "Type of action to broadcast. Choose one, depending on what the user is about to receive: typing for text messages, upload_photo for photos, record_video or upload_video for videos, record_voice or upload_voice for voice notes, upload_document for general files, choose_sticker for stickers, find_location for location data, record_video_note or upload_video_note for video notes.",
        required: true
      }
    ],
    :boolean
  )

  defmethod(
    "getUserProfilePhotos",
    "Use this method to get a list of profile pictures for a user. Returns a UserProfilePhotos object.",
    [
      %{
        name: :user_id,
        type: :integer,
        description: "Unique identifier of the target user",
        required: true
      },
      %{
        name: :offset,
        type: :integer,
        description:
          "Sequential number of the first photo to be returned. By default, all photos are returned.",
        required: false
      },
      %{
        name: :limit,
        type: :integer,
        description:
          "Limits the number of photos to be retrieved. Values between 1-100 are accepted. Defaults to 100.",
        required: false
      }
    ],
    Telegex.Type.UserProfilePhotos
  )

  defmethod(
    "getFile",
    "Use this method to get basic information about a file and prepare it for downloading. For the moment, bots can download files of up to 20MB in size. On success, a File object is returned. The file can then be downloaded via the link https://api.telegram.org/file/bot<token>/<file_path>, where <file_path> is taken from the response. It is guaranteed that the link will be valid for at least 1 hour. When the link expires, a new one can be requested by calling getFile again.",
    [
      %{
        name: :file_id,
        type: :string,
        description: "File identifier to get information about",
        required: true
      }
    ],
    Telegex.Type.File
  )

  defmethod(
    "banChatMember",
    "Use this method to ban a user in a group, a supergroup or a channel. In the case of supergroups and channels, the user will not be able to return to the chat on their own using invite links, etc., unless unbanned first. The bot must be an administrator in the chat for this to work and must have the appropriate administrator rights. Returns True on success.",
    [
      %{
        name: :chat_id,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]},
        description:
          "Unique identifier for the target group or username of the target supergroup or channel (in the format @channelusername)",
        required: true
      },
      %{
        name: :user_id,
        type: :integer,
        description: "Unique identifier of the target user",
        required: true
      },
      %{
        name: :until_date,
        type: :integer,
        description:
          "Date when the user will be unbanned, unix time. If user is banned for more than 366 days or less than 30 seconds from the current time they are considered to be banned forever. Applied for supergroups and channels only.",
        required: false
      },
      %{
        name: :revoke_messages,
        type: :boolean,
        description:
          "Pass True to delete all messages from the chat for the user that is being removed. If False, the user will be able to see messages in the group that were sent before the user was removed. Always True for supergroups and channels.",
        required: false
      }
    ],
    :boolean
  )

  defmethod(
    "unbanChatMember",
    "Use this method to unban a previously banned user in a supergroup or channel. The user will not return to the group or channel automatically, but will be able to join via link, etc. The bot must be an administrator for this to work. By default, this method guarantees that after the call the user is not a member of the chat, but will be able to join it. So if the user is a member of the chat they will also be removed from the chat. If you don't want this, use the parameter only_if_banned. Returns True on success.",
    [
      %{
        name: :chat_id,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]},
        description:
          "Unique identifier for the target group or username of the target supergroup or channel (in the format @channelusername)",
        required: true
      },
      %{
        name: :user_id,
        type: :integer,
        description: "Unique identifier of the target user",
        required: true
      },
      %{
        name: :only_if_banned,
        type: :boolean,
        description: "Do nothing if the user is not banned",
        required: false
      }
    ],
    :boolean
  )

  defmethod(
    "restrictChatMember",
    "Use this method to restrict a user in a supergroup. The bot must be an administrator in the supergroup for this to work and must have the appropriate administrator rights. Pass True for all permissions to lift restrictions from a user. Returns True on success.",
    [
      %{
        name: :chat_id,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]},
        description:
          "Unique identifier for the target chat or username of the target supergroup (in the format @supergroupusername)",
        required: true
      },
      %{
        name: :user_id,
        type: :integer,
        description: "Unique identifier of the target user",
        required: true
      },
      %{
        name: :permissions,
        type: Telegex.Type.ChatPermissions,
        description: "A JSON-serialized object for new user permissions",
        required: true
      },
      %{
        name: :use_independent_chat_permissions,
        type: :boolean,
        description:
          "Pass True if chat permissions are set independently. Otherwise, the can_send_other_messages and can_add_web_page_previews permissions will imply the can_send_messages, can_send_audios, can_send_documents, can_send_photos, can_send_videos, can_send_video_notes, and can_send_voice_notes permissions; the can_send_polls permission will imply the can_send_messages permission.",
        required: false
      },
      %{
        name: :until_date,
        type: :integer,
        description:
          "Date when restrictions will be lifted for the user, unix time. If user is restricted for more than 366 days or less than 30 seconds from the current time, they are considered to be restricted forever",
        required: false
      }
    ],
    :boolean
  )

  defmethod(
    "promoteChatMember",
    "Use this method to promote or demote a user in a supergroup or a channel. The bot must be an administrator in the chat for this to work and must have the appropriate administrator rights. Pass False for all boolean parameters to demote a user. Returns True on success.",
    [
      %{
        name: :chat_id,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]},
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        required: true
      },
      %{
        name: :user_id,
        type: :integer,
        description: "Unique identifier of the target user",
        required: true
      },
      %{
        name: :is_anonymous,
        type: :boolean,
        description: "Pass True if the administrator's presence in the chat is hidden",
        required: false
      },
      %{
        name: :can_manage_chat,
        type: :boolean,
        description:
          "Pass True if the administrator can access the chat event log, chat statistics, message statistics in channels, see channel members, see anonymous administrators in supergroups and ignore slow mode. Implied by any other administrator privilege",
        required: false
      },
      %{
        name: :can_post_messages,
        type: :boolean,
        description: "Pass True if the administrator can create channel posts, channels only",
        required: false
      },
      %{
        name: :can_edit_messages,
        type: :boolean,
        description:
          "Pass True if the administrator can edit messages of other users and can pin messages, channels only",
        required: false
      },
      %{
        name: :can_delete_messages,
        type: :boolean,
        description: "Pass True if the administrator can delete messages of other users",
        required: false
      },
      %{
        name: :can_manage_video_chats,
        type: :boolean,
        description: "Pass True if the administrator can manage video chats",
        required: false
      },
      %{
        name: :can_restrict_members,
        type: :boolean,
        description: "Pass True if the administrator can restrict, ban or unban chat members",
        required: false
      },
      %{
        name: :can_promote_members,
        type: :boolean,
        description:
          "Pass True if the administrator can add new administrators with a subset of their own privileges or demote administrators that they have promoted, directly or indirectly (promoted by administrators that were appointed by him)",
        required: false
      },
      %{
        name: :can_change_info,
        type: :boolean,
        description:
          "Pass True if the administrator can change chat title, photo and other settings",
        required: false
      },
      %{
        name: :can_invite_users,
        type: :boolean,
        description: "Pass True if the administrator can invite new users to the chat",
        required: false
      },
      %{
        name: :can_pin_messages,
        type: :boolean,
        description: "Pass True if the administrator can pin messages, supergroups only",
        required: false
      },
      %{
        name: :can_manage_topics,
        type: :boolean,
        description:
          "Pass True if the user is allowed to create, rename, close, and reopen forum topics, supergroups only",
        required: false
      }
    ],
    :boolean
  )

  defmethod(
    "setChatAdministratorCustomTitle",
    "Use this method to set a custom title for an administrator in a supergroup promoted by the bot. Returns True on success.",
    [
      %{
        name: :chat_id,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]},
        description:
          "Unique identifier for the target chat or username of the target supergroup (in the format @supergroupusername)",
        required: true
      },
      %{
        name: :user_id,
        type: :integer,
        description: "Unique identifier of the target user",
        required: true
      },
      %{
        name: :custom_title,
        type: :string,
        description:
          "New custom title for the administrator; 0-16 characters, emoji are not allowed",
        required: true
      }
    ],
    :boolean
  )

  defmethod(
    "banChatSenderChat",
    "Use this method to ban a channel chat in a supergroup or a channel. Until the chat is unbanned, the owner of the banned chat won't be able to send messages on behalf of any of their channels. The bot must be an administrator in the supergroup or channel for this to work and must have the appropriate administrator rights. Returns True on success.",
    [
      %{
        name: :chat_id,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]},
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        required: true
      },
      %{
        name: :sender_chat_id,
        type: :integer,
        description: "Unique identifier of the target sender chat",
        required: true
      }
    ],
    :boolean
  )

  defmethod(
    "unbanChatSenderChat",
    "Use this method to unban a previously banned channel chat in a supergroup or channel. The bot must be an administrator for this to work and must have the appropriate administrator rights. Returns True on success.",
    [
      %{
        name: :chat_id,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]},
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        required: true
      },
      %{
        name: :sender_chat_id,
        type: :integer,
        description: "Unique identifier of the target sender chat",
        required: true
      }
    ],
    :boolean
  )

  defmethod(
    "setChatPermissions",
    "Use this method to set default chat permissions for all members. The bot must be an administrator in the group or a supergroup for this to work and must have the can_restrict_members administrator rights. Returns True on success.",
    [
      %{
        name: :chat_id,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]},
        description:
          "Unique identifier for the target chat or username of the target supergroup (in the format @supergroupusername)",
        required: true
      },
      %{
        name: :permissions,
        type: Telegex.Type.ChatPermissions,
        description: "A JSON-serialized object for new default chat permissions",
        required: true
      },
      %{
        name: :use_independent_chat_permissions,
        type: :boolean,
        description:
          "Pass True if chat permissions are set independently. Otherwise, the can_send_other_messages and can_add_web_page_previews permissions will imply the can_send_messages, can_send_audios, can_send_documents, can_send_photos, can_send_videos, can_send_video_notes, and can_send_voice_notes permissions; the can_send_polls permission will imply the can_send_messages permission.",
        required: false
      }
    ],
    :boolean
  )

  defmethod(
    "exportChatInviteLink",
    "Use this method to generate a new primary invite link for a chat; any previously generated primary link is revoked. The bot must be an administrator in the chat for this to work and must have the appropriate administrator rights. Returns the new invite link as String on success.",
    [
      %{
        name: :chat_id,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]},
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        required: true
      }
    ],
    :string
  )

  defmethod(
    "createChatInviteLink",
    "Use this method to create an additional invite link for a chat. The bot must be an administrator in the chat for this to work and must have the appropriate administrator rights. The link can be revoked using the method revokeChatInviteLink. Returns the new invite link as ChatInviteLink object.",
    [
      %{
        name: :chat_id,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]},
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        required: true
      },
      %{
        name: :name,
        type: :string,
        description: "Invite link name; 0-32 characters",
        required: false
      },
      %{
        name: :expire_date,
        type: :integer,
        description: "Point in time (Unix timestamp) when the link will expire",
        required: false
      },
      %{
        name: :member_limit,
        type: :integer,
        description:
          "The maximum number of users that can be members of the chat simultaneously after joining the chat via this invite link; 1-99999",
        required: false
      },
      %{
        name: :creates_join_request,
        type: :boolean,
        description:
          "True, if users joining the chat via the link need to be approved by chat administrators. If True, member_limit can't be specified",
        required: false
      }
    ],
    Telegex.Type.ChatInviteLink
  )

  defmethod(
    "editChatInviteLink",
    "Use this method to edit a non-primary invite link created by the bot. The bot must be an administrator in the chat for this to work and must have the appropriate administrator rights. Returns the edited invite link as a ChatInviteLink object.",
    [
      %{
        name: :chat_id,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]},
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        required: true
      },
      %{
        name: :invite_link,
        type: :string,
        description: "The invite link to edit",
        required: true
      },
      %{
        name: :name,
        type: :string,
        description: "Invite link name; 0-32 characters",
        required: false
      },
      %{
        name: :expire_date,
        type: :integer,
        description: "Point in time (Unix timestamp) when the link will expire",
        required: false
      },
      %{
        name: :member_limit,
        type: :integer,
        description:
          "The maximum number of users that can be members of the chat simultaneously after joining the chat via this invite link; 1-99999",
        required: false
      },
      %{
        name: :creates_join_request,
        type: :boolean,
        description:
          "True, if users joining the chat via the link need to be approved by chat administrators. If True, member_limit can't be specified",
        required: false
      }
    ],
    Telegex.Type.ChatInviteLink
  )

  defmethod(
    "revokeChatInviteLink",
    "Use this method to revoke an invite link created by the bot. If the primary link is revoked, a new link is automatically generated. The bot must be an administrator in the chat for this to work and must have the appropriate administrator rights. Returns the revoked invite link as ChatInviteLink object.",
    [
      %{
        name: :chat_id,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]},
        description:
          "Unique identifier of the target chat or username of the target channel (in the format @channelusername)",
        required: true
      },
      %{
        name: :invite_link,
        type: :string,
        description: "The invite link to revoke",
        required: true
      }
    ],
    Telegex.Type.ChatInviteLink
  )

  defmethod(
    "approveChatJoinRequest",
    "Use this method to approve a chat join request. The bot must be an administrator in the chat for this to work and must have the can_invite_users administrator right. Returns True on success.",
    [
      %{
        name: :chat_id,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]},
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        required: true
      },
      %{
        name: :user_id,
        type: :integer,
        description: "Unique identifier of the target user",
        required: true
      }
    ],
    :boolean
  )

  defmethod(
    "declineChatJoinRequest",
    "Use this method to decline a chat join request. The bot must be an administrator in the chat for this to work and must have the can_invite_users administrator right. Returns True on success.",
    [
      %{
        name: :chat_id,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]},
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        required: true
      },
      %{
        name: :user_id,
        type: :integer,
        description: "Unique identifier of the target user",
        required: true
      }
    ],
    :boolean
  )

  defmethod(
    "setChatPhoto",
    "Use this method to set a new profile photo for the chat. Photos can't be changed for private chats. The bot must be an administrator in the chat for this to work and must have the appropriate administrator rights. Returns True on success.",
    [
      %{
        name: :chat_id,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]},
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        required: true
      },
      %{
        name: :photo,
        type: Telegex.Type.InputFile,
        description: "New chat photo, uploaded using multipart/form-data",
        required: true
      }
    ],
    :boolean
  )

  defmethod(
    "deleteChatPhoto",
    "Use this method to delete a chat photo. Photos can't be changed for private chats. The bot must be an administrator in the chat for this to work and must have the appropriate administrator rights. Returns True on success.",
    [
      %{
        name: :chat_id,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]},
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        required: true
      }
    ],
    :boolean
  )

  defmethod(
    "setChatTitle",
    "Use this method to change the title of a chat. Titles can't be changed for private chats. The bot must be an administrator in the chat for this to work and must have the appropriate administrator rights. Returns True on success.",
    [
      %{
        name: :chat_id,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]},
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        required: true
      },
      %{
        name: :title,
        type: :string,
        description: "New chat title, 1-128 characters",
        required: true
      }
    ],
    :boolean
  )

  defmethod(
    "setChatDescription",
    "Use this method to change the description of a group, a supergroup or a channel. The bot must be an administrator in the chat for this to work and must have the appropriate administrator rights. Returns True on success.",
    [
      %{
        name: :chat_id,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]},
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        required: true
      },
      %{
        name: :description,
        type: :string,
        description: "New chat description, 0-255 characters",
        required: false
      }
    ],
    :boolean
  )

  defmethod(
    "pinChatMessage",
    "Use this method to add a message to the list of pinned messages in a chat. If the chat is not a private chat, the bot must be an administrator in the chat for this to work and must have the 'can_pin_messages' administrator right in a supergroup or 'can_edit_messages' administrator right in a channel. Returns True on success.",
    [
      %{
        name: :chat_id,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]},
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        required: true
      },
      %{
        name: :message_id,
        type: :integer,
        description: "Identifier of a message to pin",
        required: true
      },
      %{
        name: :disable_notification,
        type: :boolean,
        description:
          "Pass True if it is not necessary to send a notification to all chat members about the new pinned message. Notifications are always disabled in channels and private chats.",
        required: false
      }
    ],
    :boolean
  )

  defmethod(
    "unpinChatMessage",
    "Use this method to remove a message from the list of pinned messages in a chat. If the chat is not a private chat, the bot must be an administrator in the chat for this to work and must have the 'can_pin_messages' administrator right in a supergroup or 'can_edit_messages' administrator right in a channel. Returns True on success.",
    [
      %{
        name: :chat_id,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]},
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        required: true
      },
      %{
        name: :message_id,
        type: :integer,
        description:
          "Identifier of a message to unpin. If not specified, the most recent pinned message (by sending date) will be unpinned.",
        required: false
      }
    ],
    :boolean
  )

  defmethod(
    "unpinAllChatMessages",
    "Use this method to clear the list of pinned messages in a chat. If the chat is not a private chat, the bot must be an administrator in the chat for this to work and must have the 'can_pin_messages' administrator right in a supergroup or 'can_edit_messages' administrator right in a channel. Returns True on success.",
    [
      %{
        name: :chat_id,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]},
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        required: true
      }
    ],
    :boolean
  )

  defmethod(
    "leaveChat",
    "Use this method for your bot to leave a group, supergroup or channel. Returns True on success.",
    [
      %{
        name: :chat_id,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]},
        description:
          "Unique identifier for the target chat or username of the target supergroup or channel (in the format @channelusername)",
        required: true
      }
    ],
    :boolean
  )

  defmethod(
    "getChat",
    "Use this method to get up to date information about the chat (current name of the user for one-on-one conversations, current username of a user, group or channel, etc.). Returns a Chat object on success.",
    [
      %{
        name: :chat_id,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]},
        description:
          "Unique identifier for the target chat or username of the target supergroup or channel (in the format @channelusername)",
        required: true
      }
    ],
    Telegex.Type.Chat
  )

  defmethod(
    "getChatAdministrators",
    "Use this method to get a list of administrators in a chat, which aren't bots. Returns an Array of ChatMember objects.",
    [
      %{
        name: :chat_id,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]},
        description:
          "Unique identifier for the target chat or username of the target supergroup or channel (in the format @channelusername)",
        required: true
      }
    ],
    %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.ChatMember}
  )

  defmethod(
    "getChatMemberCount",
    "Use this method to get the number of members in a chat. Returns Int on success.",
    [
      %{
        name: :chat_id,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]},
        description:
          "Unique identifier for the target chat or username of the target supergroup or channel (in the format @channelusername)",
        required: true
      }
    ],
    :integer
  )

  defmethod(
    "getChatMember",
    "Use this method to get information about a member of a chat. The method is only guaranteed to work for other users if the bot is an administrator in the chat. Returns a ChatMember object on success.",
    [
      %{
        name: :chat_id,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]},
        description:
          "Unique identifier for the target chat or username of the target supergroup or channel (in the format @channelusername)",
        required: true
      },
      %{
        name: :user_id,
        type: :integer,
        description: "Unique identifier of the target user",
        required: true
      }
    ],
    Telegex.Type.ChatMember
  )

  defmethod(
    "setChatStickerSet",
    "Use this method to set a new group sticker set for a supergroup. The bot must be an administrator in the chat for this to work and must have the appropriate administrator rights. Use the field can_set_sticker_set optionally returned in getChat requests to check if the bot can use this method. Returns True on success.",
    [
      %{
        name: :chat_id,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]},
        description:
          "Unique identifier for the target chat or username of the target supergroup (in the format @supergroupusername)",
        required: true
      },
      %{
        name: :sticker_set_name,
        type: :string,
        description: "Name of the sticker set to be set as the group sticker set",
        required: true
      }
    ],
    :boolean
  )

  defmethod(
    "deleteChatStickerSet",
    "Use this method to delete a group sticker set from a supergroup. The bot must be an administrator in the chat for this to work and must have the appropriate administrator rights. Use the field can_set_sticker_set optionally returned in getChat requests to check if the bot can use this method. Returns True on success.",
    [
      %{
        name: :chat_id,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]},
        description:
          "Unique identifier for the target chat or username of the target supergroup (in the format @supergroupusername)",
        required: true
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
        name: :chat_id,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]},
        description:
          "Unique identifier for the target chat or username of the target supergroup (in the format @supergroupusername)",
        required: true
      },
      %{name: :name, type: :string, description: "Topic name, 1-128 characters", required: true},
      %{
        name: :icon_color,
        type: :integer,
        description:
          "Color of the topic icon in RGB format. Currently, must be one of 7322096 (0x6FB9F0), 16766590 (0xFFD67E), 13338331 (0xCB86DB), 9367192 (0x8EEE98), 16749490 (0xFF93B2), or 16478047 (0xFB6F5F)",
        required: false
      },
      %{
        name: :icon_custom_emoji_id,
        type: :string,
        description:
          "Unique identifier of the custom emoji shown as the topic icon. Use getForumTopicIconStickers to get all allowed custom emoji identifiers.",
        required: false
      }
    ],
    Telegex.Type.ForumTopic
  )

  defmethod(
    "editForumTopic",
    "Use this method to edit name and icon of a topic in a forum supergroup chat. The bot must be an administrator in the chat for this to work and must have can_manage_topics administrator rights, unless it is the creator of the topic. Returns True on success.",
    [
      %{
        name: :chat_id,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]},
        description:
          "Unique identifier for the target chat or username of the target supergroup (in the format @supergroupusername)",
        required: true
      },
      %{
        name: :message_thread_id,
        type: :integer,
        description: "Unique identifier for the target message thread of the forum topic",
        required: true
      },
      %{
        name: :name,
        type: :string,
        description:
          "New topic name, 0-128 characters. If not specified or empty, the current name of the topic will be kept",
        required: false
      },
      %{
        name: :icon_custom_emoji_id,
        type: :string,
        description:
          "New unique identifier of the custom emoji shown as the topic icon. Use getForumTopicIconStickers to get all allowed custom emoji identifiers. Pass an empty string to remove the icon. If not specified, the current icon will be kept",
        required: false
      }
    ],
    :boolean
  )

  defmethod(
    "closeForumTopic",
    "Use this method to close an open topic in a forum supergroup chat. The bot must be an administrator in the chat for this to work and must have the can_manage_topics administrator rights, unless it is the creator of the topic. Returns True on success.",
    [
      %{
        name: :chat_id,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]},
        description:
          "Unique identifier for the target chat or username of the target supergroup (in the format @supergroupusername)",
        required: true
      },
      %{
        name: :message_thread_id,
        type: :integer,
        description: "Unique identifier for the target message thread of the forum topic",
        required: true
      }
    ],
    :boolean
  )

  defmethod(
    "reopenForumTopic",
    "Use this method to reopen a closed topic in a forum supergroup chat. The bot must be an administrator in the chat for this to work and must have the can_manage_topics administrator rights, unless it is the creator of the topic. Returns True on success.",
    [
      %{
        name: :chat_id,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]},
        description:
          "Unique identifier for the target chat or username of the target supergroup (in the format @supergroupusername)",
        required: true
      },
      %{
        name: :message_thread_id,
        type: :integer,
        description: "Unique identifier for the target message thread of the forum topic",
        required: true
      }
    ],
    :boolean
  )

  defmethod(
    "deleteForumTopic",
    "Use this method to delete a forum topic along with all its messages in a forum supergroup chat. The bot must be an administrator in the chat for this to work and must have the can_delete_messages administrator rights. Returns True on success.",
    [
      %{
        name: :chat_id,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]},
        description:
          "Unique identifier for the target chat or username of the target supergroup (in the format @supergroupusername)",
        required: true
      },
      %{
        name: :message_thread_id,
        type: :integer,
        description: "Unique identifier for the target message thread of the forum topic",
        required: true
      }
    ],
    :boolean
  )

  defmethod(
    "unpinAllForumTopicMessages",
    "Use this method to clear the list of pinned messages in a forum topic. The bot must be an administrator in the chat for this to work and must have the can_pin_messages administrator right in the supergroup. Returns True on success.",
    [
      %{
        name: :chat_id,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]},
        description:
          "Unique identifier for the target chat or username of the target supergroup (in the format @supergroupusername)",
        required: true
      },
      %{
        name: :message_thread_id,
        type: :integer,
        description: "Unique identifier for the target message thread of the forum topic",
        required: true
      }
    ],
    :boolean
  )

  defmethod(
    "editGeneralForumTopic",
    "Use this method to edit the name of the 'General' topic in a forum supergroup chat. The bot must be an administrator in the chat for this to work and must have can_manage_topics administrator rights. Returns True on success.",
    [
      %{
        name: :chat_id,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]},
        description:
          "Unique identifier for the target chat or username of the target supergroup (in the format @supergroupusername)",
        required: true
      },
      %{
        name: :name,
        type: :string,
        description: "New topic name, 1-128 characters",
        required: true
      }
    ],
    :boolean
  )

  defmethod(
    "closeGeneralForumTopic",
    "Use this method to close an open 'General' topic in a forum supergroup chat. The bot must be an administrator in the chat for this to work and must have the can_manage_topics administrator rights. Returns True on success.",
    [
      %{
        name: :chat_id,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]},
        description:
          "Unique identifier for the target chat or username of the target supergroup (in the format @supergroupusername)",
        required: true
      }
    ],
    :boolean
  )

  defmethod(
    "reopenGeneralForumTopic",
    "Use this method to reopen a closed 'General' topic in a forum supergroup chat. The bot must be an administrator in the chat for this to work and must have the can_manage_topics administrator rights. The topic will be automatically unhidden if it was hidden. Returns True on success.",
    [
      %{
        name: :chat_id,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]},
        description:
          "Unique identifier for the target chat or username of the target supergroup (in the format @supergroupusername)",
        required: true
      }
    ],
    :boolean
  )

  defmethod(
    "hideGeneralForumTopic",
    "Use this method to hide the 'General' topic in a forum supergroup chat. The bot must be an administrator in the chat for this to work and must have the can_manage_topics administrator rights. The topic will be automatically closed if it was open. Returns True on success.",
    [
      %{
        name: :chat_id,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]},
        description:
          "Unique identifier for the target chat or username of the target supergroup (in the format @supergroupusername)",
        required: true
      }
    ],
    :boolean
  )

  defmethod(
    "unhideGeneralForumTopic",
    "Use this method to unhide the 'General' topic in a forum supergroup chat. The bot must be an administrator in the chat for this to work and must have the can_manage_topics administrator rights. Returns True on success.",
    [
      %{
        name: :chat_id,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]},
        description:
          "Unique identifier for the target chat or username of the target supergroup (in the format @supergroupusername)",
        required: true
      }
    ],
    :boolean
  )

  defmethod(
    "answerCallbackQuery",
    "Use this method to send answers to callback queries sent from inline keyboards. The answer will be displayed to the user as a notification at the top of the chat screen or as an alert. On success, True is returned.",
    [
      %{
        name: :callback_query_id,
        type: :string,
        description: "Unique identifier for the query to be answered",
        required: true
      },
      %{
        name: :text,
        type: :string,
        description:
          "Text of the notification. If not specified, nothing will be shown to the user, 0-200 characters",
        required: false
      },
      %{
        name: :show_alert,
        type: :boolean,
        description:
          "If True, an alert will be shown by the client instead of a notification at the top of the chat screen. Defaults to false.",
        required: false
      },
      %{
        name: :url,
        type: :string,
        description:
          "URL that will be opened by the user's client. If you have created a Game and accepted the conditions via @BotFather, specify the URL that opens your game - note that this will only work if the query comes from a callback_game button.\n\nOtherwise, you may use links like t.me/your_bot?start=XXXX that open your bot with a parameter.",
        required: false
      },
      %{
        name: :cache_time,
        type: :integer,
        description:
          "The maximum amount of time in seconds that the result of the callback query may be cached client-side. Telegram apps will support caching starting in version 3.14. Defaults to 0.",
        required: false
      }
    ],
    :boolean
  )

  defmethod(
    "setMyCommands",
    "Use this method to change the list of the bot's commands. See this manual for more details about bot commands. Returns True on success.",
    [
      %{
        name: :commands,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.BotCommand},
        description:
          "A JSON-serialized list of bot commands to be set as the list of the bot's commands. At most 100 commands can be specified.",
        required: true
      },
      %{
        name: :scope,
        type: Telegex.Type.BotCommandScope,
        description:
          "A JSON-serialized object, describing scope of users for which the commands are relevant. Defaults to BotCommandScopeDefault.",
        required: false
      },
      %{
        name: :language_code,
        type: :string,
        description:
          "A two-letter ISO 639-1 language code. If empty, commands will be applied to all users from the given scope, for whose language there are no dedicated commands",
        required: false
      }
    ],
    :boolean
  )

  defmethod(
    "deleteMyCommands",
    "Use this method to delete the list of the bot's commands for the given scope and user language. After deletion, higher level commands will be shown to affected users. Returns True on success.",
    [
      %{
        name: :scope,
        type: Telegex.Type.BotCommandScope,
        description:
          "A JSON-serialized object, describing scope of users for which the commands are relevant. Defaults to BotCommandScopeDefault.",
        required: false
      },
      %{
        name: :language_code,
        type: :string,
        description:
          "A two-letter ISO 639-1 language code. If empty, commands will be applied to all users from the given scope, for whose language there are no dedicated commands",
        required: false
      }
    ],
    :boolean
  )

  defmethod(
    "getMyCommands",
    "Use this method to get the current list of the bot's commands for the given scope and user language. Returns an Array of BotCommand objects. If commands aren't set, an empty list is returned.",
    [
      %{
        name: :scope,
        type: Telegex.Type.BotCommandScope,
        description:
          "A JSON-serialized object, describing scope of users. Defaults to BotCommandScopeDefault.",
        required: false
      },
      %{
        name: :language_code,
        type: :string,
        description: "A two-letter ISO 639-1 language code or an empty string",
        required: false
      }
    ],
    %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.BotCommand}
  )

  defmethod(
    "setMyName",
    "Use this method to change the bot's name. Returns True on success.",
    [
      %{
        name: :name,
        type: :string,
        description:
          "New bot name; 0-64 characters. Pass an empty string to remove the dedicated name for the given language.",
        required: false
      },
      %{
        name: :language_code,
        type: :string,
        description:
          "A two-letter ISO 639-1 language code. If empty, the name will be shown to all users for whose language there is no dedicated name.",
        required: false
      }
    ],
    :boolean
  )

  defmethod(
    "getMyName",
    "Use this method to get the current bot name for the given user language. Returns BotName on success.",
    [
      %{
        name: :language_code,
        type: :string,
        description: "A two-letter ISO 639-1 language code or an empty string",
        required: false
      }
    ],
    Telegex.Type.BotName
  )

  defmethod(
    "setMyDescription",
    "Use this method to change the bot's description, which is shown in the chat with the bot if the chat is empty. Returns True on success.",
    [
      %{
        name: :description,
        type: :string,
        description:
          "New bot description; 0-512 characters. Pass an empty string to remove the dedicated description for the given language.",
        required: false
      },
      %{
        name: :language_code,
        type: :string,
        description:
          "A two-letter ISO 639-1 language code. If empty, the description will be applied to all users for whose language there is no dedicated description.",
        required: false
      }
    ],
    :boolean
  )

  defmethod(
    "getMyDescription",
    "Use this method to get the current bot description for the given user language. Returns BotDescription on success.",
    [
      %{
        name: :language_code,
        type: :string,
        description: "A two-letter ISO 639-1 language code or an empty string",
        required: false
      }
    ],
    Telegex.Type.BotDescription
  )

  defmethod(
    "setMyShortDescription",
    "Use this method to change the bot's short description, which is shown on the bot's profile page and is sent together with the link when users share the bot. Returns True on success.",
    [
      %{
        name: :short_description,
        type: :string,
        description:
          "New short description for the bot; 0-120 characters. Pass an empty string to remove the dedicated short description for the given language.",
        required: false
      },
      %{
        name: :language_code,
        type: :string,
        description:
          "A two-letter ISO 639-1 language code. If empty, the short description will be applied to all users for whose language there is no dedicated short description.",
        required: false
      }
    ],
    :boolean
  )

  defmethod(
    "getMyShortDescription",
    "Use this method to get the current bot short description for the given user language. Returns BotShortDescription on success.",
    [
      %{
        name: :language_code,
        type: :string,
        description: "A two-letter ISO 639-1 language code or an empty string",
        required: false
      }
    ],
    Telegex.Type.BotShortDescription
  )

  defmethod(
    "setChatMenuButton",
    "Use this method to change the bot's menu button in a private chat, or the default menu button. Returns True on success.",
    [
      %{
        name: :chat_id,
        type: :integer,
        description:
          "Unique identifier for the target private chat. If not specified, default bot's menu button will be changed",
        required: false
      },
      %{
        name: :menu_button,
        type: Telegex.Type.MenuButton,
        description:
          "A JSON-serialized object for the bot's new menu button. Defaults to MenuButtonDefault",
        required: false
      }
    ],
    :boolean
  )

  defmethod(
    "getChatMenuButton",
    "Use this method to get the current value of the bot's menu button in a private chat, or the default menu button. Returns MenuButton on success.",
    [
      %{
        name: :chat_id,
        type: :integer,
        description:
          "Unique identifier for the target private chat. If not specified, default bot's menu button will be returned",
        required: false
      }
    ],
    Telegex.Type.MenuButton
  )

  defmethod(
    "setMyDefaultAdministratorRights",
    "Use this method to change the default administrator rights requested by the bot when it's added as an administrator to groups or channels. These rights will be suggested to users, but they are free to modify the list before adding the bot. Returns True on success.",
    [
      %{
        name: :rights,
        type: Telegex.Type.ChatAdministratorRights,
        description:
          "A JSON-serialized object describing new default administrator rights. If not specified, the default administrator rights will be cleared.",
        required: false
      },
      %{
        name: :for_channels,
        type: :boolean,
        description:
          "Pass True to change the default administrator rights of the bot in channels. Otherwise, the default administrator rights of the bot for groups and supergroups will be changed.",
        required: false
      }
    ],
    :boolean
  )

  defmethod(
    "getMyDefaultAdministratorRights",
    "Use this method to get the current default administrator rights of the bot. Returns ChatAdministratorRights on success.",
    [
      %{
        name: :for_channels,
        type: :boolean,
        description:
          "Pass True to get default administrator rights of the bot in channels. Otherwise, default administrator rights of the bot for groups and supergroups will be returned.",
        required: false
      }
    ],
    Telegex.Type.ChatAdministratorRights
  )

  defmethod(
    "editMessageText",
    "Use this method to edit text and game messages. On success, if the edited message is not an inline message, the edited Message is returned, otherwise True is returned.",
    [
      %{
        name: :chat_id,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]},
        description:
          "Required if inline_message_id is not specified. Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        required: false
      },
      %{
        name: :message_id,
        type: :integer,
        description:
          "Required if inline_message_id is not specified. Identifier of the message to edit",
        required: false
      },
      %{
        name: :inline_message_id,
        type: :string,
        description:
          "Required if chat_id and message_id are not specified. Identifier of the inline message",
        required: false
      },
      %{
        name: :text,
        type: :string,
        description: "New text of the message, 1-4096 characters after entities parsing",
        required: true
      },
      %{
        name: :parse_mode,
        type: :string,
        description:
          "Mode for parsing entities in the message text. See formatting options for more details.",
        required: false
      },
      %{
        name: :entities,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity},
        description:
          "A JSON-serialized list of special entities that appear in message text, which can be specified instead of parse_mode",
        required: false
      },
      %{
        name: :disable_web_page_preview,
        type: :boolean,
        description: "Disables link previews for links in this message",
        required: false
      },
      %{
        name: :reply_markup,
        type: Telegex.Type.InlineKeyboardMarkup,
        description: "A JSON-serialized object for an inline keyboard.",
        required: false
      }
    ],
    %{__struct__: Telegex.TypeDefiner.UnionType, types: [Telegex.Type.Message, :boolean]}
  )

  defmethod(
    "editMessageCaption",
    "Use this method to edit captions of messages. On success, if the edited message is not an inline message, the edited Message is returned, otherwise True is returned.",
    [
      %{
        name: :chat_id,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]},
        description:
          "Required if inline_message_id is not specified. Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        required: false
      },
      %{
        name: :message_id,
        type: :integer,
        description:
          "Required if inline_message_id is not specified. Identifier of the message to edit",
        required: false
      },
      %{
        name: :inline_message_id,
        type: :string,
        description:
          "Required if chat_id and message_id are not specified. Identifier of the inline message",
        required: false
      },
      %{
        name: :caption,
        type: :string,
        description: "New caption of the message, 0-1024 characters after entities parsing",
        required: false
      },
      %{
        name: :parse_mode,
        type: :string,
        description:
          "Mode for parsing entities in the message caption. See formatting options for more details.",
        required: false
      },
      %{
        name: :caption_entities,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity},
        description:
          "A JSON-serialized list of special entities that appear in the caption, which can be specified instead of parse_mode",
        required: false
      },
      %{
        name: :reply_markup,
        type: Telegex.Type.InlineKeyboardMarkup,
        description: "A JSON-serialized object for an inline keyboard.",
        required: false
      }
    ],
    %{__struct__: Telegex.TypeDefiner.UnionType, types: [Telegex.Type.Message, :boolean]}
  )

  defmethod(
    "editMessageMedia",
    "Use this method to edit animation, audio, document, photo, or video messages. If a message is part of a message album, then it can be edited only to an audio for audio albums, only to a document for document albums and to a photo or a video otherwise. When an inline message is edited, a new file can't be uploaded; use a previously uploaded file via its file_id or specify a URL. On success, if the edited message is not an inline message, the edited Message is returned, otherwise True is returned.",
    [
      %{
        name: :chat_id,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]},
        description:
          "Required if inline_message_id is not specified. Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        required: false
      },
      %{
        name: :message_id,
        type: :integer,
        description:
          "Required if inline_message_id is not specified. Identifier of the message to edit",
        required: false
      },
      %{
        name: :inline_message_id,
        type: :string,
        description:
          "Required if chat_id and message_id are not specified. Identifier of the inline message",
        required: false
      },
      %{
        name: :media,
        type: Telegex.Type.InputMedia,
        description: "A JSON-serialized object for a new media content of the message",
        required: true
      },
      %{
        name: :reply_markup,
        type: Telegex.Type.InlineKeyboardMarkup,
        description: "A JSON-serialized object for a new inline keyboard.",
        required: false
      }
    ],
    %{__struct__: Telegex.TypeDefiner.UnionType, types: [Telegex.Type.Message, :boolean]}
  )

  defmethod(
    "editMessageLiveLocation",
    "Use this method to edit live location messages. A location can be edited until its live_period expires or editing is explicitly disabled by a call to stopMessageLiveLocation. On success, if the edited message is not an inline message, the edited Message is returned, otherwise True is returned.",
    [
      %{
        name: :chat_id,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]},
        description:
          "Required if inline_message_id is not specified. Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        required: false
      },
      %{
        name: :message_id,
        type: :integer,
        description:
          "Required if inline_message_id is not specified. Identifier of the message to edit",
        required: false
      },
      %{
        name: :inline_message_id,
        type: :string,
        description:
          "Required if chat_id and message_id are not specified. Identifier of the inline message",
        required: false
      },
      %{name: :latitude, type: :float, description: "Latitude of new location", required: true},
      %{name: :longitude, type: :float, description: "Longitude of new location", required: true},
      %{
        name: :horizontal_accuracy,
        type: :float,
        description: "The radius of uncertainty for the location, measured in meters; 0-1500",
        required: false
      },
      %{
        name: :heading,
        type: :integer,
        description:
          "Direction in which the user is moving, in degrees. Must be between 1 and 360 if specified.",
        required: false
      },
      %{
        name: :proximity_alert_radius,
        type: :integer,
        description:
          "The maximum distance for proximity alerts about approaching another chat member, in meters. Must be between 1 and 100000 if specified.",
        required: false
      },
      %{
        name: :reply_markup,
        type: Telegex.Type.InlineKeyboardMarkup,
        description: "A JSON-serialized object for a new inline keyboard.",
        required: false
      }
    ],
    %{__struct__: Telegex.TypeDefiner.UnionType, types: [Telegex.Type.Message, :boolean]}
  )

  defmethod(
    "stopMessageLiveLocation",
    "Use this method to stop updating a live location message before live_period expires. On success, if the message is not an inline message, the edited Message is returned, otherwise True is returned.",
    [
      %{
        name: :chat_id,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]},
        description:
          "Required if inline_message_id is not specified. Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        required: false
      },
      %{
        name: :message_id,
        type: :integer,
        description:
          "Required if inline_message_id is not specified. Identifier of the message with live location to stop",
        required: false
      },
      %{
        name: :inline_message_id,
        type: :string,
        description:
          "Required if chat_id and message_id are not specified. Identifier of the inline message",
        required: false
      },
      %{
        name: :reply_markup,
        type: Telegex.Type.InlineKeyboardMarkup,
        description: "A JSON-serialized object for a new inline keyboard.",
        required: false
      }
    ],
    %{__struct__: Telegex.TypeDefiner.UnionType, types: [Telegex.Type.Message, :boolean]}
  )

  defmethod(
    "editMessageReplyMarkup",
    "Use this method to edit only the reply markup of messages. On success, if the edited message is not an inline message, the edited Message is returned, otherwise True is returned.",
    [
      %{
        name: :chat_id,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]},
        description:
          "Required if inline_message_id is not specified. Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        required: false
      },
      %{
        name: :message_id,
        type: :integer,
        description:
          "Required if inline_message_id is not specified. Identifier of the message to edit",
        required: false
      },
      %{
        name: :inline_message_id,
        type: :string,
        description:
          "Required if chat_id and message_id are not specified. Identifier of the inline message",
        required: false
      },
      %{
        name: :reply_markup,
        type: Telegex.Type.InlineKeyboardMarkup,
        description: "A JSON-serialized object for an inline keyboard.",
        required: false
      }
    ],
    %{__struct__: Telegex.TypeDefiner.UnionType, types: [Telegex.Type.Message, :boolean]}
  )

  defmethod(
    "stopPoll",
    "Use this method to stop a poll which was sent by the bot. On success, the stopped Poll is returned.",
    [
      %{
        name: :chat_id,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]},
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        required: true
      },
      %{
        name: :message_id,
        type: :integer,
        description: "Identifier of the original message with the poll",
        required: true
      },
      %{
        name: :reply_markup,
        type: Telegex.Type.InlineKeyboardMarkup,
        description: "A JSON-serialized object for a new message inline keyboard.",
        required: false
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
        name: :chat_id,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]},
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        required: true
      },
      %{
        name: :message_id,
        type: :integer,
        description: "Identifier of the message to delete",
        required: true
      }
    ],
    :boolean
  )

  defmethod(
    "sendSticker",
    "Use this method to send static .WEBP, animated .TGS, or video .WEBM stickers. On success, the sent Message is returned.",
    [
      %{
        name: :chat_id,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]},
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        required: true
      },
      %{
        name: :message_thread_id,
        type: :integer,
        description:
          "Unique identifier for the target message thread (topic) of the forum; for forum supergroups only",
        required: false
      },
      %{
        name: :sticker,
        type: %{
          __struct__: Telegex.TypeDefiner.UnionType,
          types: [Telegex.Type.InputFile, :string]
        },
        description:
          "Sticker to send. Pass a file_id as String to send a file that exists on the Telegram servers (recommended), pass an HTTP URL as a String for Telegram to get a .WEBP sticker from the Internet, or upload a new .WEBP or .TGS sticker using multipart/form-data. More information on Sending Files ». Video stickers can only be sent by a file_id. Animated stickers can't be sent via an HTTP URL.",
        required: true
      },
      %{
        name: :emoji,
        type: :string,
        description: "Emoji associated with the sticker; only for just uploaded stickers",
        required: false
      },
      %{
        name: :disable_notification,
        type: :boolean,
        description:
          "Sends the message silently. Users will receive a notification with no sound.",
        required: false
      },
      %{
        name: :protect_content,
        type: :boolean,
        description: "Protects the contents of the sent message from forwarding and saving",
        required: false
      },
      %{
        name: :reply_to_message_id,
        type: :integer,
        description: "If the message is a reply, ID of the original message",
        required: false
      },
      %{
        name: :allow_sending_without_reply,
        type: :boolean,
        description:
          "Pass True if the message should be sent even if the specified replied-to message is not found",
        required: false
      },
      %{
        name: :reply_markup,
        type: %{
          __struct__: Telegex.TypeDefiner.UnionType,
          types: [
            Telegex.Type.InlineKeyboardMarkup,
            Telegex.Type.ReplyKeyboardMarkup,
            Telegex.Type.ReplyKeyboardRemove,
            Telegex.Type.ForceReply
          ]
        },
        description:
          "Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to remove reply keyboard or to force a reply from the user.",
        required: false
      }
    ],
    Telegex.Type.Message
  )

  defmethod(
    "getStickerSet",
    "Use this method to get a sticker set. On success, a StickerSet object is returned.",
    [%{name: :name, type: :string, description: "Name of the sticker set", required: true}],
    Telegex.Type.StickerSet
  )

  defmethod(
    "getCustomEmojiStickers",
    "Use this method to get information about custom emoji stickers by their identifiers. Returns an Array of Sticker objects.",
    [
      %{
        name: :custom_emoji_ids,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: :string},
        description:
          "List of custom emoji identifiers. At most 200 custom emoji identifiers can be specified.",
        required: true
      }
    ],
    %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.Sticker}
  )

  defmethod(
    "uploadStickerFile",
    "Use this method to upload a file with a sticker for later use in the createNewStickerSet and addStickerToSet methods (the file can be used multiple times). Returns the uploaded File on success.",
    [
      %{
        name: :user_id,
        type: :integer,
        description: "User identifier of sticker file owner",
        required: true
      },
      %{
        name: :sticker,
        type: Telegex.Type.InputFile,
        description:
          "A file with the sticker in .WEBP, .PNG, .TGS, or .WEBM format. See https://core.telegram.org/stickers for technical requirements. More information on Sending Files »",
        required: true
      },
      %{
        name: :sticker_format,
        type: :string,
        description: "Format of the sticker, must be one of “static”, “animated”, “video”",
        required: true
      }
    ],
    Telegex.Type.File
  )

  defmethod(
    "createNewStickerSet",
    "Use this method to create a new sticker set owned by a user. The bot will be able to edit the sticker set thus created. Returns True on success.",
    [
      %{
        name: :user_id,
        type: :integer,
        description: "User identifier of created sticker set owner",
        required: true
      },
      %{
        name: :name,
        type: :string,
        description:
          "Short name of sticker set, to be used in t.me/addstickers/ URLs (e.g., animals). Can contain only English letters, digits and underscores. Must begin with a letter, can't contain consecutive underscores and must end in \"_by_<bot_username>\". <bot_username> is case insensitive. 1-64 characters.",
        required: true
      },
      %{
        name: :title,
        type: :string,
        description: "Sticker set title, 1-64 characters",
        required: true
      },
      %{
        name: :stickers,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.InputSticker},
        description:
          "A JSON-serialized list of 1-50 initial stickers to be added to the sticker set",
        required: true
      },
      %{
        name: :sticker_format,
        type: :string,
        description:
          "Format of stickers in the set, must be one of “static”, “animated”, “video”",
        required: true
      },
      %{
        name: :sticker_type,
        type: :string,
        description:
          "Type of stickers in the set, pass “regular”, “mask”, or “custom_emoji”. By default, a regular sticker set is created.",
        required: false
      },
      %{
        name: :needs_repainting,
        type: :boolean,
        description:
          "Pass True if stickers in the sticker set must be repainted to the color of text when used in messages, the accent color if used as emoji status, white on chat photos, or another appropriate color based on context; for custom emoji sticker sets only",
        required: false
      }
    ],
    :boolean
  )

  defmethod(
    "addStickerToSet",
    "Use this method to add a new sticker to a set created by the bot. The format of the added sticker must match the format of the other stickers in the set. Emoji sticker sets can have up to 200 stickers. Animated and video sticker sets can have up to 50 stickers. Static sticker sets can have up to 120 stickers. Returns True on success.",
    [
      %{
        name: :user_id,
        type: :integer,
        description: "User identifier of sticker set owner",
        required: true
      },
      %{name: :name, type: :string, description: "Sticker set name", required: true},
      %{
        name: :sticker,
        type: Telegex.Type.InputSticker,
        description:
          "A JSON-serialized object with information about the added sticker. If exactly the same sticker had already been added to the set, then the set isn't changed.",
        required: true
      }
    ],
    :boolean
  )

  defmethod(
    "setStickerPositionInSet",
    "Use this method to move a sticker in a set created by the bot to a specific position. Returns True on success.",
    [
      %{
        name: :sticker,
        type: :string,
        description: "File identifier of the sticker",
        required: true
      },
      %{
        name: :position,
        type: :integer,
        description: "New sticker position in the set, zero-based",
        required: true
      }
    ],
    :boolean
  )

  defmethod(
    "deleteStickerFromSet",
    "Use this method to delete a sticker from a set created by the bot. Returns True on success.",
    [
      %{
        name: :sticker,
        type: :string,
        description: "File identifier of the sticker",
        required: true
      }
    ],
    :boolean
  )

  defmethod(
    "setStickerEmojiList",
    "Use this method to change the list of emoji assigned to a regular or custom emoji sticker. The sticker must belong to a sticker set created by the bot. Returns True on success.",
    [
      %{
        name: :sticker,
        type: :string,
        description: "File identifier of the sticker",
        required: true
      },
      %{
        name: :emoji_list,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: :string},
        description: "A JSON-serialized list of 1-20 emoji associated with the sticker",
        required: true
      }
    ],
    :boolean
  )

  defmethod(
    "setStickerKeywords",
    "Use this method to change search keywords assigned to a regular or custom emoji sticker. The sticker must belong to a sticker set created by the bot. Returns True on success.",
    [
      %{
        name: :sticker,
        type: :string,
        description: "File identifier of the sticker",
        required: true
      },
      %{
        name: :keywords,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: :string},
        description:
          "A JSON-serialized list of 0-20 search keywords for the sticker with total length of up to 64 characters",
        required: false
      }
    ],
    :boolean
  )

  defmethod(
    "setStickerMaskPosition",
    "Use this method to change the mask position of a mask sticker. The sticker must belong to a sticker set that was created by the bot. Returns True on success.",
    [
      %{
        name: :sticker,
        type: :string,
        description: "File identifier of the sticker",
        required: true
      },
      %{
        name: :mask_position,
        type: Telegex.Type.MaskPosition,
        description:
          "A JSON-serialized object with the position where the mask should be placed on faces. Omit the parameter to remove the mask position.",
        required: false
      }
    ],
    :boolean
  )

  defmethod(
    "setStickerSetTitle",
    "Use this method to set the title of a created sticker set. Returns True on success.",
    [
      %{name: :name, type: :string, description: "Sticker set name", required: true},
      %{
        name: :title,
        type: :string,
        description: "Sticker set title, 1-64 characters",
        required: true
      }
    ],
    :boolean
  )

  defmethod(
    "setStickerSetThumbnail",
    "Use this method to set the thumbnail of a regular or mask sticker set. The format of the thumbnail file must match the format of the stickers in the set. Returns True on success.",
    [
      %{name: :name, type: :string, description: "Sticker set name", required: true},
      %{
        name: :user_id,
        type: :integer,
        description: "User identifier of the sticker set owner",
        required: true
      },
      %{
        name: :thumbnail,
        type: %{
          __struct__: Telegex.TypeDefiner.UnionType,
          types: [Telegex.Type.InputFile, :string]
        },
        description:
          "A .WEBP or .PNG image with the thumbnail, must be up to 128 kilobytes in size and have a width and height of exactly 100px, or a .TGS animation with a thumbnail up to 32 kilobytes in size (see https://core.telegram.org/stickers#animated-sticker-requirements for animated sticker technical requirements), or a WEBM video with the thumbnail up to 32 kilobytes in size; see https://core.telegram.org/stickers#video-sticker-requirements for video sticker technical requirements. Pass a file_id as a String to send a file that already exists on the Telegram servers, pass an HTTP URL as a String for Telegram to get a file from the Internet, or upload a new one using multipart/form-data. More information on Sending Files ». Animated and video sticker set thumbnails can't be uploaded via HTTP URL. If omitted, then the thumbnail is dropped and the first sticker is used as the thumbnail.",
        required: false
      }
    ],
    :boolean
  )

  defmethod(
    "setCustomEmojiStickerSetThumbnail",
    "Use this method to set the thumbnail of a custom emoji sticker set. Returns True on success.",
    [
      %{name: :name, type: :string, description: "Sticker set name", required: true},
      %{
        name: :custom_emoji_id,
        type: :string,
        description:
          "Custom emoji identifier of a sticker from the sticker set; pass an empty string to drop the thumbnail and use the first sticker as the thumbnail.",
        required: false
      }
    ],
    :boolean
  )

  defmethod(
    "deleteStickerSet",
    "Use this method to delete a sticker set that was created by the bot. Returns True on success.",
    [%{name: :name, type: :string, description: "Sticker set name", required: true}],
    :boolean
  )

  defmethod(
    "answerInlineQuery",
    "Use this method to send answers to an inline query. On success, True is returned.
No more than 50 results per query are allowed.",
    [
      %{
        name: :inline_query_id,
        type: :string,
        description: "Unique identifier for the answered query",
        required: true
      },
      %{
        name: :results,
        type: %{
          __struct__: Telegex.TypeDefiner.ArrayType,
          elem_type: Telegex.Type.InlineQueryResult
        },
        description: "A JSON-serialized array of results for the inline query",
        required: true
      },
      %{
        name: :cache_time,
        type: :integer,
        description:
          "The maximum amount of time in seconds that the result of the inline query may be cached on the server. Defaults to 300.",
        required: false
      },
      %{
        name: :is_personal,
        type: :boolean,
        description:
          "Pass True if results may be cached on the server side only for the user that sent the query. By default, results may be returned to any user who sends the same query.",
        required: false
      },
      %{
        name: :next_offset,
        type: :string,
        description:
          "Pass the offset that a client should send in the next query with the same text to receive more results. Pass an empty string if there are no more results or if you don't support pagination. Offset length can't exceed 64 bytes.",
        required: false
      },
      %{
        name: :button,
        type: Telegex.Type.InlineQueryResultsButton,
        description:
          "A JSON-serialized object describing a button to be shown above inline query results",
        required: false
      }
    ],
    :boolean
  )

  defmethod(
    "answerWebAppQuery",
    "Use this method to set the result of an interaction with a Web App and send a corresponding message on behalf of the user to the chat from which the query originated. On success, a SentWebAppMessage object is returned.",
    [
      %{
        name: :web_app_query_id,
        type: :string,
        description: "Unique identifier for the query to be answered",
        required: true
      },
      %{
        name: :result,
        type: Telegex.Type.InlineQueryResult,
        description: "A JSON-serialized object describing the message to be sent",
        required: true
      }
    ],
    Telegex.Type.SentWebAppMessage
  )

  defmethod(
    "sendInvoice",
    "Use this method to send invoices. On success, the sent Message is returned.",
    [
      %{
        name: :chat_id,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]},
        description:
          "Unique identifier for the target chat or username of the target channel (in the format @channelusername)",
        required: true
      },
      %{
        name: :message_thread_id,
        type: :integer,
        description:
          "Unique identifier for the target message thread (topic) of the forum; for forum supergroups only",
        required: false
      },
      %{
        name: :title,
        type: :string,
        description: "Product name, 1-32 characters",
        required: true
      },
      %{
        name: :description,
        type: :string,
        description: "Product description, 1-255 characters",
        required: true
      },
      %{
        name: :payload,
        type: :string,
        description:
          "Bot-defined invoice payload, 1-128 bytes. This will not be displayed to the user, use for your internal processes.",
        required: true
      },
      %{
        name: :provider_token,
        type: :string,
        description: "Payment provider token, obtained via @BotFather",
        required: true
      },
      %{
        name: :currency,
        type: :string,
        description: "Three-letter ISO 4217 currency code, see more on currencies",
        required: true
      },
      %{
        name: :prices,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.LabeledPrice},
        description:
          "Price breakdown, a JSON-serialized list of components (e.g. product price, tax, discount, delivery cost, delivery tax, bonus, etc.)",
        required: true
      },
      %{
        name: :max_tip_amount,
        type: :integer,
        description:
          "The maximum accepted amount for tips in the smallest units of the currency (integer, not float/double). For example, for a maximum tip of US$ 1.45 pass max_tip_amount = 145. See the exp parameter in currencies.json, it shows the number of digits past the decimal point for each currency (2 for the majority of currencies). Defaults to 0",
        required: false
      },
      %{
        name: :suggested_tip_amounts,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: :integer},
        description:
          "A JSON-serialized array of suggested amounts of tips in the smallest units of the currency (integer, not float/double). At most 4 suggested tip amounts can be specified. The suggested tip amounts must be positive, passed in a strictly increased order and must not exceed max_tip_amount.",
        required: false
      },
      %{
        name: :start_parameter,
        type: :string,
        description:
          "Unique deep-linking parameter. If left empty, forwarded copies of the sent message will have a Pay button, allowing multiple users to pay directly from the forwarded message, using the same invoice. If non-empty, forwarded copies of the sent message will have a URL button with a deep link to the bot (instead of a Pay button), with the value used as the start parameter",
        required: false
      },
      %{
        name: :provider_data,
        type: :string,
        description:
          "JSON-serialized data about the invoice, which will be shared with the payment provider. A detailed description of required fields should be provided by the payment provider.",
        required: false
      },
      %{
        name: :photo_url,
        type: :string,
        description:
          "URL of the product photo for the invoice. Can be a photo of the goods or a marketing image for a service. People like it better when they see what they are paying for.",
        required: false
      },
      %{name: :photo_size, type: :integer, description: "Photo size in bytes", required: false},
      %{name: :photo_width, type: :integer, description: "Photo width", required: false},
      %{name: :photo_height, type: :integer, description: "Photo height", required: false},
      %{
        name: :need_name,
        type: :boolean,
        description: "Pass True if you require the user's full name to complete the order",
        required: false
      },
      %{
        name: :need_phone_number,
        type: :boolean,
        description: "Pass True if you require the user's phone number to complete the order",
        required: false
      },
      %{
        name: :need_email,
        type: :boolean,
        description: "Pass True if you require the user's email address to complete the order",
        required: false
      },
      %{
        name: :need_shipping_address,
        type: :boolean,
        description: "Pass True if you require the user's shipping address to complete the order",
        required: false
      },
      %{
        name: :send_phone_number_to_provider,
        type: :boolean,
        description: "Pass True if the user's phone number should be sent to provider",
        required: false
      },
      %{
        name: :send_email_to_provider,
        type: :boolean,
        description: "Pass True if the user's email address should be sent to provider",
        required: false
      },
      %{
        name: :is_flexible,
        type: :boolean,
        description: "Pass True if the final price depends on the shipping method",
        required: false
      },
      %{
        name: :disable_notification,
        type: :boolean,
        description:
          "Sends the message silently. Users will receive a notification with no sound.",
        required: false
      },
      %{
        name: :protect_content,
        type: :boolean,
        description: "Protects the contents of the sent message from forwarding and saving",
        required: false
      },
      %{
        name: :reply_to_message_id,
        type: :integer,
        description: "If the message is a reply, ID of the original message",
        required: false
      },
      %{
        name: :allow_sending_without_reply,
        type: :boolean,
        description:
          "Pass True if the message should be sent even if the specified replied-to message is not found",
        required: false
      },
      %{
        name: :reply_markup,
        type: Telegex.Type.InlineKeyboardMarkup,
        description:
          "A JSON-serialized object for an inline keyboard. If empty, one 'Pay total price' button will be shown. If not empty, the first button must be a Pay button.",
        required: false
      }
    ],
    Telegex.Type.Message
  )

  defmethod(
    "createInvoiceLink",
    "Use this method to create a link for an invoice. Returns the created invoice link as String on success.",
    [
      %{
        name: :title,
        type: :string,
        description: "Product name, 1-32 characters",
        required: true
      },
      %{
        name: :description,
        type: :string,
        description: "Product description, 1-255 characters",
        required: true
      },
      %{
        name: :payload,
        type: :string,
        description:
          "Bot-defined invoice payload, 1-128 bytes. This will not be displayed to the user, use for your internal processes.",
        required: true
      },
      %{
        name: :provider_token,
        type: :string,
        description: "Payment provider token, obtained via BotFather",
        required: true
      },
      %{
        name: :currency,
        type: :string,
        description: "Three-letter ISO 4217 currency code, see more on currencies",
        required: true
      },
      %{
        name: :prices,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.LabeledPrice},
        description:
          "Price breakdown, a JSON-serialized list of components (e.g. product price, tax, discount, delivery cost, delivery tax, bonus, etc.)",
        required: true
      },
      %{
        name: :max_tip_amount,
        type: :integer,
        description:
          "The maximum accepted amount for tips in the smallest units of the currency (integer, not float/double). For example, for a maximum tip of US$ 1.45 pass max_tip_amount = 145. See the exp parameter in currencies.json, it shows the number of digits past the decimal point for each currency (2 for the majority of currencies). Defaults to 0",
        required: false
      },
      %{
        name: :suggested_tip_amounts,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: :integer},
        description:
          "A JSON-serialized array of suggested amounts of tips in the smallest units of the currency (integer, not float/double). At most 4 suggested tip amounts can be specified. The suggested tip amounts must be positive, passed in a strictly increased order and must not exceed max_tip_amount.",
        required: false
      },
      %{
        name: :provider_data,
        type: :string,
        description:
          "JSON-serialized data about the invoice, which will be shared with the payment provider. A detailed description of required fields should be provided by the payment provider.",
        required: false
      },
      %{
        name: :photo_url,
        type: :string,
        description:
          "URL of the product photo for the invoice. Can be a photo of the goods or a marketing image for a service.",
        required: false
      },
      %{name: :photo_size, type: :integer, description: "Photo size in bytes", required: false},
      %{name: :photo_width, type: :integer, description: "Photo width", required: false},
      %{name: :photo_height, type: :integer, description: "Photo height", required: false},
      %{
        name: :need_name,
        type: :boolean,
        description: "Pass True if you require the user's full name to complete the order",
        required: false
      },
      %{
        name: :need_phone_number,
        type: :boolean,
        description: "Pass True if you require the user's phone number to complete the order",
        required: false
      },
      %{
        name: :need_email,
        type: :boolean,
        description: "Pass True if you require the user's email address to complete the order",
        required: false
      },
      %{
        name: :need_shipping_address,
        type: :boolean,
        description: "Pass True if you require the user's shipping address to complete the order",
        required: false
      },
      %{
        name: :send_phone_number_to_provider,
        type: :boolean,
        description: "Pass True if the user's phone number should be sent to the provider",
        required: false
      },
      %{
        name: :send_email_to_provider,
        type: :boolean,
        description: "Pass True if the user's email address should be sent to the provider",
        required: false
      },
      %{
        name: :is_flexible,
        type: :boolean,
        description: "Pass True if the final price depends on the shipping method",
        required: false
      }
    ],
    :string
  )

  defmethod(
    "answerShippingQuery",
    "If you sent an invoice requesting a shipping address and the parameter is_flexible was specified, the Bot API will send an Update with a shipping_query field to the bot. Use this method to reply to shipping queries. On success, True is returned.",
    [
      %{
        name: :shipping_query_id,
        type: :string,
        description: "Unique identifier for the query to be answered",
        required: true
      },
      %{
        name: :ok,
        type: :boolean,
        description:
          "Pass True if delivery to the specified address is possible and False if there are any problems (for example, if delivery to the specified address is not possible)",
        required: true
      },
      %{
        name: :shipping_options,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.ShippingOption},
        description:
          "Required if ok is True. A JSON-serialized array of available shipping options.",
        required: false
      },
      %{
        name: :error_message,
        type: :string,
        description:
          "Required if ok is False. Error message in human readable form that explains why it is impossible to complete the order (e.g. \"Sorry, delivery to your desired address is unavailable'). Telegram will display this message to the user.",
        required: false
      }
    ],
    :boolean
  )

  defmethod(
    "answerPreCheckoutQuery",
    "Once the user has confirmed their payment and shipping details, the Bot API sends the final confirmation in the form of an Update with the field pre_checkout_query. Use this method to respond to such pre-checkout queries. On success, True is returned. Note: The Bot API must receive an answer within 10 seconds after the pre-checkout query was sent.",
    [
      %{
        name: :pre_checkout_query_id,
        type: :string,
        description: "Unique identifier for the query to be answered",
        required: true
      },
      %{
        name: :ok,
        type: :boolean,
        description:
          "Specify True if everything is alright (goods are available, etc.) and the bot is ready to proceed with the order. Use False if there are any problems.",
        required: true
      },
      %{
        name: :error_message,
        type: :string,
        description:
          "Required if ok is False. Error message in human readable form that explains the reason for failure to proceed with the checkout (e.g. \"Sorry, somebody just bought the last of our amazing black T-shirts while you were busy filling out your payment details. Please choose a different color or garment!\"). Telegram will display this message to the user.",
        required: false
      }
    ],
    :boolean
  )
end
