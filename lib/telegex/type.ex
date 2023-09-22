defmodule Telegex.Type do
  @moduledoc "All types used in the Bot API responses."

  use Telegex.TypeDefiner

  @type error :: Telegex.Error.t() | Telegex.RequestError.t()

  defunion(
    ChatMember,
    "This object contains information about one member of a chat. Currently, the following 6 types of chat members are supported:",
    [
      Telegex.Type.ChatMemberOwner,
      Telegex.Type.ChatMemberAdministrator,
      Telegex.Type.ChatMemberMember,
      Telegex.Type.ChatMemberRestricted,
      Telegex.Type.ChatMemberLeft,
      Telegex.Type.ChatMemberBanned
    ],
    discriminant: %{
      field: :status,
      mapping: %{
        "administrator" => [Telegex.Type.ChatMemberAdministrator],
        "creator" => [Telegex.Type.ChatMemberOwner],
        "kicked" => [Telegex.Type.ChatMemberBanned],
        "left" => [Telegex.Type.ChatMemberLeft],
        "member" => [Telegex.Type.ChatMemberMember],
        "restricted" => [Telegex.Type.ChatMemberRestricted]
      }
    }
  )

  defunion(
    BotCommandScope,
    "This object represents the scope to which bot commands are applied. Currently, the following 7 scopes are supported:",
    [
      Telegex.Type.BotCommandScopeDefault,
      Telegex.Type.BotCommandScopeAllPrivateChats,
      Telegex.Type.BotCommandScopeAllGroupChats,
      Telegex.Type.BotCommandScopeAllChatAdministrators,
      Telegex.Type.BotCommandScopeChat,
      Telegex.Type.BotCommandScopeChatAdministrators,
      Telegex.Type.BotCommandScopeChatMember
    ],
    discriminant: %{
      field: :type,
      mapping: %{
        "all_chat_administrators" => [Telegex.Type.BotCommandScopeAllChatAdministrators],
        "all_group_chats" => [Telegex.Type.BotCommandScopeAllGroupChats],
        "all_private_chats" => [Telegex.Type.BotCommandScopeAllPrivateChats],
        "chat" => [Telegex.Type.BotCommandScopeChat],
        "chat_administrators" => [Telegex.Type.BotCommandScopeChatAdministrators],
        "chat_member" => [Telegex.Type.BotCommandScopeChatMember],
        "default" => [Telegex.Type.BotCommandScopeDefault]
      }
    }
  )

  defunion(
    MenuButton,
    "This object describes the bot's menu button in a private chat. It should be one of",
    [
      Telegex.Type.MenuButtonCommands,
      Telegex.Type.MenuButtonWebApp,
      Telegex.Type.MenuButtonDefault
    ],
    discriminant: %{
      field: :type,
      mapping: %{
        "commands" => [Telegex.Type.MenuButtonCommands],
        "default" => [Telegex.Type.MenuButtonDefault],
        "web_app" => [Telegex.Type.MenuButtonWebApp]
      }
    }
  )

  defunion(
    InputMedia,
    "This object represents the content of a media message to be sent. It should be one of",
    [
      Telegex.Type.InputMediaAnimation,
      Telegex.Type.InputMediaDocument,
      Telegex.Type.InputMediaAudio,
      Telegex.Type.InputMediaPhoto,
      Telegex.Type.InputMediaVideo
    ],
    discriminant: %{
      field: :type,
      mapping: %{
        "animation" => [Telegex.Type.InputMediaAnimation],
        "audio" => [Telegex.Type.InputMediaAudio],
        "document" => [Telegex.Type.InputMediaDocument],
        "photo" => [Telegex.Type.InputMediaPhoto],
        "video" => [Telegex.Type.InputMediaVideo]
      }
    }
  )

  defunion(
    InlineQueryResult,
    "This object represents one result of an inline query. Telegram clients currently support results of the following 20 types:",
    [
      Telegex.Type.InlineQueryResultCachedAudio,
      Telegex.Type.InlineQueryResultCachedDocument,
      Telegex.Type.InlineQueryResultCachedGif,
      Telegex.Type.InlineQueryResultCachedMpeg4Gif,
      Telegex.Type.InlineQueryResultCachedPhoto,
      Telegex.Type.InlineQueryResultCachedSticker,
      Telegex.Type.InlineQueryResultCachedVideo,
      Telegex.Type.InlineQueryResultCachedVoice,
      Telegex.Type.InlineQueryResultArticle,
      Telegex.Type.InlineQueryResultAudio,
      Telegex.Type.InlineQueryResultContact,
      Telegex.Type.InlineQueryResultGame,
      Telegex.Type.InlineQueryResultDocument,
      Telegex.Type.InlineQueryResultGif,
      Telegex.Type.InlineQueryResultLocation,
      Telegex.Type.InlineQueryResultMpeg4Gif,
      Telegex.Type.InlineQueryResultPhoto,
      Telegex.Type.InlineQueryResultVenue,
      Telegex.Type.InlineQueryResultVideo,
      Telegex.Type.InlineQueryResultVoice
    ],
    discriminant: %{
      field: :type,
      mapping: %{
        "article" => [Telegex.Type.InlineQueryResultArticle],
        "audio" => [
          Telegex.Type.InlineQueryResultCachedAudio,
          Telegex.Type.InlineQueryResultAudio
        ],
        "contact" => [Telegex.Type.InlineQueryResultContact],
        "document" => [
          Telegex.Type.InlineQueryResultCachedDocument,
          Telegex.Type.InlineQueryResultDocument
        ],
        "game" => [Telegex.Type.InlineQueryResultGame],
        "gif" => [Telegex.Type.InlineQueryResultCachedGif, Telegex.Type.InlineQueryResultGif],
        "location" => [Telegex.Type.InlineQueryResultLocation],
        "mpeg4_gif" => [
          Telegex.Type.InlineQueryResultCachedMpeg4Gif,
          Telegex.Type.InlineQueryResultMpeg4Gif
        ],
        "photo" => [
          Telegex.Type.InlineQueryResultCachedPhoto,
          Telegex.Type.InlineQueryResultPhoto
        ],
        "sticker" => [Telegex.Type.InlineQueryResultCachedSticker],
        "venue" => [Telegex.Type.InlineQueryResultVenue],
        "video" => [
          Telegex.Type.InlineQueryResultCachedVideo,
          Telegex.Type.InlineQueryResultVideo
        ],
        "voice" => [
          Telegex.Type.InlineQueryResultCachedVoice,
          Telegex.Type.InlineQueryResultVoice
        ]
      }
    }
  )

  defunion(
    InputMessageContent,
    "This object represents the content of a message to be sent as a result of an inline query. Telegram clients currently support the following 5 types:",
    [
      Telegex.Type.InputTextMessageContent,
      Telegex.Type.InputLocationMessageContent,
      Telegex.Type.InputVenueMessageContent,
      Telegex.Type.InputContactMessageContent,
      Telegex.Type.InputInvoiceMessageContent
    ],
    []
  )

  defunion(
    PassportElementError,
    "This object represents an error in the Telegram Passport element which was submitted that should be resolved by the user. It should be one of:",
    [
      Telegex.Type.PassportElementErrorDataField,
      Telegex.Type.PassportElementErrorFrontSide,
      Telegex.Type.PassportElementErrorReverseSide,
      Telegex.Type.PassportElementErrorSelfie,
      Telegex.Type.PassportElementErrorFile,
      Telegex.Type.PassportElementErrorFiles,
      Telegex.Type.PassportElementErrorTranslationFile,
      Telegex.Type.PassportElementErrorTranslationFiles,
      Telegex.Type.PassportElementErrorUnspecified
    ],
    discriminant: %{
      field: :source,
      mapping: %{
        "data" => [Telegex.Type.PassportElementErrorDataField],
        "file" => [Telegex.Type.PassportElementErrorFile],
        "files" => [Telegex.Type.PassportElementErrorFiles],
        "front_side" => [Telegex.Type.PassportElementErrorFrontSide],
        "reverse_side" => [Telegex.Type.PassportElementErrorReverseSide],
        "selfie" => [Telegex.Type.PassportElementErrorSelfie],
        "translation_file" => [Telegex.Type.PassportElementErrorTranslationFile],
        "translation_files" => [Telegex.Type.PassportElementErrorTranslationFiles],
        "unspecified" => [Telegex.Type.PassportElementErrorUnspecified]
      }
    }
  )

  deftype(Update, "This object represents an incoming update.
At most one of the optional parameters can be present in any given update.", [
    %{
      name: :update_id,
      type: :integer,
      description:
        "The update's unique identifier. Update identifiers start from a certain positive number and increase sequentially. This ID becomes especially handy if you're using webhooks, since it allows you to ignore repeated updates or to restore the correct update sequence, should they get out of order. If there are no new updates for at least a week, then identifier of the next update will be chosen randomly instead of sequentially.",
      optional: false
    },
    %{
      name: :message,
      type: Telegex.Type.Message,
      description: "Optional. New incoming message of any kind - text, photo, sticker, etc.",
      optional: true
    },
    %{
      name: :edited_message,
      type: Telegex.Type.Message,
      description: "Optional. New version of a message that is known to the bot and was edited",
      optional: true
    },
    %{
      name: :channel_post,
      type: Telegex.Type.Message,
      description: "Optional. New incoming channel post of any kind - text, photo, sticker, etc.",
      optional: true
    },
    %{
      name: :edited_channel_post,
      type: Telegex.Type.Message,
      description:
        "Optional. New version of a channel post that is known to the bot and was edited",
      optional: true
    },
    %{
      name: :inline_query,
      type: Telegex.Type.InlineQuery,
      description: "Optional. New incoming inline query",
      optional: true
    },
    %{
      name: :chosen_inline_result,
      type: Telegex.Type.ChosenInlineResult,
      description:
        "Optional. The result of an inline query that was chosen by a user and sent to their chat partner. Please see our documentation on the feedback collecting for details on how to enable these updates for your bot.",
      optional: true
    },
    %{
      name: :callback_query,
      type: Telegex.Type.CallbackQuery,
      description: "Optional. New incoming callback query",
      optional: true
    },
    %{
      name: :shipping_query,
      type: Telegex.Type.ShippingQuery,
      description: "Optional. New incoming shipping query. Only for invoices with flexible price",
      optional: true
    },
    %{
      name: :pre_checkout_query,
      type: Telegex.Type.PreCheckoutQuery,
      description:
        "Optional. New incoming pre-checkout query. Contains full information about checkout",
      optional: true
    },
    %{
      name: :poll,
      type: Telegex.Type.Poll,
      description:
        "Optional. New poll state. Bots receive only updates about stopped polls and polls, which are sent by the bot",
      optional: true
    },
    %{
      name: :poll_answer,
      type: Telegex.Type.PollAnswer,
      description:
        "Optional. A user changed their answer in a non-anonymous poll. Bots receive new votes only in polls that were sent by the bot itself.",
      optional: true
    },
    %{
      name: :my_chat_member,
      type: Telegex.Type.ChatMemberUpdated,
      description:
        "Optional. The bot's chat member status was updated in a chat. For private chats, this update is received only when the bot is blocked or unblocked by the user.",
      optional: true
    },
    %{
      name: :chat_member,
      type: Telegex.Type.ChatMemberUpdated,
      description:
        "Optional. A chat member's status was updated in a chat. The bot must be an administrator in the chat and must explicitly specify “chat_member” in the list of allowed_updates to receive these updates.",
      optional: true
    },
    %{
      name: :chat_join_request,
      type: Telegex.Type.ChatJoinRequest,
      description:
        "Optional. A request to join the chat has been sent. The bot must have the can_invite_users administrator right in the chat to receive these updates.",
      optional: true
    }
  ])

  deftype(WebhookInfo, "Describes the current status of a webhook.", [
    %{
      name: :url,
      type: :string,
      description: "Webhook URL, may be empty if webhook is not set up",
      optional: false
    },
    %{
      name: :has_custom_certificate,
      type: :boolean,
      description: "True, if a custom certificate was provided for webhook certificate checks",
      optional: false
    },
    %{
      name: :pending_update_count,
      type: :integer,
      description: "Number of updates awaiting delivery",
      optional: false
    },
    %{
      name: :ip_address,
      type: :string,
      description: "Optional. Currently used webhook IP address",
      optional: true
    },
    %{
      name: :last_error_date,
      type: :integer,
      description:
        "Optional. Unix time for the most recent error that happened when trying to deliver an update via webhook",
      optional: true
    },
    %{
      name: :last_error_message,
      type: :string,
      description:
        "Optional. Error message in human-readable format for the most recent error that happened when trying to deliver an update via webhook",
      optional: true
    },
    %{
      name: :last_synchronization_error_date,
      type: :integer,
      description:
        "Optional. Unix time of the most recent error that happened when trying to synchronize available updates with Telegram datacenters",
      optional: true
    },
    %{
      name: :max_connections,
      type: :integer,
      description:
        "Optional. The maximum allowed number of simultaneous HTTPS connections to the webhook for update delivery",
      optional: true
    },
    %{
      name: :allowed_updates,
      type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: :string},
      description:
        "Optional. A list of update types the bot is subscribed to. Defaults to all update types except chat_member",
      optional: true
    }
  ])

  deftype(User, "This object represents a Telegram user or bot.", [
    %{
      name: :id,
      type: :integer,
      description:
        "Unique identifier for this user or bot. This number may have more than 32 significant bits and some programming languages may have difficulty/silent defects in interpreting it. But it has at most 52 significant bits, so a 64-bit integer or double-precision float type are safe for storing this identifier.",
      optional: false
    },
    %{name: :is_bot, type: :boolean, description: "True, if this user is a bot", optional: false},
    %{
      name: :first_name,
      type: :string,
      description: "User's or bot's first name",
      optional: false
    },
    %{
      name: :last_name,
      type: :string,
      description: "Optional. User's or bot's last name",
      optional: true
    },
    %{
      name: :username,
      type: :string,
      description: "Optional. User's or bot's username",
      optional: true
    },
    %{
      name: :language_code,
      type: :string,
      description: "Optional. IETF language tag of the user's language",
      optional: true
    },
    %{
      name: :is_premium,
      type: :boolean,
      description: "Optional. True, if this user is a Telegram Premium user",
      optional: true
    },
    %{
      name: :added_to_attachment_menu,
      type: :boolean,
      description: "Optional. True, if this user added the bot to the attachment menu",
      optional: true
    },
    %{
      name: :can_join_groups,
      type: :boolean,
      description: "Optional. True, if the bot can be invited to groups. Returned only in getMe.",
      optional: true
    },
    %{
      name: :can_read_all_group_messages,
      type: :boolean,
      description:
        "Optional. True, if privacy mode is disabled for the bot. Returned only in getMe.",
      optional: true
    },
    %{
      name: :supports_inline_queries,
      type: :boolean,
      description: "Optional. True, if the bot supports inline queries. Returned only in getMe.",
      optional: true
    }
  ])

  deftype(Chat, "This object represents a chat.", [
    %{
      name: :id,
      type: :integer,
      description:
        "Unique identifier for this chat. This number may have more than 32 significant bits and some programming languages may have difficulty/silent defects in interpreting it. But it has at most 52 significant bits, so a signed 64-bit integer or double-precision float type are safe for storing this identifier.",
      optional: false
    },
    %{
      name: :type,
      type: :string,
      description: "Type of chat, can be either “private”, “group”, “supergroup” or “channel”",
      optional: false
    },
    %{
      name: :title,
      type: :string,
      description: "Optional. Title, for supergroups, channels and group chats",
      optional: true
    },
    %{
      name: :username,
      type: :string,
      description: "Optional. Username, for private chats, supergroups and channels if available",
      optional: true
    },
    %{
      name: :first_name,
      type: :string,
      description: "Optional. First name of the other party in a private chat",
      optional: true
    },
    %{
      name: :last_name,
      type: :string,
      description: "Optional. Last name of the other party in a private chat",
      optional: true
    },
    %{
      name: :is_forum,
      type: :boolean,
      description: "Optional. True, if the supergroup chat is a forum (has topics enabled)",
      optional: true
    },
    %{
      name: :photo,
      type: Telegex.Type.ChatPhoto,
      description: "Optional. Chat photo. Returned only in getChat.",
      optional: true
    },
    %{
      name: :active_usernames,
      type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: :string},
      description:
        "Optional. If non-empty, the list of all active chat usernames; for private chats, supergroups and channels. Returned only in getChat.",
      optional: true
    },
    %{
      name: :emoji_status_custom_emoji_id,
      type: :string,
      description:
        "Optional. Custom emoji identifier of emoji status of the other party in a private chat. Returned only in getChat.",
      optional: true
    },
    %{
      name: :emoji_status_expiration_date,
      type: :integer,
      description:
        "Optional. Expiration date of the emoji status of the other party in a private chat in Unix time, if any. Returned only in getChat.",
      optional: true
    },
    %{
      name: :bio,
      type: :string,
      description:
        "Optional. Bio of the other party in a private chat. Returned only in getChat.",
      optional: true
    },
    %{
      name: :has_private_forwards,
      type: :boolean,
      description:
        "Optional. True, if privacy settings of the other party in the private chat allows to use tg://user?id=<user_id> links only in chats with the user. Returned only in getChat.",
      optional: true
    },
    %{
      name: :has_restricted_voice_and_video_messages,
      type: :boolean,
      description:
        "Optional. True, if the privacy settings of the other party restrict sending voice and video note messages in the private chat. Returned only in getChat.",
      optional: true
    },
    %{
      name: :join_to_send_messages,
      type: :boolean,
      description:
        "Optional. True, if users need to join the supergroup before they can send messages. Returned only in getChat.",
      optional: true
    },
    %{
      name: :join_by_request,
      type: :boolean,
      description:
        "Optional. True, if all users directly joining the supergroup need to be approved by supergroup administrators. Returned only in getChat.",
      optional: true
    },
    %{
      name: :description,
      type: :string,
      description:
        "Optional. Description, for groups, supergroups and channel chats. Returned only in getChat.",
      optional: true
    },
    %{
      name: :invite_link,
      type: :string,
      description:
        "Optional. Primary invite link, for groups, supergroups and channel chats. Returned only in getChat.",
      optional: true
    },
    %{
      name: :pinned_message,
      type: Telegex.Type.Message,
      description:
        "Optional. The most recent pinned message (by sending date). Returned only in getChat.",
      optional: true
    },
    %{
      name: :permissions,
      type: Telegex.Type.ChatPermissions,
      description:
        "Optional. Default chat member permissions, for groups and supergroups. Returned only in getChat.",
      optional: true
    },
    %{
      name: :slow_mode_delay,
      type: :integer,
      description:
        "Optional. For supergroups, the minimum allowed delay between consecutive messages sent by each unpriviledged user; in seconds. Returned only in getChat.",
      optional: true
    },
    %{
      name: :message_auto_delete_time,
      type: :integer,
      description:
        "Optional. The time after which all messages sent to the chat will be automatically deleted; in seconds. Returned only in getChat.",
      optional: true
    },
    %{
      name: :has_aggressive_anti_spam_enabled,
      type: :boolean,
      description:
        "Optional. True, if aggressive anti-spam checks are enabled in the supergroup. The field is only available to chat administrators. Returned only in getChat.",
      optional: true
    },
    %{
      name: :has_hidden_members,
      type: :boolean,
      description:
        "Optional. True, if non-administrators can only get the list of bots and administrators in the chat. Returned only in getChat.",
      optional: true
    },
    %{
      name: :has_protected_content,
      type: :boolean,
      description:
        "Optional. True, if messages from the chat can't be forwarded to other chats. Returned only in getChat.",
      optional: true
    },
    %{
      name: :sticker_set_name,
      type: :string,
      description:
        "Optional. For supergroups, name of group sticker set. Returned only in getChat.",
      optional: true
    },
    %{
      name: :can_set_sticker_set,
      type: :boolean,
      description:
        "Optional. True, if the bot can change the group sticker set. Returned only in getChat.",
      optional: true
    },
    %{
      name: :linked_chat_id,
      type: :integer,
      description:
        "Optional. Unique identifier for the linked chat, i.e. the discussion group identifier for a channel and vice versa; for supergroups and channel chats. This identifier may be greater than 32 bits and some programming languages may have difficulty/silent defects in interpreting it. But it is smaller than 52 bits, so a signed 64 bit integer or double-precision float type are safe for storing this identifier. Returned only in getChat.",
      optional: true
    },
    %{
      name: :location,
      type: Telegex.Type.ChatLocation,
      description:
        "Optional. For supergroups, the location to which the supergroup is connected. Returned only in getChat.",
      optional: true
    }
  ])

  deftype(Message, "This object represents a message.", [
    %{
      name: :message_id,
      type: :integer,
      description: "Unique message identifier inside this chat",
      optional: false
    },
    %{
      name: :message_thread_id,
      type: :integer,
      description:
        "Optional. Unique identifier of a message thread to which the message belongs; for supergroups only",
      optional: true
    },
    %{
      name: :from,
      type: Telegex.Type.User,
      description:
        "Optional. Sender of the message; empty for messages sent to channels. For backward compatibility, the field contains a fake sender user in non-channel chats, if the message was sent on behalf of a chat.",
      optional: true
    },
    %{
      name: :sender_chat,
      type: Telegex.Type.Chat,
      description:
        "Optional. Sender of the message, sent on behalf of a chat. For example, the channel itself for channel posts, the supergroup itself for messages from anonymous group administrators, the linked channel for messages automatically forwarded to the discussion group. For backward compatibility, the field from contains a fake sender user in non-channel chats, if the message was sent on behalf of a chat.",
      optional: true
    },
    %{
      name: :date,
      type: :integer,
      description: "Date the message was sent in Unix time",
      optional: false
    },
    %{
      name: :chat,
      type: Telegex.Type.Chat,
      description: "Conversation the message belongs to",
      optional: false
    },
    %{
      name: :forward_from,
      type: Telegex.Type.User,
      description: "Optional. For forwarded messages, sender of the original message",
      optional: true
    },
    %{
      name: :forward_from_chat,
      type: Telegex.Type.Chat,
      description:
        "Optional. For messages forwarded from channels or from anonymous administrators, information about the original sender chat",
      optional: true
    },
    %{
      name: :forward_from_message_id,
      type: :integer,
      description:
        "Optional. For messages forwarded from channels, identifier of the original message in the channel",
      optional: true
    },
    %{
      name: :forward_signature,
      type: :string,
      description:
        "Optional. For forwarded messages that were originally sent in channels or by an anonymous chat administrator, signature of the message sender if present",
      optional: true
    },
    %{
      name: :forward_sender_name,
      type: :string,
      description:
        "Optional. Sender's name for messages forwarded from users who disallow adding a link to their account in forwarded messages",
      optional: true
    },
    %{
      name: :forward_date,
      type: :integer,
      description:
        "Optional. For forwarded messages, date the original message was sent in Unix time",
      optional: true
    },
    %{
      name: :is_topic_message,
      type: :boolean,
      description: "Optional. True, if the message is sent to a forum topic",
      optional: true
    },
    %{
      name: :is_automatic_forward,
      type: :boolean,
      description:
        "Optional. True, if the message is a channel post that was automatically forwarded to the connected discussion group",
      optional: true
    },
    %{
      name: :reply_to_message,
      type: Telegex.Type.Message,
      description:
        "Optional. For replies, the original message. Note that the Message object in this field will not contain further reply_to_message fields even if it itself is a reply.",
      optional: true
    },
    %{
      name: :via_bot,
      type: Telegex.Type.User,
      description: "Optional. Bot through which the message was sent",
      optional: true
    },
    %{
      name: :edit_date,
      type: :integer,
      description: "Optional. Date the message was last edited in Unix time",
      optional: true
    },
    %{
      name: :has_protected_content,
      type: :boolean,
      description: "Optional. True, if the message can't be forwarded",
      optional: true
    },
    %{
      name: :media_group_id,
      type: :string,
      description:
        "Optional. The unique identifier of a media message group this message belongs to",
      optional: true
    },
    %{
      name: :author_signature,
      type: :string,
      description:
        "Optional. Signature of the post author for messages in channels, or the custom title of an anonymous group administrator",
      optional: true
    },
    %{
      name: :text,
      type: :string,
      description: "Optional. For text messages, the actual UTF-8 text of the message",
      optional: true
    },
    %{
      name: :entities,
      type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity},
      description:
        "Optional. For text messages, special entities like usernames, URLs, bot commands, etc. that appear in the text",
      optional: true
    },
    %{
      name: :animation,
      type: Telegex.Type.Animation,
      description:
        "Optional. Message is an animation, information about the animation. For backward compatibility, when this field is set, the document field will also be set",
      optional: true
    },
    %{
      name: :audio,
      type: Telegex.Type.Audio,
      description: "Optional. Message is an audio file, information about the file",
      optional: true
    },
    %{
      name: :document,
      type: Telegex.Type.Document,
      description: "Optional. Message is a general file, information about the file",
      optional: true
    },
    %{
      name: :photo,
      type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.PhotoSize},
      description: "Optional. Message is a photo, available sizes of the photo",
      optional: true
    },
    %{
      name: :sticker,
      type: Telegex.Type.Sticker,
      description: "Optional. Message is a sticker, information about the sticker",
      optional: true
    },
    %{
      name: :story,
      type: Telegex.Type.Story,
      description: "Optional. Message is a forwarded story",
      optional: true
    },
    %{
      name: :video,
      type: Telegex.Type.Video,
      description: "Optional. Message is a video, information about the video",
      optional: true
    },
    %{
      name: :video_note,
      type: Telegex.Type.VideoNote,
      description: "Optional. Message is a video note, information about the video message",
      optional: true
    },
    %{
      name: :voice,
      type: Telegex.Type.Voice,
      description: "Optional. Message is a voice message, information about the file",
      optional: true
    },
    %{
      name: :caption,
      type: :string,
      description: "Optional. Caption for the animation, audio, document, photo, video or voice",
      optional: true
    },
    %{
      name: :caption_entities,
      type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity},
      description:
        "Optional. For messages with a caption, special entities like usernames, URLs, bot commands, etc. that appear in the caption",
      optional: true
    },
    %{
      name: :has_media_spoiler,
      type: :boolean,
      description: "Optional. True, if the message media is covered by a spoiler animation",
      optional: true
    },
    %{
      name: :contact,
      type: Telegex.Type.Contact,
      description: "Optional. Message is a shared contact, information about the contact",
      optional: true
    },
    %{
      name: :dice,
      type: Telegex.Type.Dice,
      description: "Optional. Message is a dice with random value",
      optional: true
    },
    %{
      name: :game,
      type: Telegex.Type.Game,
      description: "Optional. Message is a game, information about the game. More about games »",
      optional: true
    },
    %{
      name: :poll,
      type: Telegex.Type.Poll,
      description: "Optional. Message is a native poll, information about the poll",
      optional: true
    },
    %{
      name: :venue,
      type: Telegex.Type.Venue,
      description:
        "Optional. Message is a venue, information about the venue. For backward compatibility, when this field is set, the location field will also be set",
      optional: true
    },
    %{
      name: :location,
      type: Telegex.Type.Location,
      description: "Optional. Message is a shared location, information about the location",
      optional: true
    },
    %{
      name: :new_chat_members,
      type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.User},
      description:
        "Optional. New members that were added to the group or supergroup and information about them (the bot itself may be one of these members)",
      optional: true
    },
    %{
      name: :left_chat_member,
      type: Telegex.Type.User,
      description:
        "Optional. A member was removed from the group, information about them (this member may be the bot itself)",
      optional: true
    },
    %{
      name: :new_chat_title,
      type: :string,
      description: "Optional. A chat title was changed to this value",
      optional: true
    },
    %{
      name: :new_chat_photo,
      type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.PhotoSize},
      description: "Optional. A chat photo was change to this value",
      optional: true
    },
    %{
      name: :delete_chat_photo,
      type: :boolean,
      description: "Optional. Service message: the chat photo was deleted",
      optional: true
    },
    %{
      name: :group_chat_created,
      type: :boolean,
      description: "Optional. Service message: the group has been created",
      optional: true
    },
    %{
      name: :supergroup_chat_created,
      type: :boolean,
      description:
        "Optional. Service message: the supergroup has been created. This field can't be received in a message coming through updates, because bot can't be a member of a supergroup when it is created. It can only be found in reply_to_message if someone replies to a very first message in a directly created supergroup.",
      optional: true
    },
    %{
      name: :channel_chat_created,
      type: :boolean,
      description:
        "Optional. Service message: the channel has been created. This field can't be received in a message coming through updates, because bot can't be a member of a channel when it is created. It can only be found in reply_to_message if someone replies to a very first message in a channel.",
      optional: true
    },
    %{
      name: :message_auto_delete_timer_changed,
      type: Telegex.Type.MessageAutoDeleteTimerChanged,
      description: "Optional. Service message: auto-delete timer settings changed in the chat",
      optional: true
    },
    %{
      name: :migrate_to_chat_id,
      type: :integer,
      description:
        "Optional. The group has been migrated to a supergroup with the specified identifier. This number may have more than 32 significant bits and some programming languages may have difficulty/silent defects in interpreting it. But it has at most 52 significant bits, so a signed 64-bit integer or double-precision float type are safe for storing this identifier.",
      optional: true
    },
    %{
      name: :migrate_from_chat_id,
      type: :integer,
      description:
        "Optional. The supergroup has been migrated from a group with the specified identifier. This number may have more than 32 significant bits and some programming languages may have difficulty/silent defects in interpreting it. But it has at most 52 significant bits, so a signed 64-bit integer or double-precision float type are safe for storing this identifier.",
      optional: true
    },
    %{
      name: :pinned_message,
      type: Telegex.Type.Message,
      description:
        "Optional. Specified message was pinned. Note that the Message object in this field will not contain further reply_to_message fields even if it is itself a reply.",
      optional: true
    },
    %{
      name: :invoice,
      type: Telegex.Type.Invoice,
      description:
        "Optional. Message is an invoice for a payment, information about the invoice. More about payments »",
      optional: true
    },
    %{
      name: :successful_payment,
      type: Telegex.Type.SuccessfulPayment,
      description:
        "Optional. Message is a service message about a successful payment, information about the payment. More about payments »",
      optional: true
    },
    %{
      name: :user_shared,
      type: Telegex.Type.UserShared,
      description: "Optional. Service message: a user was shared with the bot",
      optional: true
    },
    %{
      name: :chat_shared,
      type: Telegex.Type.ChatShared,
      description: "Optional. Service message: a chat was shared with the bot",
      optional: true
    },
    %{
      name: :connected_website,
      type: :string,
      description:
        "Optional. The domain name of the website on which the user has logged in. More about Telegram Login »",
      optional: true
    },
    %{
      name: :write_access_allowed,
      type: Telegex.Type.WriteAccessAllowed,
      description:
        "Optional. Service message: the user allowed the bot to write messages after adding it to the attachment or side menu, launching a Web App from a link, or accepting an explicit request from a Web App sent by the method requestWriteAccess",
      optional: true
    },
    %{
      name: :passport_data,
      type: Telegex.Type.PassportData,
      description: "Optional. Telegram Passport data",
      optional: true
    },
    %{
      name: :proximity_alert_triggered,
      type: Telegex.Type.ProximityAlertTriggered,
      description:
        "Optional. Service message. A user in the chat triggered another user's proximity alert while sharing Live Location.",
      optional: true
    },
    %{
      name: :forum_topic_created,
      type: Telegex.Type.ForumTopicCreated,
      description: "Optional. Service message: forum topic created",
      optional: true
    },
    %{
      name: :forum_topic_edited,
      type: Telegex.Type.ForumTopicEdited,
      description: "Optional. Service message: forum topic edited",
      optional: true
    },
    %{
      name: :forum_topic_closed,
      type: Telegex.Type.ForumTopicClosed,
      description: "Optional. Service message: forum topic closed",
      optional: true
    },
    %{
      name: :forum_topic_reopened,
      type: Telegex.Type.ForumTopicReopened,
      description: "Optional. Service message: forum topic reopened",
      optional: true
    },
    %{
      name: :general_forum_topic_hidden,
      type: Telegex.Type.GeneralForumTopicHidden,
      description: "Optional. Service message: the 'General' forum topic hidden",
      optional: true
    },
    %{
      name: :general_forum_topic_unhidden,
      type: Telegex.Type.GeneralForumTopicUnhidden,
      description: "Optional. Service message: the 'General' forum topic unhidden",
      optional: true
    },
    %{
      name: :video_chat_scheduled,
      type: Telegex.Type.VideoChatScheduled,
      description: "Optional. Service message: video chat scheduled",
      optional: true
    },
    %{
      name: :video_chat_started,
      type: Telegex.Type.VideoChatStarted,
      description: "Optional. Service message: video chat started",
      optional: true
    },
    %{
      name: :video_chat_ended,
      type: Telegex.Type.VideoChatEnded,
      description: "Optional. Service message: video chat ended",
      optional: true
    },
    %{
      name: :video_chat_participants_invited,
      type: Telegex.Type.VideoChatParticipantsInvited,
      description: "Optional. Service message: new participants invited to a video chat",
      optional: true
    },
    %{
      name: :web_app_data,
      type: Telegex.Type.WebAppData,
      description: "Optional. Service message: data sent by a Web App",
      optional: true
    },
    %{
      name: :reply_markup,
      type: Telegex.Type.InlineKeyboardMarkup,
      description:
        "Optional. Inline keyboard attached to the message. login_url buttons are represented as ordinary url buttons.",
      optional: true
    }
  ])

  deftype(MessageId, "This object represents a unique message identifier.", [
    %{
      name: :message_id,
      type: :integer,
      description: "Unique message identifier",
      optional: false
    }
  ])

  deftype(
    MessageEntity,
    "This object represents one special entity in a text message. For example, hashtags, usernames, URLs, etc.",
    [
      %{
        name: :type,
        type: :string,
        description:
          "Type of the entity. Currently, can be “mention” (@username), “hashtag” (#hashtag), “cashtag” ($USD), “bot_command” (/start@jobs_bot), “url” (https://telegram.org), “email” (do-not-reply@telegram.org), “phone_number” (+1-212-555-0123), “bold” (bold text), “italic” (italic text), “underline” (underlined text), “strikethrough” (strikethrough text), “spoiler” (spoiler message), “code” (monowidth string), “pre” (monowidth block), “text_link” (for clickable text URLs), “text_mention” (for users without usernames), “custom_emoji” (for inline custom emoji stickers)",
        optional: false
      },
      %{
        name: :offset,
        type: :integer,
        description: "Offset in UTF-16 code units to the start of the entity",
        optional: false
      },
      %{
        name: :length,
        type: :integer,
        description: "Length of the entity in UTF-16 code units",
        optional: false
      },
      %{
        name: :url,
        type: :string,
        description:
          "Optional. For “text_link” only, URL that will be opened after user taps on the text",
        optional: true
      },
      %{
        name: :user,
        type: Telegex.Type.User,
        description: "Optional. For “text_mention” only, the mentioned user",
        optional: true
      },
      %{
        name: :language,
        type: :string,
        description: "Optional. For “pre” only, the programming language of the entity text",
        optional: true
      },
      %{
        name: :custom_emoji_id,
        type: :string,
        description:
          "Optional. For “custom_emoji” only, unique identifier of the custom emoji. Use getCustomEmojiStickers to get full information about the sticker",
        optional: true
      }
    ]
  )

  deftype(
    PhotoSize,
    "This object represents one size of a photo or a file / sticker thumbnail.",
    [
      %{
        name: :file_id,
        type: :string,
        description: "Identifier for this file, which can be used to download or reuse the file",
        optional: false
      },
      %{
        name: :file_unique_id,
        type: :string,
        description:
          "Unique identifier for this file, which is supposed to be the same over time and for different bots. Can't be used to download or reuse the file.",
        optional: false
      },
      %{name: :width, type: :integer, description: "Photo width", optional: false},
      %{name: :height, type: :integer, description: "Photo height", optional: false},
      %{
        name: :file_size,
        type: :integer,
        description: "Optional. File size in bytes",
        optional: true
      }
    ]
  )

  deftype(
    Animation,
    "This object represents an animation file (GIF or H.264/MPEG-4 AVC video without sound).",
    [
      %{
        name: :file_id,
        type: :string,
        description: "Identifier for this file, which can be used to download or reuse the file",
        optional: false
      },
      %{
        name: :file_unique_id,
        type: :string,
        description:
          "Unique identifier for this file, which is supposed to be the same over time and for different bots. Can't be used to download or reuse the file.",
        optional: false
      },
      %{
        name: :width,
        type: :integer,
        description: "Video width as defined by sender",
        optional: false
      },
      %{
        name: :height,
        type: :integer,
        description: "Video height as defined by sender",
        optional: false
      },
      %{
        name: :duration,
        type: :integer,
        description: "Duration of the video in seconds as defined by sender",
        optional: false
      },
      %{
        name: :thumbnail,
        type: Telegex.Type.PhotoSize,
        description: "Optional. Animation thumbnail as defined by sender",
        optional: true
      },
      %{
        name: :file_name,
        type: :string,
        description: "Optional. Original animation filename as defined by sender",
        optional: true
      },
      %{
        name: :mime_type,
        type: :string,
        description: "Optional. MIME type of the file as defined by sender",
        optional: true
      },
      %{
        name: :file_size,
        type: :integer,
        description:
          "Optional. File size in bytes. It can be bigger than 2^31 and some programming languages may have difficulty/silent defects in interpreting it. But it has at most 52 significant bits, so a signed 64-bit integer or double-precision float type are safe for storing this value.",
        optional: true
      }
    ]
  )

  deftype(
    Audio,
    "This object represents an audio file to be treated as music by the Telegram clients.",
    [
      %{
        name: :file_id,
        type: :string,
        description: "Identifier for this file, which can be used to download or reuse the file",
        optional: false
      },
      %{
        name: :file_unique_id,
        type: :string,
        description:
          "Unique identifier for this file, which is supposed to be the same over time and for different bots. Can't be used to download or reuse the file.",
        optional: false
      },
      %{
        name: :duration,
        type: :integer,
        description: "Duration of the audio in seconds as defined by sender",
        optional: false
      },
      %{
        name: :performer,
        type: :string,
        description: "Optional. Performer of the audio as defined by sender or by audio tags",
        optional: true
      },
      %{
        name: :title,
        type: :string,
        description: "Optional. Title of the audio as defined by sender or by audio tags",
        optional: true
      },
      %{
        name: :file_name,
        type: :string,
        description: "Optional. Original filename as defined by sender",
        optional: true
      },
      %{
        name: :mime_type,
        type: :string,
        description: "Optional. MIME type of the file as defined by sender",
        optional: true
      },
      %{
        name: :file_size,
        type: :integer,
        description:
          "Optional. File size in bytes. It can be bigger than 2^31 and some programming languages may have difficulty/silent defects in interpreting it. But it has at most 52 significant bits, so a signed 64-bit integer or double-precision float type are safe for storing this value.",
        optional: true
      },
      %{
        name: :thumbnail,
        type: Telegex.Type.PhotoSize,
        description: "Optional. Thumbnail of the album cover to which the music file belongs",
        optional: true
      }
    ]
  )

  deftype(
    Document,
    "This object represents a general file (as opposed to photos, voice messages and audio files).",
    [
      %{
        name: :file_id,
        type: :string,
        description: "Identifier for this file, which can be used to download or reuse the file",
        optional: false
      },
      %{
        name: :file_unique_id,
        type: :string,
        description:
          "Unique identifier for this file, which is supposed to be the same over time and for different bots. Can't be used to download or reuse the file.",
        optional: false
      },
      %{
        name: :thumbnail,
        type: Telegex.Type.PhotoSize,
        description: "Optional. Document thumbnail as defined by sender",
        optional: true
      },
      %{
        name: :file_name,
        type: :string,
        description: "Optional. Original filename as defined by sender",
        optional: true
      },
      %{
        name: :mime_type,
        type: :string,
        description: "Optional. MIME type of the file as defined by sender",
        optional: true
      },
      %{
        name: :file_size,
        type: :integer,
        description:
          "Optional. File size in bytes. It can be bigger than 2^31 and some programming languages may have difficulty/silent defects in interpreting it. But it has at most 52 significant bits, so a signed 64-bit integer or double-precision float type are safe for storing this value.",
        optional: true
      }
    ]
  )

  deftype(
    Story,
    "This object represents a message about a forwarded story in the chat. Currently holds no information.",
    []
  )

  deftype(Video, "This object represents a video file.", [
    %{
      name: :file_id,
      type: :string,
      description: "Identifier for this file, which can be used to download or reuse the file",
      optional: false
    },
    %{
      name: :file_unique_id,
      type: :string,
      description:
        "Unique identifier for this file, which is supposed to be the same over time and for different bots. Can't be used to download or reuse the file.",
      optional: false
    },
    %{
      name: :width,
      type: :integer,
      description: "Video width as defined by sender",
      optional: false
    },
    %{
      name: :height,
      type: :integer,
      description: "Video height as defined by sender",
      optional: false
    },
    %{
      name: :duration,
      type: :integer,
      description: "Duration of the video in seconds as defined by sender",
      optional: false
    },
    %{
      name: :thumbnail,
      type: Telegex.Type.PhotoSize,
      description: "Optional. Video thumbnail",
      optional: true
    },
    %{
      name: :file_name,
      type: :string,
      description: "Optional. Original filename as defined by sender",
      optional: true
    },
    %{
      name: :mime_type,
      type: :string,
      description: "Optional. MIME type of the file as defined by sender",
      optional: true
    },
    %{
      name: :file_size,
      type: :integer,
      description:
        "Optional. File size in bytes. It can be bigger than 2^31 and some programming languages may have difficulty/silent defects in interpreting it. But it has at most 52 significant bits, so a signed 64-bit integer or double-precision float type are safe for storing this value.",
      optional: true
    }
  ])

  deftype(
    VideoNote,
    "This object represents a video message (available in Telegram apps as of v.4.0).",
    [
      %{
        name: :file_id,
        type: :string,
        description: "Identifier for this file, which can be used to download or reuse the file",
        optional: false
      },
      %{
        name: :file_unique_id,
        type: :string,
        description:
          "Unique identifier for this file, which is supposed to be the same over time and for different bots. Can't be used to download or reuse the file.",
        optional: false
      },
      %{
        name: :length,
        type: :integer,
        description:
          "Video width and height (diameter of the video message) as defined by sender",
        optional: false
      },
      %{
        name: :duration,
        type: :integer,
        description: "Duration of the video in seconds as defined by sender",
        optional: false
      },
      %{
        name: :thumbnail,
        type: Telegex.Type.PhotoSize,
        description: "Optional. Video thumbnail",
        optional: true
      },
      %{
        name: :file_size,
        type: :integer,
        description: "Optional. File size in bytes",
        optional: true
      }
    ]
  )

  deftype(Voice, "This object represents a voice note.", [
    %{
      name: :file_id,
      type: :string,
      description: "Identifier for this file, which can be used to download or reuse the file",
      optional: false
    },
    %{
      name: :file_unique_id,
      type: :string,
      description:
        "Unique identifier for this file, which is supposed to be the same over time and for different bots. Can't be used to download or reuse the file.",
      optional: false
    },
    %{
      name: :duration,
      type: :integer,
      description: "Duration of the audio in seconds as defined by sender",
      optional: false
    },
    %{
      name: :mime_type,
      type: :string,
      description: "Optional. MIME type of the file as defined by sender",
      optional: true
    },
    %{
      name: :file_size,
      type: :integer,
      description:
        "Optional. File size in bytes. It can be bigger than 2^31 and some programming languages may have difficulty/silent defects in interpreting it. But it has at most 52 significant bits, so a signed 64-bit integer or double-precision float type are safe for storing this value.",
      optional: true
    }
  ])

  deftype(Contact, "This object represents a phone contact.", [
    %{name: :phone_number, type: :string, description: "Contact's phone number", optional: false},
    %{name: :first_name, type: :string, description: "Contact's first name", optional: false},
    %{
      name: :last_name,
      type: :string,
      description: "Optional. Contact's last name",
      optional: true
    },
    %{
      name: :user_id,
      type: :integer,
      description:
        "Optional. Contact's user identifier in Telegram. This number may have more than 32 significant bits and some programming languages may have difficulty/silent defects in interpreting it. But it has at most 52 significant bits, so a 64-bit integer or double-precision float type are safe for storing this identifier.",
      optional: true
    },
    %{
      name: :vcard,
      type: :string,
      description: "Optional. Additional data about the contact in the form of a vCard",
      optional: true
    }
  ])

  deftype(Dice, "This object represents an animated emoji that displays a random value.", [
    %{
      name: :emoji,
      type: :string,
      description: "Emoji on which the dice throw animation is based",
      optional: false
    },
    %{
      name: :value,
      type: :integer,
      description:
        "Value of the dice, 1-6 for “”, “” and “” base emoji, 1-5 for “” and “” base emoji, 1-64 for “” base emoji",
      optional: false
    }
  ])

  deftype(PollOption, "This object contains information about one answer option in a poll.", [
    %{name: :text, type: :string, description: "Option text, 1-100 characters", optional: false},
    %{
      name: :voter_count,
      type: :integer,
      description: "Number of users that voted for this option",
      optional: false
    }
  ])

  deftype(PollAnswer, "This object represents an answer of a user in a non-anonymous poll.", [
    %{name: :poll_id, type: :string, description: "Unique poll identifier", optional: false},
    %{
      name: :voter_chat,
      type: Telegex.Type.Chat,
      description:
        "Optional. The chat that changed the answer to the poll, if the voter is anonymous",
      optional: true
    },
    %{
      name: :user,
      type: Telegex.Type.User,
      description:
        "Optional. The user that changed the answer to the poll, if the voter isn't anonymous",
      optional: true
    },
    %{
      name: :option_ids,
      type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: :integer},
      description:
        "0-based identifiers of chosen answer options. May be empty if the vote was retracted.",
      optional: false
    }
  ])

  deftype(Poll, "This object contains information about a poll.", [
    %{name: :id, type: :string, description: "Unique poll identifier", optional: false},
    %{
      name: :question,
      type: :string,
      description: "Poll question, 1-300 characters",
      optional: false
    },
    %{
      name: :options,
      type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.PollOption},
      description: "List of poll options",
      optional: false
    },
    %{
      name: :total_voter_count,
      type: :integer,
      description: "Total number of users that voted in the poll",
      optional: false
    },
    %{
      name: :is_closed,
      type: :boolean,
      description: "True, if the poll is closed",
      optional: false
    },
    %{
      name: :is_anonymous,
      type: :boolean,
      description: "True, if the poll is anonymous",
      optional: false
    },
    %{
      name: :type,
      type: :string,
      description: "Poll type, currently can be “regular” or “quiz”",
      optional: false
    },
    %{
      name: :allows_multiple_answers,
      type: :boolean,
      description: "True, if the poll allows multiple answers",
      optional: false
    },
    %{
      name: :correct_option_id,
      type: :integer,
      description:
        "Optional. 0-based identifier of the correct answer option. Available only for polls in the quiz mode, which are closed, or was sent (not forwarded) by the bot or to the private chat with the bot.",
      optional: true
    },
    %{
      name: :explanation,
      type: :string,
      description:
        "Optional. Text that is shown when a user chooses an incorrect answer or taps on the lamp icon in a quiz-style poll, 0-200 characters",
      optional: true
    },
    %{
      name: :explanation_entities,
      type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity},
      description:
        "Optional. Special entities like usernames, URLs, bot commands, etc. that appear in the explanation",
      optional: true
    },
    %{
      name: :open_period,
      type: :integer,
      description: "Optional. Amount of time in seconds the poll will be active after creation",
      optional: true
    },
    %{
      name: :close_date,
      type: :integer,
      description:
        "Optional. Point in time (Unix timestamp) when the poll will be automatically closed",
      optional: true
    }
  ])

  deftype(Location, "This object represents a point on the map.", [
    %{
      name: :longitude,
      type: :float,
      description: "Longitude as defined by sender",
      optional: false
    },
    %{
      name: :latitude,
      type: :float,
      description: "Latitude as defined by sender",
      optional: false
    },
    %{
      name: :horizontal_accuracy,
      type: :float,
      description:
        "Optional. The radius of uncertainty for the location, measured in meters; 0-1500",
      optional: true
    },
    %{
      name: :live_period,
      type: :integer,
      description:
        "Optional. Time relative to the message sending date, during which the location can be updated; in seconds. For active live locations only.",
      optional: true
    },
    %{
      name: :heading,
      type: :integer,
      description:
        "Optional. The direction in which user is moving, in degrees; 1-360. For active live locations only.",
      optional: true
    },
    %{
      name: :proximity_alert_radius,
      type: :integer,
      description:
        "Optional. The maximum distance for proximity alerts about approaching another chat member, in meters. For sent live locations only.",
      optional: true
    }
  ])

  deftype(Venue, "This object represents a venue.", [
    %{
      name: :location,
      type: Telegex.Type.Location,
      description: "Venue location. Can't be a live location",
      optional: false
    },
    %{name: :title, type: :string, description: "Name of the venue", optional: false},
    %{name: :address, type: :string, description: "Address of the venue", optional: false},
    %{
      name: :foursquare_id,
      type: :string,
      description: "Optional. Foursquare identifier of the venue",
      optional: true
    },
    %{
      name: :foursquare_type,
      type: :string,
      description:
        "Optional. Foursquare type of the venue. (For example, “arts_entertainment/default”, “arts_entertainment/aquarium” or “food/icecream”.)",
      optional: true
    },
    %{
      name: :google_place_id,
      type: :string,
      description: "Optional. Google Places identifier of the venue",
      optional: true
    },
    %{
      name: :google_place_type,
      type: :string,
      description: "Optional. Google Places type of the venue. (See supported types.)",
      optional: true
    }
  ])

  deftype(WebAppData, "Describes data sent from a Web App to the bot.", [
    %{
      name: :data,
      type: :string,
      description: "The data. Be aware that a bad client can send arbitrary data in this field.",
      optional: false
    },
    %{
      name: :button_text,
      type: :string,
      description:
        "Text of the web_app keyboard button from which the Web App was opened. Be aware that a bad client can send arbitrary data in this field.",
      optional: false
    }
  ])

  deftype(
    ProximityAlertTriggered,
    "This object represents the content of a service message, sent whenever a user in the chat triggers a proximity alert set by another user.",
    [
      %{
        name: :traveler,
        type: Telegex.Type.User,
        description: "User that triggered the alert",
        optional: false
      },
      %{
        name: :watcher,
        type: Telegex.Type.User,
        description: "User that set the alert",
        optional: false
      },
      %{
        name: :distance,
        type: :integer,
        description: "The distance between the users",
        optional: false
      }
    ]
  )

  deftype(
    MessageAutoDeleteTimerChanged,
    "This object represents a service message about a change in auto-delete timer settings.",
    [
      %{
        name: :message_auto_delete_time,
        type: :integer,
        description: "New auto-delete time for messages in the chat; in seconds",
        optional: false
      }
    ]
  )

  deftype(
    ForumTopicCreated,
    "This object represents a service message about a new forum topic created in the chat.",
    [
      %{name: :name, type: :string, description: "Name of the topic", optional: false},
      %{
        name: :icon_color,
        type: :integer,
        description: "Color of the topic icon in RGB format",
        optional: false
      },
      %{
        name: :icon_custom_emoji_id,
        type: :string,
        description: "Optional. Unique identifier of the custom emoji shown as the topic icon",
        optional: true
      }
    ]
  )

  deftype(
    ForumTopicClosed,
    "This object represents a service message about a forum topic closed in the chat. Currently holds no information.",
    []
  )

  deftype(
    ForumTopicEdited,
    "This object represents a service message about an edited forum topic.",
    [
      %{
        name: :name,
        type: :string,
        description: "Optional. New name of the topic, if it was edited",
        optional: true
      },
      %{
        name: :icon_custom_emoji_id,
        type: :string,
        description:
          "Optional. New identifier of the custom emoji shown as the topic icon, if it was edited; an empty string if the icon was removed",
        optional: true
      }
    ]
  )

  deftype(
    ForumTopicReopened,
    "This object represents a service message about a forum topic reopened in the chat. Currently holds no information.",
    []
  )

  deftype(
    GeneralForumTopicHidden,
    "This object represents a service message about General forum topic hidden in the chat. Currently holds no information.",
    []
  )

  deftype(
    GeneralForumTopicUnhidden,
    "This object represents a service message about General forum topic unhidden in the chat. Currently holds no information.",
    []
  )

  deftype(
    UserShared,
    "This object contains information about the user whose identifier was shared with the bot using a KeyboardButtonRequestUser button.",
    [
      %{
        name: :request_id,
        type: :integer,
        description: "Identifier of the request",
        optional: false
      },
      %{
        name: :user_id,
        type: :integer,
        description:
          "Identifier of the shared user. This number may have more than 32 significant bits and some programming languages may have difficulty/silent defects in interpreting it. But it has at most 52 significant bits, so a 64-bit integer or double-precision float type are safe for storing this identifier. The bot may not have access to the user and could be unable to use this identifier, unless the user is already known to the bot by some other means.",
        optional: false
      }
    ]
  )

  deftype(
    ChatShared,
    "This object contains information about the chat whose identifier was shared with the bot using a KeyboardButtonRequestChat button.",
    [
      %{
        name: :request_id,
        type: :integer,
        description: "Identifier of the request",
        optional: false
      },
      %{
        name: :chat_id,
        type: :integer,
        description:
          "Identifier of the shared chat. This number may have more than 32 significant bits and some programming languages may have difficulty/silent defects in interpreting it. But it has at most 52 significant bits, so a 64-bit integer or double-precision float type are safe for storing this identifier. The bot may not have access to the chat and could be unable to use this identifier, unless the chat is already known to the bot by some other means.",
        optional: false
      }
    ]
  )

  deftype(
    WriteAccessAllowed,
    "This object represents a service message about a user allowing a bot to write messages after adding it to the attachment menu, launching a Web App from a link, or accepting an explicit request from a Web App sent by the method requestWriteAccess.",
    [
      %{
        name: :from_request,
        type: :boolean,
        description:
          "Optional. True, if the access was granted after the user accepted an explicit request from a Web App sent by the method requestWriteAccess",
        optional: true
      },
      %{
        name: :web_app_name,
        type: :string,
        description:
          "Optional. Name of the Web App, if the access was granted when the Web App was launched from a link",
        optional: true
      },
      %{
        name: :from_attachment_menu,
        type: :boolean,
        description:
          "Optional. True, if the access was granted when the bot was added to the attachment or side menu",
        optional: true
      }
    ]
  )

  deftype(
    VideoChatScheduled,
    "This object represents a service message about a video chat scheduled in the chat.",
    [
      %{
        name: :start_date,
        type: :integer,
        description:
          "Point in time (Unix timestamp) when the video chat is supposed to be started by a chat administrator",
        optional: false
      }
    ]
  )

  deftype(
    VideoChatStarted,
    "This object represents a service message about a video chat started in the chat. Currently holds no information.",
    []
  )

  deftype(
    VideoChatEnded,
    "This object represents a service message about a video chat ended in the chat.",
    [
      %{
        name: :duration,
        type: :integer,
        description: "Video chat duration in seconds",
        optional: false
      }
    ]
  )

  deftype(
    VideoChatParticipantsInvited,
    "This object represents a service message about new members invited to a video chat.",
    [
      %{
        name: :users,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.User},
        description: "New members that were invited to the video chat",
        optional: false
      }
    ]
  )

  deftype(UserProfilePhotos, "This object represent a user's profile pictures.", [
    %{
      name: :total_count,
      type: :integer,
      description: "Total number of profile pictures the target user has",
      optional: false
    },
    %{
      name: :photos,
      type: %{
        __struct__: Telegex.TypeDefiner.ArrayType,
        elem_type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.PhotoSize}
      },
      description: "Requested profile pictures (in up to 4 sizes each)",
      optional: false
    }
  ])

  deftype(
    File,
    "This object represents a file ready to be downloaded. The file can be downloaded via the link https://api.telegram.org/file/bot<token>/<file_path>. It is guaranteed that the link will be valid for at least 1 hour. When the link expires, a new one can be requested by calling getFile.",
    [
      %{
        name: :file_id,
        type: :string,
        description: "Identifier for this file, which can be used to download or reuse the file",
        optional: false
      },
      %{
        name: :file_unique_id,
        type: :string,
        description:
          "Unique identifier for this file, which is supposed to be the same over time and for different bots. Can't be used to download or reuse the file.",
        optional: false
      },
      %{
        name: :file_size,
        type: :integer,
        description:
          "Optional. File size in bytes. It can be bigger than 2^31 and some programming languages may have difficulty/silent defects in interpreting it. But it has at most 52 significant bits, so a signed 64-bit integer or double-precision float type are safe for storing this value.",
        optional: true
      },
      %{
        name: :file_path,
        type: :string,
        description:
          "Optional. File path. Use https://api.telegram.org/file/bot<token>/<file_path> to get the file.",
        optional: true
      }
    ]
  )

  deftype(WebAppInfo, "Describes a Web App.", [
    %{
      name: :url,
      type: :string,
      description:
        "An HTTPS URL of a Web App to be opened with additional data as specified in Initializing Web Apps",
      optional: false
    }
  ])

  deftype(
    ReplyKeyboardMarkup,
    "This object represents a custom keyboard with reply options (see Introduction to bots for details and examples).",
    [
      %{
        name: :keyboard,
        type: %{
          __struct__: Telegex.TypeDefiner.ArrayType,
          elem_type: %{
            __struct__: Telegex.TypeDefiner.ArrayType,
            elem_type: Telegex.Type.KeyboardButton
          }
        },
        description:
          "Array of button rows, each represented by an Array of KeyboardButton objects",
        optional: false
      },
      %{
        name: :is_persistent,
        type: :boolean,
        description:
          "Optional. Requests clients to always show the keyboard when the regular keyboard is hidden. Defaults to false, in which case the custom keyboard can be hidden and opened with a keyboard icon.",
        optional: true
      },
      %{
        name: :resize_keyboard,
        type: :boolean,
        description:
          "Optional. Requests clients to resize the keyboard vertically for optimal fit (e.g., make the keyboard smaller if there are just two rows of buttons). Defaults to false, in which case the custom keyboard is always of the same height as the app's standard keyboard.",
        optional: true
      },
      %{
        name: :one_time_keyboard,
        type: :boolean,
        description:
          "Optional. Requests clients to hide the keyboard as soon as it's been used. The keyboard will still be available, but clients will automatically display the usual letter-keyboard in the chat - the user can press a special button in the input field to see the custom keyboard again. Defaults to false.",
        optional: true
      },
      %{
        name: :input_field_placeholder,
        type: :string,
        description:
          "Optional. The placeholder to be shown in the input field when the keyboard is active; 1-64 characters",
        optional: true
      },
      %{
        name: :selective,
        type: :boolean,
        description:
          "Optional. Use this parameter if you want to show the keyboard to specific users only. Targets: 1) users that are @mentioned in the text of the Message object; 2) if the bot's message is a reply (has reply_to_message_id), sender of the original message.\n\nExample: A user requests to change the bot's language, bot replies to the request with a keyboard to select the new language. Other users in the group don't see the keyboard.",
        optional: true
      }
    ]
  )

  deftype(
    KeyboardButton,
    "This object represents one button of the reply keyboard. For simple text buttons, String can be used instead of this object to specify the button text. The optional fields web_app, request_user, request_chat, request_contact, request_location, and request_poll are mutually exclusive.",
    [
      %{
        name: :text,
        type: :string,
        description:
          "Text of the button. If none of the optional fields are used, it will be sent as a message when the button is pressed",
        optional: false
      },
      %{
        name: :request_user,
        type: Telegex.Type.KeyboardButtonRequestUser,
        description:
          "Optional. If specified, pressing the button will open a list of suitable users. Tapping on any user will send their identifier to the bot in a “user_shared” service message. Available in private chats only.",
        optional: true
      },
      %{
        name: :request_chat,
        type: Telegex.Type.KeyboardButtonRequestChat,
        description:
          "Optional. If specified, pressing the button will open a list of suitable chats. Tapping on a chat will send its identifier to the bot in a “chat_shared” service message. Available in private chats only.",
        optional: true
      },
      %{
        name: :request_contact,
        type: :boolean,
        description:
          "Optional. If True, the user's phone number will be sent as a contact when the button is pressed. Available in private chats only.",
        optional: true
      },
      %{
        name: :request_location,
        type: :boolean,
        description:
          "Optional. If True, the user's current location will be sent when the button is pressed. Available in private chats only.",
        optional: true
      },
      %{
        name: :request_poll,
        type: Telegex.Type.KeyboardButtonPollType,
        description:
          "Optional. If specified, the user will be asked to create a poll and send it to the bot when the button is pressed. Available in private chats only.",
        optional: true
      },
      %{
        name: :web_app,
        type: Telegex.Type.WebAppInfo,
        description:
          "Optional. If specified, the described Web App will be launched when the button is pressed. The Web App will be able to send a “web_app_data” service message. Available in private chats only.",
        optional: true
      }
    ]
  )

  deftype(
    KeyboardButtonRequestUser,
    "This object defines the criteria used to request a suitable user. The identifier of the selected user will be shared with the bot when the corresponding button is pressed. More about requesting users »",
    [
      %{
        name: :request_id,
        type: :integer,
        description:
          "Signed 32-bit identifier of the request, which will be received back in the UserShared object. Must be unique within the message",
        optional: false
      },
      %{
        name: :user_is_bot,
        type: :boolean,
        description:
          "Optional. Pass True to request a bot, pass False to request a regular user. If not specified, no additional restrictions are applied.",
        optional: true
      },
      %{
        name: :user_is_premium,
        type: :boolean,
        description:
          "Optional. Pass True to request a premium user, pass False to request a non-premium user. If not specified, no additional restrictions are applied.",
        optional: true
      }
    ]
  )

  deftype(
    KeyboardButtonRequestChat,
    "This object defines the criteria used to request a suitable chat. The identifier of the selected chat will be shared with the bot when the corresponding button is pressed. More about requesting chats »",
    [
      %{
        name: :request_id,
        type: :integer,
        description:
          "Signed 32-bit identifier of the request, which will be received back in the ChatShared object. Must be unique within the message",
        optional: false
      },
      %{
        name: :chat_is_channel,
        type: :boolean,
        description:
          "Pass True to request a channel chat, pass False to request a group or a supergroup chat.",
        optional: false
      },
      %{
        name: :chat_is_forum,
        type: :boolean,
        description:
          "Optional. Pass True to request a forum supergroup, pass False to request a non-forum chat. If not specified, no additional restrictions are applied.",
        optional: true
      },
      %{
        name: :chat_has_username,
        type: :boolean,
        description:
          "Optional. Pass True to request a supergroup or a channel with a username, pass False to request a chat without a username. If not specified, no additional restrictions are applied.",
        optional: true
      },
      %{
        name: :chat_is_created,
        type: :boolean,
        description:
          "Optional. Pass True to request a chat owned by the user. Otherwise, no additional restrictions are applied.",
        optional: true
      },
      %{
        name: :user_administrator_rights,
        type: Telegex.Type.ChatAdministratorRights,
        description:
          "Optional. A JSON-serialized object listing the required administrator rights of the user in the chat. The rights must be a superset of bot_administrator_rights. If not specified, no additional restrictions are applied.",
        optional: true
      },
      %{
        name: :bot_administrator_rights,
        type: Telegex.Type.ChatAdministratorRights,
        description:
          "Optional. A JSON-serialized object listing the required administrator rights of the bot in the chat. The rights must be a subset of user_administrator_rights. If not specified, no additional restrictions are applied.",
        optional: true
      },
      %{
        name: :bot_is_member,
        type: :boolean,
        description:
          "Optional. Pass True to request a chat with the bot as a member. Otherwise, no additional restrictions are applied.",
        optional: true
      }
    ]
  )

  deftype(
    KeyboardButtonPollType,
    "This object represents type of a poll, which is allowed to be created and sent when the corresponding button is pressed.",
    [
      %{
        name: :type,
        type: :string,
        description:
          "Optional. If quiz is passed, the user will be allowed to create only polls in the quiz mode. If regular is passed, only regular polls will be allowed. Otherwise, the user will be allowed to create a poll of any type.",
        optional: true
      }
    ]
  )

  deftype(
    ReplyKeyboardRemove,
    "Upon receiving a message with this object, Telegram clients will remove the current custom keyboard and display the default letter-keyboard. By default, custom keyboards are displayed until a new keyboard is sent by a bot. An exception is made for one-time keyboards that are hidden immediately after the user presses a button (see ReplyKeyboardMarkup).",
    [
      %{
        name: :remove_keyboard,
        type: :boolean,
        description:
          "Requests clients to remove the custom keyboard (user will not be able to summon this keyboard; if you want to hide the keyboard from sight but keep it accessible, use one_time_keyboard in ReplyKeyboardMarkup)",
        optional: false
      },
      %{
        name: :selective,
        type: :boolean,
        description:
          "Optional. Use this parameter if you want to remove the keyboard for specific users only. Targets: 1) users that are @mentioned in the text of the Message object; 2) if the bot's message is a reply (has reply_to_message_id), sender of the original message.\n\nExample: A user votes in a poll, bot returns confirmation message in reply to the vote and removes the keyboard for that user, while still showing the keyboard with poll options to users who haven't voted yet.",
        optional: true
      }
    ]
  )

  deftype(
    InlineKeyboardMarkup,
    "This object represents an inline keyboard that appears right next to the message it belongs to.",
    [
      %{
        name: :inline_keyboard,
        type: %{
          __struct__: Telegex.TypeDefiner.ArrayType,
          elem_type: %{
            __struct__: Telegex.TypeDefiner.ArrayType,
            elem_type: Telegex.Type.InlineKeyboardButton
          }
        },
        description:
          "Array of button rows, each represented by an Array of InlineKeyboardButton objects",
        optional: false
      }
    ]
  )

  deftype(
    InlineKeyboardButton,
    "This object represents one button of an inline keyboard. You must use exactly one of the optional fields.",
    [
      %{name: :text, type: :string, description: "Label text on the button", optional: false},
      %{
        name: :url,
        type: :string,
        description:
          "Optional. HTTP or tg:// URL to be opened when the button is pressed. Links tg://user?id=<user_id> can be used to mention a user by their ID without using a username, if this is allowed by their privacy settings.",
        optional: true
      },
      %{
        name: :callback_data,
        type: :string,
        description:
          "Optional. Data to be sent in a callback query to the bot when button is pressed, 1-64 bytes",
        optional: true
      },
      %{
        name: :web_app,
        type: Telegex.Type.WebAppInfo,
        description:
          "Optional. Description of the Web App that will be launched when the user presses the button. The Web App will be able to send an arbitrary message on behalf of the user using the method answerWebAppQuery. Available only in private chats between a user and the bot.",
        optional: true
      },
      %{
        name: :login_url,
        type: Telegex.Type.LoginUrl,
        description:
          "Optional. An HTTPS URL used to automatically authorize the user. Can be used as a replacement for the Telegram Login Widget.",
        optional: true
      },
      %{
        name: :switch_inline_query,
        type: :string,
        description:
          "Optional. If set, pressing the button will prompt the user to select one of their chats, open that chat and insert the bot's username and the specified inline query in the input field. May be empty, in which case just the bot's username will be inserted.",
        optional: true
      },
      %{
        name: :switch_inline_query_current_chat,
        type: :string,
        description:
          "Optional. If set, pressing the button will insert the bot's username and the specified inline query in the current chat's input field. May be empty, in which case only the bot's username will be inserted.\n\nThis offers a quick way for the user to open your bot in inline mode in the same chat - good for selecting something from multiple options.",
        optional: true
      },
      %{
        name: :switch_inline_query_chosen_chat,
        type: Telegex.Type.SwitchInlineQueryChosenChat,
        description:
          "Optional. If set, pressing the button will prompt the user to select one of their chats of the specified type, open that chat and insert the bot's username and the specified inline query in the input field",
        optional: true
      },
      %{
        name: :callback_game,
        type: Telegex.Type.CallbackGame,
        description:
          "Optional. Description of the game that will be launched when the user presses the button.\n\nNOTE: This type of button must always be the first button in the first row.",
        optional: true
      },
      %{
        name: :pay,
        type: :boolean,
        description:
          "Optional. Specify True, to send a Pay button.\n\nNOTE: This type of button must always be the first button in the first row and can only be used in invoice messages.",
        optional: true
      }
    ]
  )

  deftype(
    LoginUrl,
    "This object represents a parameter of the inline keyboard button used to automatically authorize a user. Serves as a great replacement for the Telegram Login Widget when the user is coming from Telegram. All the user needs to do is tap/click a button and confirm that they want to log in:",
    [
      %{
        name: :url,
        type: :string,
        description:
          "An HTTPS URL to be opened with user authorization data added to the query string when the button is pressed. If the user refuses to provide authorization data, the original URL without information about the user will be opened. The data added is the same as described in Receiving authorization data.\n\nNOTE: You must always check the hash of the received data to verify the authentication and the integrity of the data as described in Checking authorization.",
        optional: false
      },
      %{
        name: :forward_text,
        type: :string,
        description: "Optional. New text of the button in forwarded messages.",
        optional: true
      },
      %{
        name: :bot_username,
        type: :string,
        description:
          "Optional. Username of a bot, which will be used for user authorization. See Setting up a bot for more details. If not specified, the current bot's username will be assumed. The url's domain must be the same as the domain linked with the bot. See Linking your domain to the bot for more details.",
        optional: true
      },
      %{
        name: :request_write_access,
        type: :boolean,
        description:
          "Optional. Pass True to request the permission for your bot to send messages to the user.",
        optional: true
      }
    ]
  )

  deftype(
    SwitchInlineQueryChosenChat,
    "This object represents an inline button that switches the current user to inline mode in a chosen chat, with an optional default inline query.",
    [
      %{
        name: :query,
        type: :string,
        description:
          "Optional. The default inline query to be inserted in the input field. If left empty, only the bot's username will be inserted",
        optional: true
      },
      %{
        name: :allow_user_chats,
        type: :boolean,
        description: "Optional. True, if private chats with users can be chosen",
        optional: true
      },
      %{
        name: :allow_bot_chats,
        type: :boolean,
        description: "Optional. True, if private chats with bots can be chosen",
        optional: true
      },
      %{
        name: :allow_group_chats,
        type: :boolean,
        description: "Optional. True, if group and supergroup chats can be chosen",
        optional: true
      },
      %{
        name: :allow_channel_chats,
        type: :boolean,
        description: "Optional. True, if channel chats can be chosen",
        optional: true
      }
    ]
  )

  deftype(
    CallbackQuery,
    "This object represents an incoming callback query from a callback button in an inline keyboard. If the button that originated the query was attached to a message sent by the bot, the field message will be present. If the button was attached to a message sent via the bot (in inline mode), the field inline_message_id will be present. Exactly one of the fields data or game_short_name will be present.",
    [
      %{
        name: :id,
        type: :string,
        description: "Unique identifier for this query",
        optional: false
      },
      %{name: :from, type: Telegex.Type.User, description: "Sender", optional: false},
      %{
        name: :message,
        type: Telegex.Type.Message,
        description:
          "Optional. Message with the callback button that originated the query. Note that message content and message date will not be available if the message is too old",
        optional: true
      },
      %{
        name: :inline_message_id,
        type: :string,
        description:
          "Optional. Identifier of the message sent via the bot in inline mode, that originated the query.",
        optional: true
      },
      %{
        name: :chat_instance,
        type: :string,
        description:
          "Global identifier, uniquely corresponding to the chat to which the message with the callback button was sent. Useful for high scores in games.",
        optional: false
      },
      %{
        name: :data,
        type: :string,
        description:
          "Optional. Data associated with the callback button. Be aware that the message originated the query can contain no callback buttons with this data.",
        optional: true
      },
      %{
        name: :game_short_name,
        type: :string,
        description:
          "Optional. Short name of a Game to be returned, serves as the unique identifier for the game",
        optional: true
      }
    ]
  )

  deftype(
    ForceReply,
    "Upon receiving a message with this object, Telegram clients will display a reply interface to the user (act as if the user has selected the bot's message and tapped 'Reply'). This can be extremely useful if you want to create user-friendly step-by-step interfaces without having to sacrifice privacy mode.",
    [
      %{
        name: :force_reply,
        type: :boolean,
        description:
          "Shows reply interface to the user, as if they manually selected the bot's message and tapped 'Reply'",
        optional: false
      },
      %{
        name: :input_field_placeholder,
        type: :string,
        description:
          "Optional. The placeholder to be shown in the input field when the reply is active; 1-64 characters",
        optional: true
      },
      %{
        name: :selective,
        type: :boolean,
        description:
          "Optional. Use this parameter if you want to force reply from specific users only. Targets: 1) users that are @mentioned in the text of the Message object; 2) if the bot's message is a reply (has reply_to_message_id), sender of the original message.",
        optional: true
      }
    ]
  )

  deftype(ChatPhoto, "This object represents a chat photo.", [
    %{
      name: :small_file_id,
      type: :string,
      description:
        "File identifier of small (160x160) chat photo. This file_id can be used only for photo download and only for as long as the photo is not changed.",
      optional: false
    },
    %{
      name: :small_file_unique_id,
      type: :string,
      description:
        "Unique file identifier of small (160x160) chat photo, which is supposed to be the same over time and for different bots. Can't be used to download or reuse the file.",
      optional: false
    },
    %{
      name: :big_file_id,
      type: :string,
      description:
        "File identifier of big (640x640) chat photo. This file_id can be used only for photo download and only for as long as the photo is not changed.",
      optional: false
    },
    %{
      name: :big_file_unique_id,
      type: :string,
      description:
        "Unique file identifier of big (640x640) chat photo, which is supposed to be the same over time and for different bots. Can't be used to download or reuse the file.",
      optional: false
    }
  ])

  deftype(ChatInviteLink, "Represents an invite link for a chat.", [
    %{
      name: :invite_link,
      type: :string,
      description:
        "The invite link. If the link was created by another chat administrator, then the second part of the link will be replaced with “…”.",
      optional: false
    },
    %{
      name: :creator,
      type: Telegex.Type.User,
      description: "Creator of the link",
      optional: false
    },
    %{
      name: :creates_join_request,
      type: :boolean,
      description:
        "True, if users joining the chat via the link need to be approved by chat administrators",
      optional: false
    },
    %{
      name: :is_primary,
      type: :boolean,
      description: "True, if the link is primary",
      optional: false
    },
    %{
      name: :is_revoked,
      type: :boolean,
      description: "True, if the link is revoked",
      optional: false
    },
    %{name: :name, type: :string, description: "Optional. Invite link name", optional: true},
    %{
      name: :expire_date,
      type: :integer,
      description:
        "Optional. Point in time (Unix timestamp) when the link will expire or has been expired",
      optional: true
    },
    %{
      name: :member_limit,
      type: :integer,
      description:
        "Optional. The maximum number of users that can be members of the chat simultaneously after joining the chat via this invite link; 1-99999",
      optional: true
    },
    %{
      name: :pending_join_request_count,
      type: :integer,
      description: "Optional. Number of pending join requests created using this link",
      optional: true
    }
  ])

  deftype(ChatAdministratorRights, "Represents the rights of an administrator in a chat.", [
    %{
      name: :is_anonymous,
      type: :boolean,
      description: "True, if the user's presence in the chat is hidden",
      optional: false
    },
    %{
      name: :can_manage_chat,
      type: :boolean,
      description:
        "True, if the administrator can access the chat event log, chat statistics, boost list in channels, message statistics in channels, see channel members, see anonymous administrators in supergroups and ignore slow mode. Implied by any other administrator privilege",
      optional: false
    },
    %{
      name: :can_delete_messages,
      type: :boolean,
      description: "True, if the administrator can delete messages of other users",
      optional: false
    },
    %{
      name: :can_manage_video_chats,
      type: :boolean,
      description: "True, if the administrator can manage video chats",
      optional: false
    },
    %{
      name: :can_restrict_members,
      type: :boolean,
      description: "True, if the administrator can restrict, ban or unban chat members",
      optional: false
    },
    %{
      name: :can_promote_members,
      type: :boolean,
      description:
        "True, if the administrator can add new administrators with a subset of their own privileges or demote administrators that they have promoted, directly or indirectly (promoted by administrators that were appointed by the user)",
      optional: false
    },
    %{
      name: :can_change_info,
      type: :boolean,
      description:
        "True, if the user is allowed to change the chat title, photo and other settings",
      optional: false
    },
    %{
      name: :can_invite_users,
      type: :boolean,
      description: "True, if the user is allowed to invite new users to the chat",
      optional: false
    },
    %{
      name: :can_post_messages,
      type: :boolean,
      description:
        "Optional. True, if the administrator can post messages in the channel; channels only",
      optional: true
    },
    %{
      name: :can_edit_messages,
      type: :boolean,
      description:
        "Optional. True, if the administrator can edit messages of other users and can pin messages; channels only",
      optional: true
    },
    %{
      name: :can_pin_messages,
      type: :boolean,
      description:
        "Optional. True, if the user is allowed to pin messages; groups and supergroups only",
      optional: true
    },
    %{
      name: :can_post_stories,
      type: :boolean,
      description:
        "Optional. True, if the administrator can post stories in the channel; channels only",
      optional: true
    },
    %{
      name: :can_edit_stories,
      type: :boolean,
      description:
        "Optional. True, if the administrator can edit stories posted by other users; channels only",
      optional: true
    },
    %{
      name: :can_delete_stories,
      type: :boolean,
      description:
        "Optional. True, if the administrator can delete stories posted by other users; channels only",
      optional: true
    },
    %{
      name: :can_manage_topics,
      type: :boolean,
      description:
        "Optional. True, if the user is allowed to create, rename, close, and reopen forum topics; supergroups only",
      optional: true
    }
  ])

  deftype(
    ChatMemberOwner,
    "Represents a chat member that owns the chat and has all administrator privileges.",
    [
      %{
        name: :status,
        type: :string,
        description: "The member's status in the chat, always “creator”",
        optional: false
      },
      %{
        name: :user,
        type: Telegex.Type.User,
        description: "Information about the user",
        optional: false
      },
      %{
        name: :is_anonymous,
        type: :boolean,
        description: "True, if the user's presence in the chat is hidden",
        optional: false
      },
      %{
        name: :custom_title,
        type: :string,
        description: "Optional. Custom title for this user",
        optional: true
      }
    ]
  )

  deftype(
    ChatMemberAdministrator,
    "Represents a chat member that has some additional privileges.",
    [
      %{
        name: :status,
        type: :string,
        description: "The member's status in the chat, always “administrator”",
        optional: false
      },
      %{
        name: :user,
        type: Telegex.Type.User,
        description: "Information about the user",
        optional: false
      },
      %{
        name: :can_be_edited,
        type: :boolean,
        description: "True, if the bot is allowed to edit administrator privileges of that user",
        optional: false
      },
      %{
        name: :is_anonymous,
        type: :boolean,
        description: "True, if the user's presence in the chat is hidden",
        optional: false
      },
      %{
        name: :can_manage_chat,
        type: :boolean,
        description:
          "True, if the administrator can access the chat event log, chat statistics, boost list in channels, message statistics in channels, see channel members, see anonymous administrators in supergroups and ignore slow mode. Implied by any other administrator privilege",
        optional: false
      },
      %{
        name: :can_delete_messages,
        type: :boolean,
        description: "True, if the administrator can delete messages of other users",
        optional: false
      },
      %{
        name: :can_manage_video_chats,
        type: :boolean,
        description: "True, if the administrator can manage video chats",
        optional: false
      },
      %{
        name: :can_restrict_members,
        type: :boolean,
        description: "True, if the administrator can restrict, ban or unban chat members",
        optional: false
      },
      %{
        name: :can_promote_members,
        type: :boolean,
        description:
          "True, if the administrator can add new administrators with a subset of their own privileges or demote administrators that they have promoted, directly or indirectly (promoted by administrators that were appointed by the user)",
        optional: false
      },
      %{
        name: :can_change_info,
        type: :boolean,
        description:
          "True, if the user is allowed to change the chat title, photo and other settings",
        optional: false
      },
      %{
        name: :can_invite_users,
        type: :boolean,
        description: "True, if the user is allowed to invite new users to the chat",
        optional: false
      },
      %{
        name: :can_post_messages,
        type: :boolean,
        description:
          "Optional. True, if the administrator can post messages in the channel; channels only",
        optional: true
      },
      %{
        name: :can_edit_messages,
        type: :boolean,
        description:
          "Optional. True, if the administrator can edit messages of other users and can pin messages; channels only",
        optional: true
      },
      %{
        name: :can_pin_messages,
        type: :boolean,
        description:
          "Optional. True, if the user is allowed to pin messages; groups and supergroups only",
        optional: true
      },
      %{
        name: :can_post_stories,
        type: :boolean,
        description:
          "Optional. True, if the administrator can post stories in the channel; channels only",
        optional: true
      },
      %{
        name: :can_edit_stories,
        type: :boolean,
        description:
          "Optional. True, if the administrator can edit stories posted by other users; channels only",
        optional: true
      },
      %{
        name: :can_delete_stories,
        type: :boolean,
        description:
          "Optional. True, if the administrator can delete stories posted by other users; channels only",
        optional: true
      },
      %{
        name: :can_manage_topics,
        type: :boolean,
        description:
          "Optional. True, if the user is allowed to create, rename, close, and reopen forum topics; supergroups only",
        optional: true
      },
      %{
        name: :custom_title,
        type: :string,
        description: "Optional. Custom title for this user",
        optional: true
      }
    ]
  )

  deftype(
    ChatMemberMember,
    "Represents a chat member that has no additional privileges or restrictions.",
    [
      %{
        name: :status,
        type: :string,
        description: "The member's status in the chat, always “member”",
        optional: false
      },
      %{
        name: :user,
        type: Telegex.Type.User,
        description: "Information about the user",
        optional: false
      }
    ]
  )

  deftype(
    ChatMemberRestricted,
    "Represents a chat member that is under certain restrictions in the chat. Supergroups only.",
    [
      %{
        name: :status,
        type: :string,
        description: "The member's status in the chat, always “restricted”",
        optional: false
      },
      %{
        name: :user,
        type: Telegex.Type.User,
        description: "Information about the user",
        optional: false
      },
      %{
        name: :is_member,
        type: :boolean,
        description: "True, if the user is a member of the chat at the moment of the request",
        optional: false
      },
      %{
        name: :can_send_messages,
        type: :boolean,
        description:
          "True, if the user is allowed to send text messages, contacts, invoices, locations and venues",
        optional: false
      },
      %{
        name: :can_send_audios,
        type: :boolean,
        description: "True, if the user is allowed to send audios",
        optional: false
      },
      %{
        name: :can_send_documents,
        type: :boolean,
        description: "True, if the user is allowed to send documents",
        optional: false
      },
      %{
        name: :can_send_photos,
        type: :boolean,
        description: "True, if the user is allowed to send photos",
        optional: false
      },
      %{
        name: :can_send_videos,
        type: :boolean,
        description: "True, if the user is allowed to send videos",
        optional: false
      },
      %{
        name: :can_send_video_notes,
        type: :boolean,
        description: "True, if the user is allowed to send video notes",
        optional: false
      },
      %{
        name: :can_send_voice_notes,
        type: :boolean,
        description: "True, if the user is allowed to send voice notes",
        optional: false
      },
      %{
        name: :can_send_polls,
        type: :boolean,
        description: "True, if the user is allowed to send polls",
        optional: false
      },
      %{
        name: :can_send_other_messages,
        type: :boolean,
        description:
          "True, if the user is allowed to send animations, games, stickers and use inline bots",
        optional: false
      },
      %{
        name: :can_add_web_page_previews,
        type: :boolean,
        description: "True, if the user is allowed to add web page previews to their messages",
        optional: false
      },
      %{
        name: :can_change_info,
        type: :boolean,
        description:
          "True, if the user is allowed to change the chat title, photo and other settings",
        optional: false
      },
      %{
        name: :can_invite_users,
        type: :boolean,
        description: "True, if the user is allowed to invite new users to the chat",
        optional: false
      },
      %{
        name: :can_pin_messages,
        type: :boolean,
        description: "True, if the user is allowed to pin messages",
        optional: false
      },
      %{
        name: :can_manage_topics,
        type: :boolean,
        description: "True, if the user is allowed to create forum topics",
        optional: false
      },
      %{
        name: :until_date,
        type: :integer,
        description:
          "Date when restrictions will be lifted for this user; Unix time. If 0, then the user is restricted forever",
        optional: false
      }
    ]
  )

  deftype(
    ChatMemberLeft,
    "Represents a chat member that isn't currently a member of the chat, but may join it themselves.",
    [
      %{
        name: :status,
        type: :string,
        description: "The member's status in the chat, always “left”",
        optional: false
      },
      %{
        name: :user,
        type: Telegex.Type.User,
        description: "Information about the user",
        optional: false
      }
    ]
  )

  deftype(
    ChatMemberBanned,
    "Represents a chat member that was banned in the chat and can't return to the chat or view chat messages.",
    [
      %{
        name: :status,
        type: :string,
        description: "The member's status in the chat, always “kicked”",
        optional: false
      },
      %{
        name: :user,
        type: Telegex.Type.User,
        description: "Information about the user",
        optional: false
      },
      %{
        name: :until_date,
        type: :integer,
        description:
          "Date when restrictions will be lifted for this user; Unix time. If 0, then the user is banned forever",
        optional: false
      }
    ]
  )

  deftype(ChatMemberUpdated, "This object represents changes in the status of a chat member.", [
    %{
      name: :chat,
      type: Telegex.Type.Chat,
      description: "Chat the user belongs to",
      optional: false
    },
    %{
      name: :from,
      type: Telegex.Type.User,
      description: "Performer of the action, which resulted in the change",
      optional: false
    },
    %{
      name: :date,
      type: :integer,
      description: "Date the change was done in Unix time",
      optional: false
    },
    %{
      name: :old_chat_member,
      type: Telegex.Type.ChatMember,
      description: "Previous information about the chat member",
      optional: false
    },
    %{
      name: :new_chat_member,
      type: Telegex.Type.ChatMember,
      description: "New information about the chat member",
      optional: false
    },
    %{
      name: :invite_link,
      type: Telegex.Type.ChatInviteLink,
      description:
        "Optional. Chat invite link, which was used by the user to join the chat; for joining by invite link events only.",
      optional: true
    },
    %{
      name: :via_chat_folder_invite_link,
      type: :boolean,
      description: "Optional. True, if the user joined the chat via a chat folder invite link",
      optional: true
    }
  ])

  deftype(ChatJoinRequest, "Represents a join request sent to a chat.", [
    %{
      name: :chat,
      type: Telegex.Type.Chat,
      description: "Chat to which the request was sent",
      optional: false
    },
    %{
      name: :from,
      type: Telegex.Type.User,
      description: "User that sent the join request",
      optional: false
    },
    %{
      name: :user_chat_id,
      type: :integer,
      description:
        "Identifier of a private chat with the user who sent the join request. This number may have more than 32 significant bits and some programming languages may have difficulty/silent defects in interpreting it. But it has at most 52 significant bits, so a 64-bit integer or double-precision float type are safe for storing this identifier. The bot can use this identifier for 24 hours to send messages until the join request is processed, assuming no other administrator contacted the user.",
      optional: false
    },
    %{
      name: :date,
      type: :integer,
      description: "Date the request was sent in Unix time",
      optional: false
    },
    %{name: :bio, type: :string, description: "Optional. Bio of the user.", optional: true},
    %{
      name: :invite_link,
      type: Telegex.Type.ChatInviteLink,
      description:
        "Optional. Chat invite link that was used by the user to send the join request",
      optional: true
    }
  ])

  deftype(
    ChatPermissions,
    "Describes actions that a non-administrator user is allowed to take in a chat.",
    [
      %{
        name: :can_send_messages,
        type: :boolean,
        description:
          "Optional. True, if the user is allowed to send text messages, contacts, invoices, locations and venues",
        optional: true
      },
      %{
        name: :can_send_audios,
        type: :boolean,
        description: "Optional. True, if the user is allowed to send audios",
        optional: true
      },
      %{
        name: :can_send_documents,
        type: :boolean,
        description: "Optional. True, if the user is allowed to send documents",
        optional: true
      },
      %{
        name: :can_send_photos,
        type: :boolean,
        description: "Optional. True, if the user is allowed to send photos",
        optional: true
      },
      %{
        name: :can_send_videos,
        type: :boolean,
        description: "Optional. True, if the user is allowed to send videos",
        optional: true
      },
      %{
        name: :can_send_video_notes,
        type: :boolean,
        description: "Optional. True, if the user is allowed to send video notes",
        optional: true
      },
      %{
        name: :can_send_voice_notes,
        type: :boolean,
        description: "Optional. True, if the user is allowed to send voice notes",
        optional: true
      },
      %{
        name: :can_send_polls,
        type: :boolean,
        description: "Optional. True, if the user is allowed to send polls",
        optional: true
      },
      %{
        name: :can_send_other_messages,
        type: :boolean,
        description:
          "Optional. True, if the user is allowed to send animations, games, stickers and use inline bots",
        optional: true
      },
      %{
        name: :can_add_web_page_previews,
        type: :boolean,
        description:
          "Optional. True, if the user is allowed to add web page previews to their messages",
        optional: true
      },
      %{
        name: :can_change_info,
        type: :boolean,
        description:
          "Optional. True, if the user is allowed to change the chat title, photo and other settings. Ignored in public supergroups",
        optional: true
      },
      %{
        name: :can_invite_users,
        type: :boolean,
        description: "Optional. True, if the user is allowed to invite new users to the chat",
        optional: true
      },
      %{
        name: :can_pin_messages,
        type: :boolean,
        description:
          "Optional. True, if the user is allowed to pin messages. Ignored in public supergroups",
        optional: true
      },
      %{
        name: :can_manage_topics,
        type: :boolean,
        description:
          "Optional. True, if the user is allowed to create forum topics. If omitted defaults to the value of can_pin_messages",
        optional: true
      }
    ]
  )

  deftype(ChatLocation, "Represents a location to which a chat is connected.", [
    %{
      name: :location,
      type: Telegex.Type.Location,
      description: "The location to which the supergroup is connected. Can't be a live location.",
      optional: false
    },
    %{
      name: :address,
      type: :string,
      description: "Location address; 1-64 characters, as defined by the chat owner",
      optional: false
    }
  ])

  deftype(ForumTopic, "This object represents a forum topic.", [
    %{
      name: :message_thread_id,
      type: :integer,
      description: "Unique identifier of the forum topic",
      optional: false
    },
    %{name: :name, type: :string, description: "Name of the topic", optional: false},
    %{
      name: :icon_color,
      type: :integer,
      description: "Color of the topic icon in RGB format",
      optional: false
    },
    %{
      name: :icon_custom_emoji_id,
      type: :string,
      description: "Optional. Unique identifier of the custom emoji shown as the topic icon",
      optional: true
    }
  ])

  deftype(BotCommand, "This object represents a bot command.", [
    %{
      name: :command,
      type: :string,
      description:
        "Text of the command; 1-32 characters. Can contain only lowercase English letters, digits and underscores.",
      optional: false
    },
    %{
      name: :description,
      type: :string,
      description: "Description of the command; 1-256 characters.",
      optional: false
    }
  ])

  deftype(
    BotCommandScopeDefault,
    "Represents the default scope of bot commands. Default commands are used if no commands with a narrower scope are specified for the user.",
    [%{name: :type, type: :string, description: "Scope type, must be default", optional: false}]
  )

  deftype(
    BotCommandScopeAllPrivateChats,
    "Represents the scope of bot commands, covering all private chats.",
    [
      %{
        name: :type,
        type: :string,
        description: "Scope type, must be all_private_chats",
        optional: false
      }
    ]
  )

  deftype(
    BotCommandScopeAllGroupChats,
    "Represents the scope of bot commands, covering all group and supergroup chats.",
    [
      %{
        name: :type,
        type: :string,
        description: "Scope type, must be all_group_chats",
        optional: false
      }
    ]
  )

  deftype(
    BotCommandScopeAllChatAdministrators,
    "Represents the scope of bot commands, covering all group and supergroup chat administrators.",
    [
      %{
        name: :type,
        type: :string,
        description: "Scope type, must be all_chat_administrators",
        optional: false
      }
    ]
  )

  deftype(
    BotCommandScopeChat,
    "Represents the scope of bot commands, covering a specific chat.",
    [
      %{name: :type, type: :string, description: "Scope type, must be chat", optional: false},
      %{
        name: :chat_id,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]},
        description:
          "Unique identifier for the target chat or username of the target supergroup (in the format @supergroupusername)",
        optional: false
      }
    ]
  )

  deftype(
    BotCommandScopeChatAdministrators,
    "Represents the scope of bot commands, covering all administrators of a specific group or supergroup chat.",
    [
      %{
        name: :type,
        type: :string,
        description: "Scope type, must be chat_administrators",
        optional: false
      },
      %{
        name: :chat_id,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]},
        description:
          "Unique identifier for the target chat or username of the target supergroup (in the format @supergroupusername)",
        optional: false
      }
    ]
  )

  deftype(
    BotCommandScopeChatMember,
    "Represents the scope of bot commands, covering a specific member of a group or supergroup chat.",
    [
      %{
        name: :type,
        type: :string,
        description: "Scope type, must be chat_member",
        optional: false
      },
      %{
        name: :chat_id,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]},
        description:
          "Unique identifier for the target chat or username of the target supergroup (in the format @supergroupusername)",
        optional: false
      },
      %{
        name: :user_id,
        type: :integer,
        description: "Unique identifier of the target user",
        optional: false
      }
    ]
  )

  deftype(BotName, "This object represents the bot's name.", [
    %{name: :name, type: :string, description: "The bot's name", optional: false}
  ])

  deftype(BotDescription, "This object represents the bot's description.", [
    %{name: :description, type: :string, description: "The bot's description", optional: false}
  ])

  deftype(BotShortDescription, "This object represents the bot's short description.", [
    %{
      name: :short_description,
      type: :string,
      description: "The bot's short description",
      optional: false
    }
  ])

  deftype(
    MenuButtonCommands,
    "Represents a menu button, which opens the bot's list of commands.",
    [
      %{
        name: :type,
        type: :string,
        description: "Type of the button, must be commands",
        optional: false
      }
    ]
  )

  deftype(MenuButtonWebApp, "Represents a menu button, which launches a Web App.", [
    %{
      name: :type,
      type: :string,
      description: "Type of the button, must be web_app",
      optional: false
    },
    %{name: :text, type: :string, description: "Text on the button", optional: false},
    %{
      name: :web_app,
      type: Telegex.Type.WebAppInfo,
      description:
        "Description of the Web App that will be launched when the user presses the button. The Web App will be able to send an arbitrary message on behalf of the user using the method answerWebAppQuery.",
      optional: false
    }
  ])

  deftype(MenuButtonDefault, "Describes that no specific value for the menu button was set.", [
    %{
      name: :type,
      type: :string,
      description: "Type of the button, must be default",
      optional: false
    }
  ])

  deftype(ResponseParameters, "Describes why a request was unsuccessful.", [
    %{
      name: :migrate_to_chat_id,
      type: :integer,
      description:
        "Optional. The group has been migrated to a supergroup with the specified identifier. This number may have more than 32 significant bits and some programming languages may have difficulty/silent defects in interpreting it. But it has at most 52 significant bits, so a signed 64-bit integer or double-precision float type are safe for storing this identifier.",
      optional: true
    },
    %{
      name: :retry_after,
      type: :integer,
      description:
        "Optional. In case of exceeding flood control, the number of seconds left to wait before the request can be repeated",
      optional: true
    }
  ])

  deftype(InputMediaPhoto, "Represents a photo to be sent.", [
    %{
      name: :type,
      type: :string,
      description: "Type of the result, must be photo",
      optional: false
    },
    %{
      name: :media,
      type: :string,
      description:
        "File to send. Pass a file_id to send a file that exists on the Telegram servers (recommended), pass an HTTP URL for Telegram to get a file from the Internet, or pass “attach://<file_attach_name>” to upload a new one using multipart/form-data under <file_attach_name> name. More information on Sending Files »",
      optional: false
    },
    %{
      name: :caption,
      type: :string,
      description:
        "Optional. Caption of the photo to be sent, 0-1024 characters after entities parsing",
      optional: true
    },
    %{
      name: :parse_mode,
      type: :string,
      description:
        "Optional. Mode for parsing entities in the photo caption. See formatting options for more details.",
      optional: true
    },
    %{
      name: :caption_entities,
      type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity},
      description:
        "Optional. List of special entities that appear in the caption, which can be specified instead of parse_mode",
      optional: true
    },
    %{
      name: :has_spoiler,
      type: :boolean,
      description:
        "Optional. Pass True if the photo needs to be covered with a spoiler animation",
      optional: true
    }
  ])

  deftype(InputMediaVideo, "Represents a video to be sent.", [
    %{
      name: :type,
      type: :string,
      description: "Type of the result, must be video",
      optional: false
    },
    %{
      name: :media,
      type: :string,
      description:
        "File to send. Pass a file_id to send a file that exists on the Telegram servers (recommended), pass an HTTP URL for Telegram to get a file from the Internet, or pass “attach://<file_attach_name>” to upload a new one using multipart/form-data under <file_attach_name> name. More information on Sending Files »",
      optional: false
    },
    %{
      name: :thumbnail,
      type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [Telegex.Type.InputFile, :string]},
      description:
        "Optional. Thumbnail of the file sent; can be ignored if thumbnail generation for the file is supported server-side. The thumbnail should be in JPEG format and less than 200 kB in size. A thumbnail's width and height should not exceed 320. Ignored if the file is not uploaded using multipart/form-data. Thumbnails can't be reused and can be only uploaded as a new file, so you can pass “attach://<file_attach_name>” if the thumbnail was uploaded using multipart/form-data under <file_attach_name>. More information on Sending Files »",
      optional: true
    },
    %{
      name: :caption,
      type: :string,
      description:
        "Optional. Caption of the video to be sent, 0-1024 characters after entities parsing",
      optional: true
    },
    %{
      name: :parse_mode,
      type: :string,
      description:
        "Optional. Mode for parsing entities in the video caption. See formatting options for more details.",
      optional: true
    },
    %{
      name: :caption_entities,
      type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity},
      description:
        "Optional. List of special entities that appear in the caption, which can be specified instead of parse_mode",
      optional: true
    },
    %{name: :width, type: :integer, description: "Optional. Video width", optional: true},
    %{name: :height, type: :integer, description: "Optional. Video height", optional: true},
    %{
      name: :duration,
      type: :integer,
      description: "Optional. Video duration in seconds",
      optional: true
    },
    %{
      name: :supports_streaming,
      type: :boolean,
      description: "Optional. Pass True if the uploaded video is suitable for streaming",
      optional: true
    },
    %{
      name: :has_spoiler,
      type: :boolean,
      description:
        "Optional. Pass True if the video needs to be covered with a spoiler animation",
      optional: true
    }
  ])

  deftype(
    InputMediaAnimation,
    "Represents an animation file (GIF or H.264/MPEG-4 AVC video without sound) to be sent.",
    [
      %{
        name: :type,
        type: :string,
        description: "Type of the result, must be animation",
        optional: false
      },
      %{
        name: :media,
        type: :string,
        description:
          "File to send. Pass a file_id to send a file that exists on the Telegram servers (recommended), pass an HTTP URL for Telegram to get a file from the Internet, or pass “attach://<file_attach_name>” to upload a new one using multipart/form-data under <file_attach_name> name. More information on Sending Files »",
        optional: false
      },
      %{
        name: :thumbnail,
        type: %{
          __struct__: Telegex.TypeDefiner.UnionType,
          types: [Telegex.Type.InputFile, :string]
        },
        description:
          "Optional. Thumbnail of the file sent; can be ignored if thumbnail generation for the file is supported server-side. The thumbnail should be in JPEG format and less than 200 kB in size. A thumbnail's width and height should not exceed 320. Ignored if the file is not uploaded using multipart/form-data. Thumbnails can't be reused and can be only uploaded as a new file, so you can pass “attach://<file_attach_name>” if the thumbnail was uploaded using multipart/form-data under <file_attach_name>. More information on Sending Files »",
        optional: true
      },
      %{
        name: :caption,
        type: :string,
        description:
          "Optional. Caption of the animation to be sent, 0-1024 characters after entities parsing",
        optional: true
      },
      %{
        name: :parse_mode,
        type: :string,
        description:
          "Optional. Mode for parsing entities in the animation caption. See formatting options for more details.",
        optional: true
      },
      %{
        name: :caption_entities,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity},
        description:
          "Optional. List of special entities that appear in the caption, which can be specified instead of parse_mode",
        optional: true
      },
      %{name: :width, type: :integer, description: "Optional. Animation width", optional: true},
      %{name: :height, type: :integer, description: "Optional. Animation height", optional: true},
      %{
        name: :duration,
        type: :integer,
        description: "Optional. Animation duration in seconds",
        optional: true
      },
      %{
        name: :has_spoiler,
        type: :boolean,
        description:
          "Optional. Pass True if the animation needs to be covered with a spoiler animation",
        optional: true
      }
    ]
  )

  deftype(InputMediaAudio, "Represents an audio file to be treated as music to be sent.", [
    %{
      name: :type,
      type: :string,
      description: "Type of the result, must be audio",
      optional: false
    },
    %{
      name: :media,
      type: :string,
      description:
        "File to send. Pass a file_id to send a file that exists on the Telegram servers (recommended), pass an HTTP URL for Telegram to get a file from the Internet, or pass “attach://<file_attach_name>” to upload a new one using multipart/form-data under <file_attach_name> name. More information on Sending Files »",
      optional: false
    },
    %{
      name: :thumbnail,
      type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [Telegex.Type.InputFile, :string]},
      description:
        "Optional. Thumbnail of the file sent; can be ignored if thumbnail generation for the file is supported server-side. The thumbnail should be in JPEG format and less than 200 kB in size. A thumbnail's width and height should not exceed 320. Ignored if the file is not uploaded using multipart/form-data. Thumbnails can't be reused and can be only uploaded as a new file, so you can pass “attach://<file_attach_name>” if the thumbnail was uploaded using multipart/form-data under <file_attach_name>. More information on Sending Files »",
      optional: true
    },
    %{
      name: :caption,
      type: :string,
      description:
        "Optional. Caption of the audio to be sent, 0-1024 characters after entities parsing",
      optional: true
    },
    %{
      name: :parse_mode,
      type: :string,
      description:
        "Optional. Mode for parsing entities in the audio caption. See formatting options for more details.",
      optional: true
    },
    %{
      name: :caption_entities,
      type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity},
      description:
        "Optional. List of special entities that appear in the caption, which can be specified instead of parse_mode",
      optional: true
    },
    %{
      name: :duration,
      type: :integer,
      description: "Optional. Duration of the audio in seconds",
      optional: true
    },
    %{
      name: :performer,
      type: :string,
      description: "Optional. Performer of the audio",
      optional: true
    },
    %{name: :title, type: :string, description: "Optional. Title of the audio", optional: true}
  ])

  deftype(InputMediaDocument, "Represents a general file to be sent.", [
    %{
      name: :type,
      type: :string,
      description: "Type of the result, must be document",
      optional: false
    },
    %{
      name: :media,
      type: :string,
      description:
        "File to send. Pass a file_id to send a file that exists on the Telegram servers (recommended), pass an HTTP URL for Telegram to get a file from the Internet, or pass “attach://<file_attach_name>” to upload a new one using multipart/form-data under <file_attach_name> name. More information on Sending Files »",
      optional: false
    },
    %{
      name: :thumbnail,
      type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [Telegex.Type.InputFile, :string]},
      description:
        "Optional. Thumbnail of the file sent; can be ignored if thumbnail generation for the file is supported server-side. The thumbnail should be in JPEG format and less than 200 kB in size. A thumbnail's width and height should not exceed 320. Ignored if the file is not uploaded using multipart/form-data. Thumbnails can't be reused and can be only uploaded as a new file, so you can pass “attach://<file_attach_name>” if the thumbnail was uploaded using multipart/form-data under <file_attach_name>. More information on Sending Files »",
      optional: true
    },
    %{
      name: :caption,
      type: :string,
      description:
        "Optional. Caption of the document to be sent, 0-1024 characters after entities parsing",
      optional: true
    },
    %{
      name: :parse_mode,
      type: :string,
      description:
        "Optional. Mode for parsing entities in the document caption. See formatting options for more details.",
      optional: true
    },
    %{
      name: :caption_entities,
      type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity},
      description:
        "Optional. List of special entities that appear in the caption, which can be specified instead of parse_mode",
      optional: true
    },
    %{
      name: :disable_content_type_detection,
      type: :boolean,
      description:
        "Optional. Disables automatic server-side content type detection for files uploaded using multipart/form-data. Always True, if the document is sent as part of an album.",
      optional: true
    }
  ])

  deftype(
    InputFile,
    "This object represents the contents of a file to be uploaded. Must be posted using multipart/form-data in the usual way that files are uploaded via the browser.",
    []
  )

  deftype(Sticker, "This object represents a sticker.", [
    %{
      name: :file_id,
      type: :string,
      description: "Identifier for this file, which can be used to download or reuse the file",
      optional: false
    },
    %{
      name: :file_unique_id,
      type: :string,
      description:
        "Unique identifier for this file, which is supposed to be the same over time and for different bots. Can't be used to download or reuse the file.",
      optional: false
    },
    %{
      name: :type,
      type: :string,
      description:
        "Type of the sticker, currently one of “regular”, “mask”, “custom_emoji”. The type of the sticker is independent from its format, which is determined by the fields is_animated and is_video.",
      optional: false
    },
    %{name: :width, type: :integer, description: "Sticker width", optional: false},
    %{name: :height, type: :integer, description: "Sticker height", optional: false},
    %{
      name: :is_animated,
      type: :boolean,
      description: "True, if the sticker is animated",
      optional: false
    },
    %{
      name: :is_video,
      type: :boolean,
      description: "True, if the sticker is a video sticker",
      optional: false
    },
    %{
      name: :thumbnail,
      type: Telegex.Type.PhotoSize,
      description: "Optional. Sticker thumbnail in the .WEBP or .JPG format",
      optional: true
    },
    %{
      name: :emoji,
      type: :string,
      description: "Optional. Emoji associated with the sticker",
      optional: true
    },
    %{
      name: :set_name,
      type: :string,
      description: "Optional. Name of the sticker set to which the sticker belongs",
      optional: true
    },
    %{
      name: :premium_animation,
      type: Telegex.Type.File,
      description: "Optional. For premium regular stickers, premium animation for the sticker",
      optional: true
    },
    %{
      name: :mask_position,
      type: Telegex.Type.MaskPosition,
      description: "Optional. For mask stickers, the position where the mask should be placed",
      optional: true
    },
    %{
      name: :custom_emoji_id,
      type: :string,
      description: "Optional. For custom emoji stickers, unique identifier of the custom emoji",
      optional: true
    },
    %{
      name: :needs_repainting,
      type: :boolean,
      description:
        "Optional. True, if the sticker must be repainted to a text color in messages, the color of the Telegram Premium badge in emoji status, white color on chat photos, or another appropriate color in other places",
      optional: true
    },
    %{
      name: :file_size,
      type: :integer,
      description: "Optional. File size in bytes",
      optional: true
    }
  ])

  deftype(StickerSet, "This object represents a sticker set.", [
    %{name: :name, type: :string, description: "Sticker set name", optional: false},
    %{name: :title, type: :string, description: "Sticker set title", optional: false},
    %{
      name: :sticker_type,
      type: :string,
      description:
        "Type of stickers in the set, currently one of “regular”, “mask”, “custom_emoji”",
      optional: false
    },
    %{
      name: :is_animated,
      type: :boolean,
      description: "True, if the sticker set contains animated stickers",
      optional: false
    },
    %{
      name: :is_video,
      type: :boolean,
      description: "True, if the sticker set contains video stickers",
      optional: false
    },
    %{
      name: :stickers,
      type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.Sticker},
      description: "List of all set stickers",
      optional: false
    },
    %{
      name: :thumbnail,
      type: Telegex.Type.PhotoSize,
      description: "Optional. Sticker set thumbnail in the .WEBP, .TGS, or .WEBM format",
      optional: true
    }
  ])

  deftype(
    MaskPosition,
    "This object describes the position on faces where a mask should be placed by default.",
    [
      %{
        name: :point,
        type: :string,
        description:
          "The part of the face relative to which the mask should be placed. One of “forehead”, “eyes”, “mouth”, or “chin”.",
        optional: false
      },
      %{
        name: :x_shift,
        type: :float,
        description:
          "Shift by X-axis measured in widths of the mask scaled to the face size, from left to right. For example, choosing -1.0 will place mask just to the left of the default mask position.",
        optional: false
      },
      %{
        name: :y_shift,
        type: :float,
        description:
          "Shift by Y-axis measured in heights of the mask scaled to the face size, from top to bottom. For example, 1.0 will place the mask just below the default mask position.",
        optional: false
      },
      %{
        name: :scale,
        type: :float,
        description: "Mask scaling coefficient. For example, 2.0 means double size.",
        optional: false
      }
    ]
  )

  deftype(InputSticker, "This object describes a sticker to be added to a sticker set.", [
    %{
      name: :sticker,
      type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [Telegex.Type.InputFile, :string]},
      description:
        "The added sticker. Pass a file_id as a String to send a file that already exists on the Telegram servers, pass an HTTP URL as a String for Telegram to get a file from the Internet, upload a new one using multipart/form-data, or pass “attach://<file_attach_name>” to upload a new one using multipart/form-data under <file_attach_name> name. Animated and video stickers can't be uploaded via HTTP URL. More information on Sending Files »",
      optional: false
    },
    %{
      name: :emoji_list,
      type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: :string},
      description: "List of 1-20 emoji associated with the sticker",
      optional: false
    },
    %{
      name: :mask_position,
      type: Telegex.Type.MaskPosition,
      description:
        "Optional. Position where the mask should be placed on faces. For “mask” stickers only.",
      optional: true
    },
    %{
      name: :keywords,
      type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: :string},
      description:
        "Optional. List of 0-20 search keywords for the sticker with total length of up to 64 characters. For “regular” and “custom_emoji” stickers only.",
      optional: true
    }
  ])

  deftype(
    InlineQuery,
    "This object represents an incoming inline query. When the user sends an empty query, your bot could return some default or trending results.",
    [
      %{
        name: :id,
        type: :string,
        description: "Unique identifier for this query",
        optional: false
      },
      %{name: :from, type: Telegex.Type.User, description: "Sender", optional: false},
      %{
        name: :query,
        type: :string,
        description: "Text of the query (up to 256 characters)",
        optional: false
      },
      %{
        name: :offset,
        type: :string,
        description: "Offset of the results to be returned, can be controlled by the bot",
        optional: false
      },
      %{
        name: :chat_type,
        type: :string,
        description:
          "Optional. Type of the chat from which the inline query was sent. Can be either “sender” for a private chat with the inline query sender, “private”, “group”, “supergroup”, or “channel”. The chat type should be always known for requests sent from official clients and most third-party clients, unless the request was sent from a secret chat",
        optional: true
      },
      %{
        name: :location,
        type: Telegex.Type.Location,
        description: "Optional. Sender location, only for bots that request user location",
        optional: true
      }
    ]
  )

  deftype(
    InlineQueryResultsButton,
    "This object represents a button to be shown above inline query results. You must use exactly one of the optional fields.",
    [
      %{name: :text, type: :string, description: "Label text on the button", optional: false},
      %{
        name: :web_app,
        type: Telegex.Type.WebAppInfo,
        description:
          "Optional. Description of the Web App that will be launched when the user presses the button. The Web App will be able to switch back to the inline mode using the method switchInlineQuery inside the Web App.",
        optional: true
      },
      %{
        name: :start_parameter,
        type: :string,
        description:
          "Optional. Deep-linking parameter for the /start message sent to the bot when a user presses the button. 1-64 characters, only A-Z, a-z, 0-9, _ and - are allowed.\n\nExample: An inline bot that sends YouTube videos can ask the user to connect the bot to their YouTube account to adapt search results accordingly. To do this, it displays a 'Connect your YouTube account' button above the results, or even before showing any. The user presses the button, switches to a private chat with the bot and, in doing so, passes a start parameter that instructs the bot to return an OAuth link. Once done, the bot can offer a switch_inline button so that the user can easily return to the chat where they wanted to use the bot's inline capabilities.",
        optional: true
      }
    ]
  )

  deftype(InlineQueryResultArticle, "Represents a link to an article or web page.", [
    %{
      name: :type,
      type: :string,
      description: "Type of the result, must be article",
      optional: false
    },
    %{
      name: :id,
      type: :string,
      description: "Unique identifier for this result, 1-64 Bytes",
      optional: false
    },
    %{name: :title, type: :string, description: "Title of the result", optional: false},
    %{
      name: :input_message_content,
      type: Telegex.Type.InputMessageContent,
      description: "Content of the message to be sent",
      optional: false
    },
    %{
      name: :reply_markup,
      type: Telegex.Type.InlineKeyboardMarkup,
      description: "Optional. Inline keyboard attached to the message",
      optional: true
    },
    %{name: :url, type: :string, description: "Optional. URL of the result", optional: true},
    %{
      name: :hide_url,
      type: :boolean,
      description: "Optional. Pass True if you don't want the URL to be shown in the message",
      optional: true
    },
    %{
      name: :description,
      type: :string,
      description: "Optional. Short description of the result",
      optional: true
    },
    %{
      name: :thumbnail_url,
      type: :string,
      description: "Optional. Url of the thumbnail for the result",
      optional: true
    },
    %{
      name: :thumbnail_width,
      type: :integer,
      description: "Optional. Thumbnail width",
      optional: true
    },
    %{
      name: :thumbnail_height,
      type: :integer,
      description: "Optional. Thumbnail height",
      optional: true
    }
  ])

  deftype(
    InlineQueryResultPhoto,
    "Represents a link to a photo. By default, this photo will be sent by the user with optional caption. Alternatively, you can use input_message_content to send a message with the specified content instead of the photo.",
    [
      %{
        name: :type,
        type: :string,
        description: "Type of the result, must be photo",
        optional: false
      },
      %{
        name: :id,
        type: :string,
        description: "Unique identifier for this result, 1-64 bytes",
        optional: false
      },
      %{
        name: :photo_url,
        type: :string,
        description:
          "A valid URL of the photo. Photo must be in JPEG format. Photo size must not exceed 5MB",
        optional: false
      },
      %{
        name: :thumbnail_url,
        type: :string,
        description: "URL of the thumbnail for the photo",
        optional: false
      },
      %{
        name: :photo_width,
        type: :integer,
        description: "Optional. Width of the photo",
        optional: true
      },
      %{
        name: :photo_height,
        type: :integer,
        description: "Optional. Height of the photo",
        optional: true
      },
      %{
        name: :title,
        type: :string,
        description: "Optional. Title for the result",
        optional: true
      },
      %{
        name: :description,
        type: :string,
        description: "Optional. Short description of the result",
        optional: true
      },
      %{
        name: :caption,
        type: :string,
        description:
          "Optional. Caption of the photo to be sent, 0-1024 characters after entities parsing",
        optional: true
      },
      %{
        name: :parse_mode,
        type: :string,
        description:
          "Optional. Mode for parsing entities in the photo caption. See formatting options for more details.",
        optional: true
      },
      %{
        name: :caption_entities,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity},
        description:
          "Optional. List of special entities that appear in the caption, which can be specified instead of parse_mode",
        optional: true
      },
      %{
        name: :reply_markup,
        type: Telegex.Type.InlineKeyboardMarkup,
        description: "Optional. Inline keyboard attached to the message",
        optional: true
      },
      %{
        name: :input_message_content,
        type: Telegex.Type.InputMessageContent,
        description: "Optional. Content of the message to be sent instead of the photo",
        optional: true
      }
    ]
  )

  deftype(
    InlineQueryResultGif,
    "Represents a link to an animated GIF file. By default, this animated GIF file will be sent by the user with optional caption. Alternatively, you can use input_message_content to send a message with the specified content instead of the animation.",
    [
      %{
        name: :type,
        type: :string,
        description: "Type of the result, must be gif",
        optional: false
      },
      %{
        name: :id,
        type: :string,
        description: "Unique identifier for this result, 1-64 bytes",
        optional: false
      },
      %{
        name: :gif_url,
        type: :string,
        description: "A valid URL for the GIF file. File size must not exceed 1MB",
        optional: false
      },
      %{
        name: :gif_width,
        type: :integer,
        description: "Optional. Width of the GIF",
        optional: true
      },
      %{
        name: :gif_height,
        type: :integer,
        description: "Optional. Height of the GIF",
        optional: true
      },
      %{
        name: :gif_duration,
        type: :integer,
        description: "Optional. Duration of the GIF in seconds",
        optional: true
      },
      %{
        name: :thumbnail_url,
        type: :string,
        description:
          "URL of the static (JPEG or GIF) or animated (MPEG4) thumbnail for the result",
        optional: false
      },
      %{
        name: :thumbnail_mime_type,
        type: :string,
        description:
          "Optional. MIME type of the thumbnail, must be one of “image/jpeg”, “image/gif”, or “video/mp4”. Defaults to “image/jpeg”",
        optional: true
      },
      %{
        name: :title,
        type: :string,
        description: "Optional. Title for the result",
        optional: true
      },
      %{
        name: :caption,
        type: :string,
        description:
          "Optional. Caption of the GIF file to be sent, 0-1024 characters after entities parsing",
        optional: true
      },
      %{
        name: :parse_mode,
        type: :string,
        description:
          "Optional. Mode for parsing entities in the caption. See formatting options for more details.",
        optional: true
      },
      %{
        name: :caption_entities,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity},
        description:
          "Optional. List of special entities that appear in the caption, which can be specified instead of parse_mode",
        optional: true
      },
      %{
        name: :reply_markup,
        type: Telegex.Type.InlineKeyboardMarkup,
        description: "Optional. Inline keyboard attached to the message",
        optional: true
      },
      %{
        name: :input_message_content,
        type: Telegex.Type.InputMessageContent,
        description: "Optional. Content of the message to be sent instead of the GIF animation",
        optional: true
      }
    ]
  )

  deftype(
    InlineQueryResultMpeg4Gif,
    "Represents a link to a video animation (H.264/MPEG-4 AVC video without sound). By default, this animated MPEG-4 file will be sent by the user with optional caption. Alternatively, you can use input_message_content to send a message with the specified content instead of the animation.",
    [
      %{
        name: :type,
        type: :string,
        description: "Type of the result, must be mpeg4_gif",
        optional: false
      },
      %{
        name: :id,
        type: :string,
        description: "Unique identifier for this result, 1-64 bytes",
        optional: false
      },
      %{
        name: :mpeg4_url,
        type: :string,
        description: "A valid URL for the MPEG4 file. File size must not exceed 1MB",
        optional: false
      },
      %{name: :mpeg4_width, type: :integer, description: "Optional. Video width", optional: true},
      %{
        name: :mpeg4_height,
        type: :integer,
        description: "Optional. Video height",
        optional: true
      },
      %{
        name: :mpeg4_duration,
        type: :integer,
        description: "Optional. Video duration in seconds",
        optional: true
      },
      %{
        name: :thumbnail_url,
        type: :string,
        description:
          "URL of the static (JPEG or GIF) or animated (MPEG4) thumbnail for the result",
        optional: false
      },
      %{
        name: :thumbnail_mime_type,
        type: :string,
        description:
          "Optional. MIME type of the thumbnail, must be one of “image/jpeg”, “image/gif”, or “video/mp4”. Defaults to “image/jpeg”",
        optional: true
      },
      %{
        name: :title,
        type: :string,
        description: "Optional. Title for the result",
        optional: true
      },
      %{
        name: :caption,
        type: :string,
        description:
          "Optional. Caption of the MPEG-4 file to be sent, 0-1024 characters after entities parsing",
        optional: true
      },
      %{
        name: :parse_mode,
        type: :string,
        description:
          "Optional. Mode for parsing entities in the caption. See formatting options for more details.",
        optional: true
      },
      %{
        name: :caption_entities,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity},
        description:
          "Optional. List of special entities that appear in the caption, which can be specified instead of parse_mode",
        optional: true
      },
      %{
        name: :reply_markup,
        type: Telegex.Type.InlineKeyboardMarkup,
        description: "Optional. Inline keyboard attached to the message",
        optional: true
      },
      %{
        name: :input_message_content,
        type: Telegex.Type.InputMessageContent,
        description: "Optional. Content of the message to be sent instead of the video animation",
        optional: true
      }
    ]
  )

  deftype(
    InlineQueryResultVideo,
    "Represents a link to a page containing an embedded video player or a video file. By default, this video file will be sent by the user with an optional caption. Alternatively, you can use input_message_content to send a message with the specified content instead of the video.",
    [
      %{
        name: :type,
        type: :string,
        description: "Type of the result, must be video",
        optional: false
      },
      %{
        name: :id,
        type: :string,
        description: "Unique identifier for this result, 1-64 bytes",
        optional: false
      },
      %{
        name: :video_url,
        type: :string,
        description: "A valid URL for the embedded video player or video file",
        optional: false
      },
      %{
        name: :mime_type,
        type: :string,
        description: "MIME type of the content of the video URL, “text/html” or “video/mp4”",
        optional: false
      },
      %{
        name: :thumbnail_url,
        type: :string,
        description: "URL of the thumbnail (JPEG only) for the video",
        optional: false
      },
      %{name: :title, type: :string, description: "Title for the result", optional: false},
      %{
        name: :caption,
        type: :string,
        description:
          "Optional. Caption of the video to be sent, 0-1024 characters after entities parsing",
        optional: true
      },
      %{
        name: :parse_mode,
        type: :string,
        description:
          "Optional. Mode for parsing entities in the video caption. See formatting options for more details.",
        optional: true
      },
      %{
        name: :caption_entities,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity},
        description:
          "Optional. List of special entities that appear in the caption, which can be specified instead of parse_mode",
        optional: true
      },
      %{name: :video_width, type: :integer, description: "Optional. Video width", optional: true},
      %{
        name: :video_height,
        type: :integer,
        description: "Optional. Video height",
        optional: true
      },
      %{
        name: :video_duration,
        type: :integer,
        description: "Optional. Video duration in seconds",
        optional: true
      },
      %{
        name: :description,
        type: :string,
        description: "Optional. Short description of the result",
        optional: true
      },
      %{
        name: :reply_markup,
        type: Telegex.Type.InlineKeyboardMarkup,
        description: "Optional. Inline keyboard attached to the message",
        optional: true
      },
      %{
        name: :input_message_content,
        type: Telegex.Type.InputMessageContent,
        description:
          "Optional. Content of the message to be sent instead of the video. This field is required if InlineQueryResultVideo is used to send an HTML-page as a result (e.g., a YouTube video).",
        optional: true
      }
    ]
  )

  deftype(
    InlineQueryResultAudio,
    "Represents a link to an MP3 audio file. By default, this audio file will be sent by the user. Alternatively, you can use input_message_content to send a message with the specified content instead of the audio.",
    [
      %{
        name: :type,
        type: :string,
        description: "Type of the result, must be audio",
        optional: false
      },
      %{
        name: :id,
        type: :string,
        description: "Unique identifier for this result, 1-64 bytes",
        optional: false
      },
      %{
        name: :audio_url,
        type: :string,
        description: "A valid URL for the audio file",
        optional: false
      },
      %{name: :title, type: :string, description: "Title", optional: false},
      %{
        name: :caption,
        type: :string,
        description: "Optional. Caption, 0-1024 characters after entities parsing",
        optional: true
      },
      %{
        name: :parse_mode,
        type: :string,
        description:
          "Optional. Mode for parsing entities in the audio caption. See formatting options for more details.",
        optional: true
      },
      %{
        name: :caption_entities,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity},
        description:
          "Optional. List of special entities that appear in the caption, which can be specified instead of parse_mode",
        optional: true
      },
      %{name: :performer, type: :string, description: "Optional. Performer", optional: true},
      %{
        name: :audio_duration,
        type: :integer,
        description: "Optional. Audio duration in seconds",
        optional: true
      },
      %{
        name: :reply_markup,
        type: Telegex.Type.InlineKeyboardMarkup,
        description: "Optional. Inline keyboard attached to the message",
        optional: true
      },
      %{
        name: :input_message_content,
        type: Telegex.Type.InputMessageContent,
        description: "Optional. Content of the message to be sent instead of the audio",
        optional: true
      }
    ]
  )

  deftype(
    InlineQueryResultVoice,
    "Represents a link to a voice recording in an .OGG container encoded with OPUS. By default, this voice recording will be sent by the user. Alternatively, you can use input_message_content to send a message with the specified content instead of the the voice message.",
    [
      %{
        name: :type,
        type: :string,
        description: "Type of the result, must be voice",
        optional: false
      },
      %{
        name: :id,
        type: :string,
        description: "Unique identifier for this result, 1-64 bytes",
        optional: false
      },
      %{
        name: :voice_url,
        type: :string,
        description: "A valid URL for the voice recording",
        optional: false
      },
      %{name: :title, type: :string, description: "Recording title", optional: false},
      %{
        name: :caption,
        type: :string,
        description: "Optional. Caption, 0-1024 characters after entities parsing",
        optional: true
      },
      %{
        name: :parse_mode,
        type: :string,
        description:
          "Optional. Mode for parsing entities in the voice message caption. See formatting options for more details.",
        optional: true
      },
      %{
        name: :caption_entities,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity},
        description:
          "Optional. List of special entities that appear in the caption, which can be specified instead of parse_mode",
        optional: true
      },
      %{
        name: :voice_duration,
        type: :integer,
        description: "Optional. Recording duration in seconds",
        optional: true
      },
      %{
        name: :reply_markup,
        type: Telegex.Type.InlineKeyboardMarkup,
        description: "Optional. Inline keyboard attached to the message",
        optional: true
      },
      %{
        name: :input_message_content,
        type: Telegex.Type.InputMessageContent,
        description: "Optional. Content of the message to be sent instead of the voice recording",
        optional: true
      }
    ]
  )

  deftype(
    InlineQueryResultDocument,
    "Represents a link to a file. By default, this file will be sent by the user with an optional caption. Alternatively, you can use input_message_content to send a message with the specified content instead of the file. Currently, only .PDF and .ZIP files can be sent using this method.",
    [
      %{
        name: :type,
        type: :string,
        description: "Type of the result, must be document",
        optional: false
      },
      %{
        name: :id,
        type: :string,
        description: "Unique identifier for this result, 1-64 bytes",
        optional: false
      },
      %{name: :title, type: :string, description: "Title for the result", optional: false},
      %{
        name: :caption,
        type: :string,
        description:
          "Optional. Caption of the document to be sent, 0-1024 characters after entities parsing",
        optional: true
      },
      %{
        name: :parse_mode,
        type: :string,
        description:
          "Optional. Mode for parsing entities in the document caption. See formatting options for more details.",
        optional: true
      },
      %{
        name: :caption_entities,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity},
        description:
          "Optional. List of special entities that appear in the caption, which can be specified instead of parse_mode",
        optional: true
      },
      %{
        name: :document_url,
        type: :string,
        description: "A valid URL for the file",
        optional: false
      },
      %{
        name: :mime_type,
        type: :string,
        description:
          "MIME type of the content of the file, either “application/pdf” or “application/zip”",
        optional: false
      },
      %{
        name: :description,
        type: :string,
        description: "Optional. Short description of the result",
        optional: true
      },
      %{
        name: :reply_markup,
        type: Telegex.Type.InlineKeyboardMarkup,
        description: "Optional. Inline keyboard attached to the message",
        optional: true
      },
      %{
        name: :input_message_content,
        type: Telegex.Type.InputMessageContent,
        description: "Optional. Content of the message to be sent instead of the file",
        optional: true
      },
      %{
        name: :thumbnail_url,
        type: :string,
        description: "Optional. URL of the thumbnail (JPEG only) for the file",
        optional: true
      },
      %{
        name: :thumbnail_width,
        type: :integer,
        description: "Optional. Thumbnail width",
        optional: true
      },
      %{
        name: :thumbnail_height,
        type: :integer,
        description: "Optional. Thumbnail height",
        optional: true
      }
    ]
  )

  deftype(
    InlineQueryResultLocation,
    "Represents a location on a map. By default, the location will be sent by the user. Alternatively, you can use input_message_content to send a message with the specified content instead of the location.",
    [
      %{
        name: :type,
        type: :string,
        description: "Type of the result, must be location",
        optional: false
      },
      %{
        name: :id,
        type: :string,
        description: "Unique identifier for this result, 1-64 Bytes",
        optional: false
      },
      %{
        name: :latitude,
        type: :float,
        description: "Location latitude in degrees",
        optional: false
      },
      %{
        name: :longitude,
        type: :float,
        description: "Location longitude in degrees",
        optional: false
      },
      %{name: :title, type: :string, description: "Location title", optional: false},
      %{
        name: :horizontal_accuracy,
        type: :float,
        description:
          "Optional. The radius of uncertainty for the location, measured in meters; 0-1500",
        optional: true
      },
      %{
        name: :live_period,
        type: :integer,
        description:
          "Optional. Period in seconds for which the location can be updated, should be between 60 and 86400.",
        optional: true
      },
      %{
        name: :heading,
        type: :integer,
        description:
          "Optional. For live locations, a direction in which the user is moving, in degrees. Must be between 1 and 360 if specified.",
        optional: true
      },
      %{
        name: :proximity_alert_radius,
        type: :integer,
        description:
          "Optional. For live locations, a maximum distance for proximity alerts about approaching another chat member, in meters. Must be between 1 and 100000 if specified.",
        optional: true
      },
      %{
        name: :reply_markup,
        type: Telegex.Type.InlineKeyboardMarkup,
        description: "Optional. Inline keyboard attached to the message",
        optional: true
      },
      %{
        name: :input_message_content,
        type: Telegex.Type.InputMessageContent,
        description: "Optional. Content of the message to be sent instead of the location",
        optional: true
      },
      %{
        name: :thumbnail_url,
        type: :string,
        description: "Optional. Url of the thumbnail for the result",
        optional: true
      },
      %{
        name: :thumbnail_width,
        type: :integer,
        description: "Optional. Thumbnail width",
        optional: true
      },
      %{
        name: :thumbnail_height,
        type: :integer,
        description: "Optional. Thumbnail height",
        optional: true
      }
    ]
  )

  deftype(
    InlineQueryResultVenue,
    "Represents a venue. By default, the venue will be sent by the user. Alternatively, you can use input_message_content to send a message with the specified content instead of the venue.",
    [
      %{
        name: :type,
        type: :string,
        description: "Type of the result, must be venue",
        optional: false
      },
      %{
        name: :id,
        type: :string,
        description: "Unique identifier for this result, 1-64 Bytes",
        optional: false
      },
      %{
        name: :latitude,
        type: :float,
        description: "Latitude of the venue location in degrees",
        optional: false
      },
      %{
        name: :longitude,
        type: :float,
        description: "Longitude of the venue location in degrees",
        optional: false
      },
      %{name: :title, type: :string, description: "Title of the venue", optional: false},
      %{name: :address, type: :string, description: "Address of the venue", optional: false},
      %{
        name: :foursquare_id,
        type: :string,
        description: "Optional. Foursquare identifier of the venue if known",
        optional: true
      },
      %{
        name: :foursquare_type,
        type: :string,
        description:
          "Optional. Foursquare type of the venue, if known. (For example, “arts_entertainment/default”, “arts_entertainment/aquarium” or “food/icecream”.)",
        optional: true
      },
      %{
        name: :google_place_id,
        type: :string,
        description: "Optional. Google Places identifier of the venue",
        optional: true
      },
      %{
        name: :google_place_type,
        type: :string,
        description: "Optional. Google Places type of the venue. (See supported types.)",
        optional: true
      },
      %{
        name: :reply_markup,
        type: Telegex.Type.InlineKeyboardMarkup,
        description: "Optional. Inline keyboard attached to the message",
        optional: true
      },
      %{
        name: :input_message_content,
        type: Telegex.Type.InputMessageContent,
        description: "Optional. Content of the message to be sent instead of the venue",
        optional: true
      },
      %{
        name: :thumbnail_url,
        type: :string,
        description: "Optional. Url of the thumbnail for the result",
        optional: true
      },
      %{
        name: :thumbnail_width,
        type: :integer,
        description: "Optional. Thumbnail width",
        optional: true
      },
      %{
        name: :thumbnail_height,
        type: :integer,
        description: "Optional. Thumbnail height",
        optional: true
      }
    ]
  )

  deftype(
    InlineQueryResultContact,
    "Represents a contact with a phone number. By default, this contact will be sent by the user. Alternatively, you can use input_message_content to send a message with the specified content instead of the contact.",
    [
      %{
        name: :type,
        type: :string,
        description: "Type of the result, must be contact",
        optional: false
      },
      %{
        name: :id,
        type: :string,
        description: "Unique identifier for this result, 1-64 Bytes",
        optional: false
      },
      %{
        name: :phone_number,
        type: :string,
        description: "Contact's phone number",
        optional: false
      },
      %{name: :first_name, type: :string, description: "Contact's first name", optional: false},
      %{
        name: :last_name,
        type: :string,
        description: "Optional. Contact's last name",
        optional: true
      },
      %{
        name: :vcard,
        type: :string,
        description:
          "Optional. Additional data about the contact in the form of a vCard, 0-2048 bytes",
        optional: true
      },
      %{
        name: :reply_markup,
        type: Telegex.Type.InlineKeyboardMarkup,
        description: "Optional. Inline keyboard attached to the message",
        optional: true
      },
      %{
        name: :input_message_content,
        type: Telegex.Type.InputMessageContent,
        description: "Optional. Content of the message to be sent instead of the contact",
        optional: true
      },
      %{
        name: :thumbnail_url,
        type: :string,
        description: "Optional. Url of the thumbnail for the result",
        optional: true
      },
      %{
        name: :thumbnail_width,
        type: :integer,
        description: "Optional. Thumbnail width",
        optional: true
      },
      %{
        name: :thumbnail_height,
        type: :integer,
        description: "Optional. Thumbnail height",
        optional: true
      }
    ]
  )

  deftype(InlineQueryResultGame, "Represents a Game.", [
    %{
      name: :type,
      type: :string,
      description: "Type of the result, must be game",
      optional: false
    },
    %{
      name: :id,
      type: :string,
      description: "Unique identifier for this result, 1-64 bytes",
      optional: false
    },
    %{
      name: :game_short_name,
      type: :string,
      description: "Short name of the game",
      optional: false
    },
    %{
      name: :reply_markup,
      type: Telegex.Type.InlineKeyboardMarkup,
      description: "Optional. Inline keyboard attached to the message",
      optional: true
    }
  ])

  deftype(
    InlineQueryResultCachedPhoto,
    "Represents a link to a photo stored on the Telegram servers. By default, this photo will be sent by the user with an optional caption. Alternatively, you can use input_message_content to send a message with the specified content instead of the photo.",
    [
      %{
        name: :type,
        type: :string,
        description: "Type of the result, must be photo",
        optional: false
      },
      %{
        name: :id,
        type: :string,
        description: "Unique identifier for this result, 1-64 bytes",
        optional: false
      },
      %{
        name: :photo_file_id,
        type: :string,
        description: "A valid file identifier of the photo",
        optional: false
      },
      %{
        name: :title,
        type: :string,
        description: "Optional. Title for the result",
        optional: true
      },
      %{
        name: :description,
        type: :string,
        description: "Optional. Short description of the result",
        optional: true
      },
      %{
        name: :caption,
        type: :string,
        description:
          "Optional. Caption of the photo to be sent, 0-1024 characters after entities parsing",
        optional: true
      },
      %{
        name: :parse_mode,
        type: :string,
        description:
          "Optional. Mode for parsing entities in the photo caption. See formatting options for more details.",
        optional: true
      },
      %{
        name: :caption_entities,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity},
        description:
          "Optional. List of special entities that appear in the caption, which can be specified instead of parse_mode",
        optional: true
      },
      %{
        name: :reply_markup,
        type: Telegex.Type.InlineKeyboardMarkup,
        description: "Optional. Inline keyboard attached to the message",
        optional: true
      },
      %{
        name: :input_message_content,
        type: Telegex.Type.InputMessageContent,
        description: "Optional. Content of the message to be sent instead of the photo",
        optional: true
      }
    ]
  )

  deftype(
    InlineQueryResultCachedGif,
    "Represents a link to an animated GIF file stored on the Telegram servers. By default, this animated GIF file will be sent by the user with an optional caption. Alternatively, you can use input_message_content to send a message with specified content instead of the animation.",
    [
      %{
        name: :type,
        type: :string,
        description: "Type of the result, must be gif",
        optional: false
      },
      %{
        name: :id,
        type: :string,
        description: "Unique identifier for this result, 1-64 bytes",
        optional: false
      },
      %{
        name: :gif_file_id,
        type: :string,
        description: "A valid file identifier for the GIF file",
        optional: false
      },
      %{
        name: :title,
        type: :string,
        description: "Optional. Title for the result",
        optional: true
      },
      %{
        name: :caption,
        type: :string,
        description:
          "Optional. Caption of the GIF file to be sent, 0-1024 characters after entities parsing",
        optional: true
      },
      %{
        name: :parse_mode,
        type: :string,
        description:
          "Optional. Mode for parsing entities in the caption. See formatting options for more details.",
        optional: true
      },
      %{
        name: :caption_entities,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity},
        description:
          "Optional. List of special entities that appear in the caption, which can be specified instead of parse_mode",
        optional: true
      },
      %{
        name: :reply_markup,
        type: Telegex.Type.InlineKeyboardMarkup,
        description: "Optional. Inline keyboard attached to the message",
        optional: true
      },
      %{
        name: :input_message_content,
        type: Telegex.Type.InputMessageContent,
        description: "Optional. Content of the message to be sent instead of the GIF animation",
        optional: true
      }
    ]
  )

  deftype(
    InlineQueryResultCachedMpeg4Gif,
    "Represents a link to a video animation (H.264/MPEG-4 AVC video without sound) stored on the Telegram servers. By default, this animated MPEG-4 file will be sent by the user with an optional caption. Alternatively, you can use input_message_content to send a message with the specified content instead of the animation.",
    [
      %{
        name: :type,
        type: :string,
        description: "Type of the result, must be mpeg4_gif",
        optional: false
      },
      %{
        name: :id,
        type: :string,
        description: "Unique identifier for this result, 1-64 bytes",
        optional: false
      },
      %{
        name: :mpeg4_file_id,
        type: :string,
        description: "A valid file identifier for the MPEG4 file",
        optional: false
      },
      %{
        name: :title,
        type: :string,
        description: "Optional. Title for the result",
        optional: true
      },
      %{
        name: :caption,
        type: :string,
        description:
          "Optional. Caption of the MPEG-4 file to be sent, 0-1024 characters after entities parsing",
        optional: true
      },
      %{
        name: :parse_mode,
        type: :string,
        description:
          "Optional. Mode for parsing entities in the caption. See formatting options for more details.",
        optional: true
      },
      %{
        name: :caption_entities,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity},
        description:
          "Optional. List of special entities that appear in the caption, which can be specified instead of parse_mode",
        optional: true
      },
      %{
        name: :reply_markup,
        type: Telegex.Type.InlineKeyboardMarkup,
        description: "Optional. Inline keyboard attached to the message",
        optional: true
      },
      %{
        name: :input_message_content,
        type: Telegex.Type.InputMessageContent,
        description: "Optional. Content of the message to be sent instead of the video animation",
        optional: true
      }
    ]
  )

  deftype(
    InlineQueryResultCachedSticker,
    "Represents a link to a sticker stored on the Telegram servers. By default, this sticker will be sent by the user. Alternatively, you can use input_message_content to send a message with the specified content instead of the sticker.",
    [
      %{
        name: :type,
        type: :string,
        description: "Type of the result, must be sticker",
        optional: false
      },
      %{
        name: :id,
        type: :string,
        description: "Unique identifier for this result, 1-64 bytes",
        optional: false
      },
      %{
        name: :sticker_file_id,
        type: :string,
        description: "A valid file identifier of the sticker",
        optional: false
      },
      %{
        name: :reply_markup,
        type: Telegex.Type.InlineKeyboardMarkup,
        description: "Optional. Inline keyboard attached to the message",
        optional: true
      },
      %{
        name: :input_message_content,
        type: Telegex.Type.InputMessageContent,
        description: "Optional. Content of the message to be sent instead of the sticker",
        optional: true
      }
    ]
  )

  deftype(
    InlineQueryResultCachedDocument,
    "Represents a link to a file stored on the Telegram servers. By default, this file will be sent by the user with an optional caption. Alternatively, you can use input_message_content to send a message with the specified content instead of the file.",
    [
      %{
        name: :type,
        type: :string,
        description: "Type of the result, must be document",
        optional: false
      },
      %{
        name: :id,
        type: :string,
        description: "Unique identifier for this result, 1-64 bytes",
        optional: false
      },
      %{name: :title, type: :string, description: "Title for the result", optional: false},
      %{
        name: :document_file_id,
        type: :string,
        description: "A valid file identifier for the file",
        optional: false
      },
      %{
        name: :description,
        type: :string,
        description: "Optional. Short description of the result",
        optional: true
      },
      %{
        name: :caption,
        type: :string,
        description:
          "Optional. Caption of the document to be sent, 0-1024 characters after entities parsing",
        optional: true
      },
      %{
        name: :parse_mode,
        type: :string,
        description:
          "Optional. Mode for parsing entities in the document caption. See formatting options for more details.",
        optional: true
      },
      %{
        name: :caption_entities,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity},
        description:
          "Optional. List of special entities that appear in the caption, which can be specified instead of parse_mode",
        optional: true
      },
      %{
        name: :reply_markup,
        type: Telegex.Type.InlineKeyboardMarkup,
        description: "Optional. Inline keyboard attached to the message",
        optional: true
      },
      %{
        name: :input_message_content,
        type: Telegex.Type.InputMessageContent,
        description: "Optional. Content of the message to be sent instead of the file",
        optional: true
      }
    ]
  )

  deftype(
    InlineQueryResultCachedVideo,
    "Represents a link to a video file stored on the Telegram servers. By default, this video file will be sent by the user with an optional caption. Alternatively, you can use input_message_content to send a message with the specified content instead of the video.",
    [
      %{
        name: :type,
        type: :string,
        description: "Type of the result, must be video",
        optional: false
      },
      %{
        name: :id,
        type: :string,
        description: "Unique identifier for this result, 1-64 bytes",
        optional: false
      },
      %{
        name: :video_file_id,
        type: :string,
        description: "A valid file identifier for the video file",
        optional: false
      },
      %{name: :title, type: :string, description: "Title for the result", optional: false},
      %{
        name: :description,
        type: :string,
        description: "Optional. Short description of the result",
        optional: true
      },
      %{
        name: :caption,
        type: :string,
        description:
          "Optional. Caption of the video to be sent, 0-1024 characters after entities parsing",
        optional: true
      },
      %{
        name: :parse_mode,
        type: :string,
        description:
          "Optional. Mode for parsing entities in the video caption. See formatting options for more details.",
        optional: true
      },
      %{
        name: :caption_entities,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity},
        description:
          "Optional. List of special entities that appear in the caption, which can be specified instead of parse_mode",
        optional: true
      },
      %{
        name: :reply_markup,
        type: Telegex.Type.InlineKeyboardMarkup,
        description: "Optional. Inline keyboard attached to the message",
        optional: true
      },
      %{
        name: :input_message_content,
        type: Telegex.Type.InputMessageContent,
        description: "Optional. Content of the message to be sent instead of the video",
        optional: true
      }
    ]
  )

  deftype(
    InlineQueryResultCachedVoice,
    "Represents a link to a voice message stored on the Telegram servers. By default, this voice message will be sent by the user. Alternatively, you can use input_message_content to send a message with the specified content instead of the voice message.",
    [
      %{
        name: :type,
        type: :string,
        description: "Type of the result, must be voice",
        optional: false
      },
      %{
        name: :id,
        type: :string,
        description: "Unique identifier for this result, 1-64 bytes",
        optional: false
      },
      %{
        name: :voice_file_id,
        type: :string,
        description: "A valid file identifier for the voice message",
        optional: false
      },
      %{name: :title, type: :string, description: "Voice message title", optional: false},
      %{
        name: :caption,
        type: :string,
        description: "Optional. Caption, 0-1024 characters after entities parsing",
        optional: true
      },
      %{
        name: :parse_mode,
        type: :string,
        description:
          "Optional. Mode for parsing entities in the voice message caption. See formatting options for more details.",
        optional: true
      },
      %{
        name: :caption_entities,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity},
        description:
          "Optional. List of special entities that appear in the caption, which can be specified instead of parse_mode",
        optional: true
      },
      %{
        name: :reply_markup,
        type: Telegex.Type.InlineKeyboardMarkup,
        description: "Optional. Inline keyboard attached to the message",
        optional: true
      },
      %{
        name: :input_message_content,
        type: Telegex.Type.InputMessageContent,
        description: "Optional. Content of the message to be sent instead of the voice message",
        optional: true
      }
    ]
  )

  deftype(
    InlineQueryResultCachedAudio,
    "Represents a link to an MP3 audio file stored on the Telegram servers. By default, this audio file will be sent by the user. Alternatively, you can use input_message_content to send a message with the specified content instead of the audio.",
    [
      %{
        name: :type,
        type: :string,
        description: "Type of the result, must be audio",
        optional: false
      },
      %{
        name: :id,
        type: :string,
        description: "Unique identifier for this result, 1-64 bytes",
        optional: false
      },
      %{
        name: :audio_file_id,
        type: :string,
        description: "A valid file identifier for the audio file",
        optional: false
      },
      %{
        name: :caption,
        type: :string,
        description: "Optional. Caption, 0-1024 characters after entities parsing",
        optional: true
      },
      %{
        name: :parse_mode,
        type: :string,
        description:
          "Optional. Mode for parsing entities in the audio caption. See formatting options for more details.",
        optional: true
      },
      %{
        name: :caption_entities,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity},
        description:
          "Optional. List of special entities that appear in the caption, which can be specified instead of parse_mode",
        optional: true
      },
      %{
        name: :reply_markup,
        type: Telegex.Type.InlineKeyboardMarkup,
        description: "Optional. Inline keyboard attached to the message",
        optional: true
      },
      %{
        name: :input_message_content,
        type: Telegex.Type.InputMessageContent,
        description: "Optional. Content of the message to be sent instead of the audio",
        optional: true
      }
    ]
  )

  deftype(
    InputTextMessageContent,
    "Represents the content of a text message to be sent as the result of an inline query.",
    [
      %{
        name: :message_text,
        type: :string,
        description: "Text of the message to be sent, 1-4096 characters",
        optional: false
      },
      %{
        name: :parse_mode,
        type: :string,
        description:
          "Optional. Mode for parsing entities in the message text. See formatting options for more details.",
        optional: true
      },
      %{
        name: :entities,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity},
        description:
          "Optional. List of special entities that appear in message text, which can be specified instead of parse_mode",
        optional: true
      },
      %{
        name: :disable_web_page_preview,
        type: :boolean,
        description: "Optional. Disables link previews for links in the sent message",
        optional: true
      }
    ]
  )

  deftype(
    InputLocationMessageContent,
    "Represents the content of a location message to be sent as the result of an inline query.",
    [
      %{
        name: :latitude,
        type: :float,
        description: "Latitude of the location in degrees",
        optional: false
      },
      %{
        name: :longitude,
        type: :float,
        description: "Longitude of the location in degrees",
        optional: false
      },
      %{
        name: :horizontal_accuracy,
        type: :float,
        description:
          "Optional. The radius of uncertainty for the location, measured in meters; 0-1500",
        optional: true
      },
      %{
        name: :live_period,
        type: :integer,
        description:
          "Optional. Period in seconds for which the location can be updated, should be between 60 and 86400.",
        optional: true
      },
      %{
        name: :heading,
        type: :integer,
        description:
          "Optional. For live locations, a direction in which the user is moving, in degrees. Must be between 1 and 360 if specified.",
        optional: true
      },
      %{
        name: :proximity_alert_radius,
        type: :integer,
        description:
          "Optional. For live locations, a maximum distance for proximity alerts about approaching another chat member, in meters. Must be between 1 and 100000 if specified.",
        optional: true
      }
    ]
  )

  deftype(
    InputVenueMessageContent,
    "Represents the content of a venue message to be sent as the result of an inline query.",
    [
      %{
        name: :latitude,
        type: :float,
        description: "Latitude of the venue in degrees",
        optional: false
      },
      %{
        name: :longitude,
        type: :float,
        description: "Longitude of the venue in degrees",
        optional: false
      },
      %{name: :title, type: :string, description: "Name of the venue", optional: false},
      %{name: :address, type: :string, description: "Address of the venue", optional: false},
      %{
        name: :foursquare_id,
        type: :string,
        description: "Optional. Foursquare identifier of the venue, if known",
        optional: true
      },
      %{
        name: :foursquare_type,
        type: :string,
        description:
          "Optional. Foursquare type of the venue, if known. (For example, “arts_entertainment/default”, “arts_entertainment/aquarium” or “food/icecream”.)",
        optional: true
      },
      %{
        name: :google_place_id,
        type: :string,
        description: "Optional. Google Places identifier of the venue",
        optional: true
      },
      %{
        name: :google_place_type,
        type: :string,
        description: "Optional. Google Places type of the venue. (See supported types.)",
        optional: true
      }
    ]
  )

  deftype(
    InputContactMessageContent,
    "Represents the content of a contact message to be sent as the result of an inline query.",
    [
      %{
        name: :phone_number,
        type: :string,
        description: "Contact's phone number",
        optional: false
      },
      %{name: :first_name, type: :string, description: "Contact's first name", optional: false},
      %{
        name: :last_name,
        type: :string,
        description: "Optional. Contact's last name",
        optional: true
      },
      %{
        name: :vcard,
        type: :string,
        description:
          "Optional. Additional data about the contact in the form of a vCard, 0-2048 bytes",
        optional: true
      }
    ]
  )

  deftype(
    InputInvoiceMessageContent,
    "Represents the content of an invoice message to be sent as the result of an inline query.",
    [
      %{
        name: :title,
        type: :string,
        description: "Product name, 1-32 characters",
        optional: false
      },
      %{
        name: :description,
        type: :string,
        description: "Product description, 1-255 characters",
        optional: false
      },
      %{
        name: :payload,
        type: :string,
        description:
          "Bot-defined invoice payload, 1-128 bytes. This will not be displayed to the user, use for your internal processes.",
        optional: false
      },
      %{
        name: :provider_token,
        type: :string,
        description: "Payment provider token, obtained via @BotFather",
        optional: false
      },
      %{
        name: :currency,
        type: :string,
        description: "Three-letter ISO 4217 currency code, see more on currencies",
        optional: false
      },
      %{
        name: :prices,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.LabeledPrice},
        description:
          "Price breakdown, a JSON-serialized list of components (e.g. product price, tax, discount, delivery cost, delivery tax, bonus, etc.)",
        optional: false
      },
      %{
        name: :max_tip_amount,
        type: :integer,
        description:
          "Optional. The maximum accepted amount for tips in the smallest units of the currency (integer, not float/double). For example, for a maximum tip of US$ 1.45 pass max_tip_amount = 145. See the exp parameter in currencies.json, it shows the number of digits past the decimal point for each currency (2 for the majority of currencies). Defaults to 0",
        optional: true
      },
      %{
        name: :suggested_tip_amounts,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: :integer},
        description:
          "Optional. A JSON-serialized array of suggested amounts of tip in the smallest units of the currency (integer, not float/double). At most 4 suggested tip amounts can be specified. The suggested tip amounts must be positive, passed in a strictly increased order and must not exceed max_tip_amount.",
        optional: true
      },
      %{
        name: :provider_data,
        type: :string,
        description:
          "Optional. A JSON-serialized object for data about the invoice, which will be shared with the payment provider. A detailed description of the required fields should be provided by the payment provider.",
        optional: true
      },
      %{
        name: :photo_url,
        type: :string,
        description:
          "Optional. URL of the product photo for the invoice. Can be a photo of the goods or a marketing image for a service.",
        optional: true
      },
      %{
        name: :photo_size,
        type: :integer,
        description: "Optional. Photo size in bytes",
        optional: true
      },
      %{name: :photo_width, type: :integer, description: "Optional. Photo width", optional: true},
      %{
        name: :photo_height,
        type: :integer,
        description: "Optional. Photo height",
        optional: true
      },
      %{
        name: :need_name,
        type: :boolean,
        description:
          "Optional. Pass True if you require the user's full name to complete the order",
        optional: true
      },
      %{
        name: :need_phone_number,
        type: :boolean,
        description:
          "Optional. Pass True if you require the user's phone number to complete the order",
        optional: true
      },
      %{
        name: :need_email,
        type: :boolean,
        description:
          "Optional. Pass True if you require the user's email address to complete the order",
        optional: true
      },
      %{
        name: :need_shipping_address,
        type: :boolean,
        description:
          "Optional. Pass True if you require the user's shipping address to complete the order",
        optional: true
      },
      %{
        name: :send_phone_number_to_provider,
        type: :boolean,
        description: "Optional. Pass True if the user's phone number should be sent to provider",
        optional: true
      },
      %{
        name: :send_email_to_provider,
        type: :boolean,
        description: "Optional. Pass True if the user's email address should be sent to provider",
        optional: true
      },
      %{
        name: :is_flexible,
        type: :boolean,
        description: "Optional. Pass True if the final price depends on the shipping method",
        optional: true
      }
    ]
  )

  deftype(
    ChosenInlineResult,
    "Represents a result of an inline query that was chosen by the user and sent to their chat partner.",
    [
      %{
        name: :result_id,
        type: :string,
        description: "The unique identifier for the result that was chosen",
        optional: false
      },
      %{
        name: :from,
        type: Telegex.Type.User,
        description: "The user that chose the result",
        optional: false
      },
      %{
        name: :location,
        type: Telegex.Type.Location,
        description: "Optional. Sender location, only for bots that require user location",
        optional: true
      },
      %{
        name: :inline_message_id,
        type: :string,
        description:
          "Optional. Identifier of the sent inline message. Available only if there is an inline keyboard attached to the message. Will be also received in callback queries and can be used to edit the message.",
        optional: true
      },
      %{
        name: :query,
        type: :string,
        description: "The query that was used to obtain the result",
        optional: false
      }
    ]
  )

  deftype(
    SentWebAppMessage,
    "Describes an inline message sent by a Web App on behalf of a user.",
    [
      %{
        name: :inline_message_id,
        type: :string,
        description:
          "Optional. Identifier of the sent inline message. Available only if there is an inline keyboard attached to the message.",
        optional: true
      }
    ]
  )

  deftype(LabeledPrice, "This object represents a portion of the price for goods or services.", [
    %{name: :label, type: :string, description: "Portion label", optional: false},
    %{
      name: :amount,
      type: :integer,
      description:
        "Price of the product in the smallest units of the currency (integer, not float/double). For example, for a price of US$ 1.45 pass amount = 145. See the exp parameter in currencies.json, it shows the number of digits past the decimal point for each currency (2 for the majority of currencies).",
      optional: false
    }
  ])

  deftype(Invoice, "This object contains basic information about an invoice.", [
    %{name: :title, type: :string, description: "Product name", optional: false},
    %{name: :description, type: :string, description: "Product description", optional: false},
    %{
      name: :start_parameter,
      type: :string,
      description: "Unique bot deep-linking parameter that can be used to generate this invoice",
      optional: false
    },
    %{
      name: :currency,
      type: :string,
      description: "Three-letter ISO 4217 currency code",
      optional: false
    },
    %{
      name: :total_amount,
      type: :integer,
      description:
        "Total price in the smallest units of the currency (integer, not float/double). For example, for a price of US$ 1.45 pass amount = 145. See the exp parameter in currencies.json, it shows the number of digits past the decimal point for each currency (2 for the majority of currencies).",
      optional: false
    }
  ])

  deftype(ShippingAddress, "This object represents a shipping address.", [
    %{
      name: :country_code,
      type: :string,
      description: "Two-letter ISO 3166-1 alpha-2 country code",
      optional: false
    },
    %{name: :state, type: :string, description: "State, if applicable", optional: false},
    %{name: :city, type: :string, description: "City", optional: false},
    %{
      name: :street_line1,
      type: :string,
      description: "First line for the address",
      optional: false
    },
    %{
      name: :street_line2,
      type: :string,
      description: "Second line for the address",
      optional: false
    },
    %{name: :post_code, type: :string, description: "Address post code", optional: false}
  ])

  deftype(OrderInfo, "This object represents information about an order.", [
    %{name: :name, type: :string, description: "Optional. User name", optional: true},
    %{
      name: :phone_number,
      type: :string,
      description: "Optional. User's phone number",
      optional: true
    },
    %{name: :email, type: :string, description: "Optional. User email", optional: true},
    %{
      name: :shipping_address,
      type: Telegex.Type.ShippingAddress,
      description: "Optional. User shipping address",
      optional: true
    }
  ])

  deftype(ShippingOption, "This object represents one shipping option.", [
    %{name: :id, type: :string, description: "Shipping option identifier", optional: false},
    %{name: :title, type: :string, description: "Option title", optional: false},
    %{
      name: :prices,
      type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.LabeledPrice},
      description: "List of price portions",
      optional: false
    }
  ])

  deftype(
    SuccessfulPayment,
    "This object contains basic information about a successful payment.",
    [
      %{
        name: :currency,
        type: :string,
        description: "Three-letter ISO 4217 currency code",
        optional: false
      },
      %{
        name: :total_amount,
        type: :integer,
        description:
          "Total price in the smallest units of the currency (integer, not float/double). For example, for a price of US$ 1.45 pass amount = 145. See the exp parameter in currencies.json, it shows the number of digits past the decimal point for each currency (2 for the majority of currencies).",
        optional: false
      },
      %{
        name: :invoice_payload,
        type: :string,
        description: "Bot specified invoice payload",
        optional: false
      },
      %{
        name: :shipping_option_id,
        type: :string,
        description: "Optional. Identifier of the shipping option chosen by the user",
        optional: true
      },
      %{
        name: :order_info,
        type: Telegex.Type.OrderInfo,
        description: "Optional. Order information provided by the user",
        optional: true
      },
      %{
        name: :telegram_payment_charge_id,
        type: :string,
        description: "Telegram payment identifier",
        optional: false
      },
      %{
        name: :provider_payment_charge_id,
        type: :string,
        description: "Provider payment identifier",
        optional: false
      }
    ]
  )

  deftype(ShippingQuery, "This object contains information about an incoming shipping query.", [
    %{name: :id, type: :string, description: "Unique query identifier", optional: false},
    %{
      name: :from,
      type: Telegex.Type.User,
      description: "User who sent the query",
      optional: false
    },
    %{
      name: :invoice_payload,
      type: :string,
      description: "Bot specified invoice payload",
      optional: false
    },
    %{
      name: :shipping_address,
      type: Telegex.Type.ShippingAddress,
      description: "User specified shipping address",
      optional: false
    }
  ])

  deftype(
    PreCheckoutQuery,
    "This object contains information about an incoming pre-checkout query.",
    [
      %{name: :id, type: :string, description: "Unique query identifier", optional: false},
      %{
        name: :from,
        type: Telegex.Type.User,
        description: "User who sent the query",
        optional: false
      },
      %{
        name: :currency,
        type: :string,
        description: "Three-letter ISO 4217 currency code",
        optional: false
      },
      %{
        name: :total_amount,
        type: :integer,
        description:
          "Total price in the smallest units of the currency (integer, not float/double). For example, for a price of US$ 1.45 pass amount = 145. See the exp parameter in currencies.json, it shows the number of digits past the decimal point for each currency (2 for the majority of currencies).",
        optional: false
      },
      %{
        name: :invoice_payload,
        type: :string,
        description: "Bot specified invoice payload",
        optional: false
      },
      %{
        name: :shipping_option_id,
        type: :string,
        description: "Optional. Identifier of the shipping option chosen by the user",
        optional: true
      },
      %{
        name: :order_info,
        type: Telegex.Type.OrderInfo,
        description: "Optional. Order information provided by the user",
        optional: true
      }
    ]
  )

  deftype(PassportData, "Describes Telegram Passport data shared with the bot by the user.", [
    %{
      name: :data,
      type: %{
        __struct__: Telegex.TypeDefiner.ArrayType,
        elem_type: Telegex.Type.EncryptedPassportElement
      },
      description:
        "Array with information about documents and other Telegram Passport elements that was shared with the bot",
      optional: false
    },
    %{
      name: :credentials,
      type: Telegex.Type.EncryptedCredentials,
      description: "Encrypted credentials required to decrypt the data",
      optional: false
    }
  ])

  deftype(
    PassportFile,
    "This object represents a file uploaded to Telegram Passport. Currently all Telegram Passport files are in JPEG format when decrypted and don't exceed 10MB.",
    [
      %{
        name: :file_id,
        type: :string,
        description: "Identifier for this file, which can be used to download or reuse the file",
        optional: false
      },
      %{
        name: :file_unique_id,
        type: :string,
        description:
          "Unique identifier for this file, which is supposed to be the same over time and for different bots. Can't be used to download or reuse the file.",
        optional: false
      },
      %{name: :file_size, type: :integer, description: "File size in bytes", optional: false},
      %{
        name: :file_date,
        type: :integer,
        description: "Unix time when the file was uploaded",
        optional: false
      }
    ]
  )

  deftype(
    EncryptedPassportElement,
    "Describes documents or other Telegram Passport elements shared with the bot by the user.",
    [
      %{
        name: :type,
        type: :string,
        description:
          "Element type. One of “personal_details”, “passport”, “driver_license”, “identity_card”, “internal_passport”, “address”, “utility_bill”, “bank_statement”, “rental_agreement”, “passport_registration”, “temporary_registration”, “phone_number”, “email”.",
        optional: false
      },
      %{
        name: :data,
        type: :string,
        description:
          "Optional. Base64-encoded encrypted Telegram Passport element data provided by the user, available for “personal_details”, “passport”, “driver_license”, “identity_card”, “internal_passport” and “address” types. Can be decrypted and verified using the accompanying EncryptedCredentials.",
        optional: true
      },
      %{
        name: :phone_number,
        type: :string,
        description:
          "Optional. User's verified phone number, available only for “phone_number” type",
        optional: true
      },
      %{
        name: :email,
        type: :string,
        description: "Optional. User's verified email address, available only for “email” type",
        optional: true
      },
      %{
        name: :files,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.PassportFile},
        description:
          "Optional. Array of encrypted files with documents provided by the user, available for “utility_bill”, “bank_statement”, “rental_agreement”, “passport_registration” and “temporary_registration” types. Files can be decrypted and verified using the accompanying EncryptedCredentials.",
        optional: true
      },
      %{
        name: :front_side,
        type: Telegex.Type.PassportFile,
        description:
          "Optional. Encrypted file with the front side of the document, provided by the user. Available for “passport”, “driver_license”, “identity_card” and “internal_passport”. The file can be decrypted and verified using the accompanying EncryptedCredentials.",
        optional: true
      },
      %{
        name: :reverse_side,
        type: Telegex.Type.PassportFile,
        description:
          "Optional. Encrypted file with the reverse side of the document, provided by the user. Available for “driver_license” and “identity_card”. The file can be decrypted and verified using the accompanying EncryptedCredentials.",
        optional: true
      },
      %{
        name: :selfie,
        type: Telegex.Type.PassportFile,
        description:
          "Optional. Encrypted file with the selfie of the user holding a document, provided by the user; available for “passport”, “driver_license”, “identity_card” and “internal_passport”. The file can be decrypted and verified using the accompanying EncryptedCredentials.",
        optional: true
      },
      %{
        name: :translation,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.PassportFile},
        description:
          "Optional. Array of encrypted files with translated versions of documents provided by the user. Available if requested for “passport”, “driver_license”, “identity_card”, “internal_passport”, “utility_bill”, “bank_statement”, “rental_agreement”, “passport_registration” and “temporary_registration” types. Files can be decrypted and verified using the accompanying EncryptedCredentials.",
        optional: true
      },
      %{
        name: :hash,
        type: :string,
        description: "Base64-encoded element hash for using in PassportElementErrorUnspecified",
        optional: false
      }
    ]
  )

  deftype(
    EncryptedCredentials,
    "Describes data required for decrypting and authenticating EncryptedPassportElement. See the Telegram Passport Documentation for a complete description of the data decryption and authentication processes.",
    [
      %{
        name: :data,
        type: :string,
        description:
          "Base64-encoded encrypted JSON-serialized data with unique user's payload, data hashes and secrets required for EncryptedPassportElement decryption and authentication",
        optional: false
      },
      %{
        name: :hash,
        type: :string,
        description: "Base64-encoded data hash for data authentication",
        optional: false
      },
      %{
        name: :secret,
        type: :string,
        description:
          "Base64-encoded secret, encrypted with the bot's public RSA key, required for data decryption",
        optional: false
      }
    ]
  )

  deftype(
    PassportElementErrorDataField,
    "Represents an issue in one of the data fields that was provided by the user. The error is considered resolved when the field's value changes.",
    [
      %{name: :source, type: :string, description: "Error source, must be data", optional: false},
      %{
        name: :type,
        type: :string,
        description:
          "The section of the user's Telegram Passport which has the error, one of “personal_details”, “passport”, “driver_license”, “identity_card”, “internal_passport”, “address”",
        optional: false
      },
      %{
        name: :field_name,
        type: :string,
        description: "Name of the data field which has the error",
        optional: false
      },
      %{
        name: :data_hash,
        type: :string,
        description: "Base64-encoded data hash",
        optional: false
      },
      %{name: :message, type: :string, description: "Error message", optional: false}
    ]
  )

  deftype(
    PassportElementErrorFrontSide,
    "Represents an issue with the front side of a document. The error is considered resolved when the file with the front side of the document changes.",
    [
      %{
        name: :source,
        type: :string,
        description: "Error source, must be front_side",
        optional: false
      },
      %{
        name: :type,
        type: :string,
        description:
          "The section of the user's Telegram Passport which has the issue, one of “passport”, “driver_license”, “identity_card”, “internal_passport”",
        optional: false
      },
      %{
        name: :file_hash,
        type: :string,
        description: "Base64-encoded hash of the file with the front side of the document",
        optional: false
      },
      %{name: :message, type: :string, description: "Error message", optional: false}
    ]
  )

  deftype(
    PassportElementErrorReverseSide,
    "Represents an issue with the reverse side of a document. The error is considered resolved when the file with reverse side of the document changes.",
    [
      %{
        name: :source,
        type: :string,
        description: "Error source, must be reverse_side",
        optional: false
      },
      %{
        name: :type,
        type: :string,
        description:
          "The section of the user's Telegram Passport which has the issue, one of “driver_license”, “identity_card”",
        optional: false
      },
      %{
        name: :file_hash,
        type: :string,
        description: "Base64-encoded hash of the file with the reverse side of the document",
        optional: false
      },
      %{name: :message, type: :string, description: "Error message", optional: false}
    ]
  )

  deftype(
    PassportElementErrorSelfie,
    "Represents an issue with the selfie with a document. The error is considered resolved when the file with the selfie changes.",
    [
      %{
        name: :source,
        type: :string,
        description: "Error source, must be selfie",
        optional: false
      },
      %{
        name: :type,
        type: :string,
        description:
          "The section of the user's Telegram Passport which has the issue, one of “passport”, “driver_license”, “identity_card”, “internal_passport”",
        optional: false
      },
      %{
        name: :file_hash,
        type: :string,
        description: "Base64-encoded hash of the file with the selfie",
        optional: false
      },
      %{name: :message, type: :string, description: "Error message", optional: false}
    ]
  )

  deftype(
    PassportElementErrorFile,
    "Represents an issue with a document scan. The error is considered resolved when the file with the document scan changes.",
    [
      %{name: :source, type: :string, description: "Error source, must be file", optional: false},
      %{
        name: :type,
        type: :string,
        description:
          "The section of the user's Telegram Passport which has the issue, one of “utility_bill”, “bank_statement”, “rental_agreement”, “passport_registration”, “temporary_registration”",
        optional: false
      },
      %{
        name: :file_hash,
        type: :string,
        description: "Base64-encoded file hash",
        optional: false
      },
      %{name: :message, type: :string, description: "Error message", optional: false}
    ]
  )

  deftype(
    PassportElementErrorFiles,
    "Represents an issue with a list of scans. The error is considered resolved when the list of files containing the scans changes.",
    [
      %{
        name: :source,
        type: :string,
        description: "Error source, must be files",
        optional: false
      },
      %{
        name: :type,
        type: :string,
        description:
          "The section of the user's Telegram Passport which has the issue, one of “utility_bill”, “bank_statement”, “rental_agreement”, “passport_registration”, “temporary_registration”",
        optional: false
      },
      %{
        name: :file_hashes,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: :string},
        description: "List of base64-encoded file hashes",
        optional: false
      },
      %{name: :message, type: :string, description: "Error message", optional: false}
    ]
  )

  deftype(
    PassportElementErrorTranslationFile,
    "Represents an issue with one of the files that constitute the translation of a document. The error is considered resolved when the file changes.",
    [
      %{
        name: :source,
        type: :string,
        description: "Error source, must be translation_file",
        optional: false
      },
      %{
        name: :type,
        type: :string,
        description:
          "Type of element of the user's Telegram Passport which has the issue, one of “passport”, “driver_license”, “identity_card”, “internal_passport”, “utility_bill”, “bank_statement”, “rental_agreement”, “passport_registration”, “temporary_registration”",
        optional: false
      },
      %{
        name: :file_hash,
        type: :string,
        description: "Base64-encoded file hash",
        optional: false
      },
      %{name: :message, type: :string, description: "Error message", optional: false}
    ]
  )

  deftype(
    PassportElementErrorTranslationFiles,
    "Represents an issue with the translated version of a document. The error is considered resolved when a file with the document translation change.",
    [
      %{
        name: :source,
        type: :string,
        description: "Error source, must be translation_files",
        optional: false
      },
      %{
        name: :type,
        type: :string,
        description:
          "Type of element of the user's Telegram Passport which has the issue, one of “passport”, “driver_license”, “identity_card”, “internal_passport”, “utility_bill”, “bank_statement”, “rental_agreement”, “passport_registration”, “temporary_registration”",
        optional: false
      },
      %{
        name: :file_hashes,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: :string},
        description: "List of base64-encoded file hashes",
        optional: false
      },
      %{name: :message, type: :string, description: "Error message", optional: false}
    ]
  )

  deftype(
    PassportElementErrorUnspecified,
    "Represents an issue in an unspecified place. The error is considered resolved when new data is added.",
    [
      %{
        name: :source,
        type: :string,
        description: "Error source, must be unspecified",
        optional: false
      },
      %{
        name: :type,
        type: :string,
        description: "Type of element of the user's Telegram Passport which has the issue",
        optional: false
      },
      %{
        name: :element_hash,
        type: :string,
        description: "Base64-encoded element hash",
        optional: false
      },
      %{name: :message, type: :string, description: "Error message", optional: false}
    ]
  )

  deftype(
    Game,
    "This object represents a game. Use BotFather to create and edit games, their short names will act as unique identifiers.",
    [
      %{name: :title, type: :string, description: "Title of the game", optional: false},
      %{
        name: :description,
        type: :string,
        description: "Description of the game",
        optional: false
      },
      %{
        name: :photo,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.PhotoSize},
        description: "Photo that will be displayed in the game message in chats.",
        optional: false
      },
      %{
        name: :text,
        type: :string,
        description:
          "Optional. Brief description of the game or high scores included in the game message. Can be automatically edited to include current high scores for the game when the bot calls setGameScore, or manually edited using editMessageText. 0-4096 characters.",
        optional: true
      },
      %{
        name: :text_entities,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity},
        description:
          "Optional. Special entities that appear in text, such as usernames, URLs, bot commands, etc.",
        optional: true
      },
      %{
        name: :animation,
        type: Telegex.Type.Animation,
        description:
          "Optional. Animation that will be displayed in the game message in chats. Upload via BotFather",
        optional: true
      }
    ]
  )

  deftype(
    CallbackGame,
    "A placeholder, currently holds no information. Use BotFather to set up your game.",
    []
  )

  deftype(GameHighScore, "This object represents one row of the high scores table for a game.", [
    %{
      name: :position,
      type: :integer,
      description: "Position in high score table for the game",
      optional: false
    },
    %{name: :user, type: Telegex.Type.User, description: "User", optional: false},
    %{name: :score, type: :integer, description: "Score", optional: false}
  ])
end
