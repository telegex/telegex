defmodule Telegex.Type do
  @moduledoc "All types used in the Bot API responses."

  use Telegex.TypeDefiner

  @type error :: Telegex.Error.t() | Telegex.RequestError.t()

  defunion(
    MaybeInaccessibleMessage,
    "This object describes a message that can be inaccessible to the bot. It can be one of",
    [Telegex.Type.Message, Telegex.Type.InaccessibleMessage],
    []
  )

  defunion(
    MessageOrigin,
    "This object describes the origin of a message. It can be one of",
    [
      Telegex.Type.MessageOriginUser,
      Telegex.Type.MessageOriginHiddenUser,
      Telegex.Type.MessageOriginChat,
      Telegex.Type.MessageOriginChannel
    ],
    discriminant: %{
      field: :type,
      mapping: %{
        "channel" => [Telegex.Type.MessageOriginChannel],
        "chat" => [Telegex.Type.MessageOriginChat],
        "hidden_user" => [Telegex.Type.MessageOriginHiddenUser],
        "user" => [Telegex.Type.MessageOriginUser]
      }
    }
  )

  defunion(
    PaidMedia,
    "This object describes paid media. Currently, it can be one of",
    [Telegex.Type.PaidMediaPreview, Telegex.Type.PaidMediaPhoto, Telegex.Type.PaidMediaVideo],
    discriminant: %{
      field: :type,
      mapping: %{
        "photo" => [Telegex.Type.PaidMediaPhoto],
        "preview" => [Telegex.Type.PaidMediaPreview],
        "video" => [Telegex.Type.PaidMediaVideo]
      }
    }
  )

  defunion(
    BackgroundFill,
    "This object describes the way a background is filled based on the selected colors. Currently, it can be one of",
    [
      Telegex.Type.BackgroundFillSolid,
      Telegex.Type.BackgroundFillGradient,
      Telegex.Type.BackgroundFillFreeformGradient
    ],
    discriminant: %{
      field: :type,
      mapping: %{
        "freeform_gradient" => [Telegex.Type.BackgroundFillFreeformGradient],
        "gradient" => [Telegex.Type.BackgroundFillGradient],
        "solid" => [Telegex.Type.BackgroundFillSolid]
      }
    }
  )

  defunion(
    BackgroundType,
    "This object describes the type of a background. Currently, it can be one of",
    [
      Telegex.Type.BackgroundTypeFill,
      Telegex.Type.BackgroundTypeWallpaper,
      Telegex.Type.BackgroundTypePattern,
      Telegex.Type.BackgroundTypeChatTheme
    ],
    discriminant: %{
      field: :type,
      mapping: %{
        "chat_theme" => [Telegex.Type.BackgroundTypeChatTheme],
        "fill" => [Telegex.Type.BackgroundTypeFill],
        "pattern" => [Telegex.Type.BackgroundTypePattern],
        "wallpaper" => [Telegex.Type.BackgroundTypeWallpaper]
      }
    }
  )

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
    ReactionType,
    "This object describes the type of a reaction. Currently, it can be one of",
    [
      Telegex.Type.ReactionTypeEmoji,
      Telegex.Type.ReactionTypeCustomEmoji,
      Telegex.Type.ReactionTypePaid
    ],
    discriminant: %{
      field: :type,
      mapping: %{
        "custom_emoji" => [Telegex.Type.ReactionTypeCustomEmoji],
        "emoji" => [Telegex.Type.ReactionTypeEmoji],
        "paid" => [Telegex.Type.ReactionTypePaid]
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
    ChatBoostSource,
    "This object describes the source of a chat boost. It can be one of",
    [
      Telegex.Type.ChatBoostSourcePremium,
      Telegex.Type.ChatBoostSourceGiftCode,
      Telegex.Type.ChatBoostSourceGiveaway
    ],
    discriminant: %{
      field: :source,
      mapping: %{
        "gift_code" => [Telegex.Type.ChatBoostSourceGiftCode],
        "giveaway" => [Telegex.Type.ChatBoostSourceGiveaway],
        "premium" => [Telegex.Type.ChatBoostSourcePremium]
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
    InputPaidMedia,
    "This object describes the paid media to be sent. Currently, it can be one of",
    [Telegex.Type.InputPaidMediaPhoto, Telegex.Type.InputPaidMediaVideo],
    discriminant: %{
      field: :type,
      mapping: %{
        "photo" => [Telegex.Type.InputPaidMediaPhoto],
        "video" => [Telegex.Type.InputPaidMediaVideo]
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
    RevenueWithdrawalState,
    "This object describes the state of a revenue withdrawal operation. Currently, it can be one of",
    [
      Telegex.Type.RevenueWithdrawalStatePending,
      Telegex.Type.RevenueWithdrawalStateSucceeded,
      Telegex.Type.RevenueWithdrawalStateFailed
    ],
    discriminant: %{
      field: :type,
      mapping: %{
        "failed" => [Telegex.Type.RevenueWithdrawalStateFailed],
        "pending" => [Telegex.Type.RevenueWithdrawalStatePending],
        "succeeded" => [Telegex.Type.RevenueWithdrawalStateSucceeded]
      }
    }
  )

  defunion(
    TransactionPartner,
    "This object describes the source of a transaction, or its recipient for outgoing transactions. Currently, it can be one of",
    [
      Telegex.Type.TransactionPartnerUser,
      Telegex.Type.TransactionPartnerFragment,
      Telegex.Type.TransactionPartnerTelegramAds,
      Telegex.Type.TransactionPartnerTelegramApi,
      Telegex.Type.TransactionPartnerOther
    ],
    discriminant: %{
      field: :type,
      mapping: %{
        "fragment" => [Telegex.Type.TransactionPartnerFragment],
        "other" => [Telegex.Type.TransactionPartnerOther],
        "telegram_ads" => [Telegex.Type.TransactionPartnerTelegramAds],
        "telegram_api" => [Telegex.Type.TransactionPartnerTelegramApi],
        "user" => [Telegex.Type.TransactionPartnerUser]
      }
    }
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
      description:
        "The update's unique identifier. Update identifiers start from a certain positive number and increase sequentially. This identifier becomes especially handy if you're using webhooks, since it allows you to ignore repeated updates or to restore the correct update sequence, should they get out of order. If there are no new updates for at least a week, then identifier of the next update will be chosen randomly instead of sequentially.",
      name: :update_id,
      optional: false,
      type: :integer
    },
    %{
      description: "Optional. New incoming message of any kind - text, photo, sticker, etc.",
      name: :message,
      optional: true,
      type: Telegex.Type.Message
    },
    %{
      description:
        "Optional. New version of a message that is known to the bot and was edited. This update may at times be triggered by changes to message fields that are either unavailable or not actively used by your bot.",
      name: :edited_message,
      optional: true,
      type: Telegex.Type.Message
    },
    %{
      description: "Optional. New incoming channel post of any kind - text, photo, sticker, etc.",
      name: :channel_post,
      optional: true,
      type: Telegex.Type.Message
    },
    %{
      description:
        "Optional. New version of a channel post that is known to the bot and was edited. This update may at times be triggered by changes to message fields that are either unavailable or not actively used by your bot.",
      name: :edited_channel_post,
      optional: true,
      type: Telegex.Type.Message
    },
    %{
      description:
        "Optional. The bot was connected to or disconnected from a business account, or a user edited an existing connection with the bot",
      name: :business_connection,
      optional: true,
      type: Telegex.Type.BusinessConnection
    },
    %{
      description: "Optional. New message from a connected business account",
      name: :business_message,
      optional: true,
      type: Telegex.Type.Message
    },
    %{
      description: "Optional. New version of a message from a connected business account",
      name: :edited_business_message,
      optional: true,
      type: Telegex.Type.Message
    },
    %{
      description: "Optional. Messages were deleted from a connected business account",
      name: :deleted_business_messages,
      optional: true,
      type: Telegex.Type.BusinessMessagesDeleted
    },
    %{
      description:
        "Optional. A reaction to a message was changed by a user. The bot must be an administrator in the chat and must explicitly specify \"message_reaction\" in the list of allowed_updates to receive these updates. The update isn't received for reactions set by bots.",
      name: :message_reaction,
      optional: true,
      type: Telegex.Type.MessageReactionUpdated
    },
    %{
      description:
        "Optional. Reactions to a message with anonymous reactions were changed. The bot must be an administrator in the chat and must explicitly specify \"message_reaction_count\" in the list of allowed_updates to receive these updates. The updates are grouped and can be sent with delay up to a few minutes.",
      name: :message_reaction_count,
      optional: true,
      type: Telegex.Type.MessageReactionCountUpdated
    },
    %{
      description: "Optional. New incoming inline query",
      name: :inline_query,
      optional: true,
      type: Telegex.Type.InlineQuery
    },
    %{
      description:
        "Optional. The result of an inline query that was chosen by a user and sent to their chat partner. Please see our documentation on the feedback collecting for details on how to enable these updates for your bot.",
      name: :chosen_inline_result,
      optional: true,
      type: Telegex.Type.ChosenInlineResult
    },
    %{
      description: "Optional. New incoming callback query",
      name: :callback_query,
      optional: true,
      type: Telegex.Type.CallbackQuery
    },
    %{
      description: "Optional. New incoming shipping query. Only for invoices with flexible price",
      name: :shipping_query,
      optional: true,
      type: Telegex.Type.ShippingQuery
    },
    %{
      description:
        "Optional. New incoming pre-checkout query. Contains full information about checkout",
      name: :pre_checkout_query,
      optional: true,
      type: Telegex.Type.PreCheckoutQuery
    },
    %{
      description:
        "Optional. A user purchased paid media with a non-empty payload sent by the bot in a non-channel chat",
      name: :purchased_paid_media,
      optional: true,
      type: Telegex.Type.PaidMediaPurchased
    },
    %{
      description:
        "Optional. New poll state. Bots receive only updates about manually stopped polls and polls, which are sent by the bot",
      name: :poll,
      optional: true,
      type: Telegex.Type.Poll
    },
    %{
      description:
        "Optional. A user changed their answer in a non-anonymous poll. Bots receive new votes only in polls that were sent by the bot itself.",
      name: :poll_answer,
      optional: true,
      type: Telegex.Type.PollAnswer
    },
    %{
      description:
        "Optional. The bot's chat member status was updated in a chat. For private chats, this update is received only when the bot is blocked or unblocked by the user.",
      name: :my_chat_member,
      optional: true,
      type: Telegex.Type.ChatMemberUpdated
    },
    %{
      description:
        "Optional. A chat member's status was updated in a chat. The bot must be an administrator in the chat and must explicitly specify \"chat_member\" in the list of allowed_updates to receive these updates.",
      name: :chat_member,
      optional: true,
      type: Telegex.Type.ChatMemberUpdated
    },
    %{
      description:
        "Optional. A request to join the chat has been sent. The bot must have the can_invite_users administrator right in the chat to receive these updates.",
      name: :chat_join_request,
      optional: true,
      type: Telegex.Type.ChatJoinRequest
    },
    %{
      description:
        "Optional. A chat boost was added or changed. The bot must be an administrator in the chat to receive these updates.",
      name: :chat_boost,
      optional: true,
      type: Telegex.Type.ChatBoostUpdated
    },
    %{
      description:
        "Optional. A boost was removed from a chat. The bot must be an administrator in the chat to receive these updates.",
      name: :removed_chat_boost,
      optional: true,
      type: Telegex.Type.ChatBoostRemoved
    }
  ])

  deftype(WebhookInfo, "Describes the current status of a webhook.", [
    %{
      description: "Webhook URL, may be empty if webhook is not set up",
      name: :url,
      optional: false,
      type: :string
    },
    %{
      description: "True, if a custom certificate was provided for webhook certificate checks",
      name: :has_custom_certificate,
      optional: false,
      type: :boolean
    },
    %{
      description: "Number of updates awaiting delivery",
      name: :pending_update_count,
      optional: false,
      type: :integer
    },
    %{
      description: "Optional. Currently used webhook IP address",
      name: :ip_address,
      optional: true,
      type: :string
    },
    %{
      description:
        "Optional. Unix time for the most recent error that happened when trying to deliver an update via webhook",
      name: :last_error_date,
      optional: true,
      type: :integer
    },
    %{
      description:
        "Optional. Error message in human-readable format for the most recent error that happened when trying to deliver an update via webhook",
      name: :last_error_message,
      optional: true,
      type: :string
    },
    %{
      description:
        "Optional. Unix time of the most recent error that happened when trying to synchronize available updates with Telegram datacenters",
      name: :last_synchronization_error_date,
      optional: true,
      type: :integer
    },
    %{
      description:
        "Optional. The maximum allowed number of simultaneous HTTPS connections to the webhook for update delivery",
      name: :max_connections,
      optional: true,
      type: :integer
    },
    %{
      description:
        "Optional. A list of update types the bot is subscribed to. Defaults to all update types except chat_member",
      name: :allowed_updates,
      optional: true,
      type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: :string}
    }
  ])

  deftype(User, "This object represents a Telegram user or bot.", [
    %{
      description:
        "Unique identifier for this user or bot. This number may have more than 32 significant bits and some programming languages may have difficulty/silent defects in interpreting it. But it has at most 52 significant bits, so a 64-bit integer or double-precision float type are safe for storing this identifier.",
      name: :id,
      optional: false,
      type: :integer
    },
    %{description: "True, if this user is a bot", name: :is_bot, optional: false, type: :boolean},
    %{
      description: "User's or bot's first name",
      name: :first_name,
      optional: false,
      type: :string
    },
    %{
      description: "Optional. User's or bot's last name",
      name: :last_name,
      optional: true,
      type: :string
    },
    %{
      description: "Optional. User's or bot's username",
      name: :username,
      optional: true,
      type: :string
    },
    %{
      description: "Optional. IETF language tag of the user's language",
      name: :language_code,
      optional: true,
      type: :string
    },
    %{
      description: "Optional. True, if this user is a Telegram Premium user",
      name: :is_premium,
      optional: true,
      type: :boolean
    },
    %{
      description: "Optional. True, if this user added the bot to the attachment menu",
      name: :added_to_attachment_menu,
      optional: true,
      type: :boolean
    },
    %{
      description: "Optional. True, if the bot can be invited to groups. Returned only in getMe.",
      name: :can_join_groups,
      optional: true,
      type: :boolean
    },
    %{
      description:
        "Optional. True, if privacy mode is disabled for the bot. Returned only in getMe.",
      name: :can_read_all_group_messages,
      optional: true,
      type: :boolean
    },
    %{
      description: "Optional. True, if the bot supports inline queries. Returned only in getMe.",
      name: :supports_inline_queries,
      optional: true,
      type: :boolean
    },
    %{
      description:
        "Optional. True, if the bot can be connected to a Telegram Business account to receive its messages. Returned only in getMe.",
      name: :can_connect_to_business,
      optional: true,
      type: :boolean
    },
    %{
      description: "Optional. True, if the bot has a main Web App. Returned only in getMe.",
      name: :has_main_web_app,
      optional: true,
      type: :boolean
    }
  ])

  deftype(Chat, "This object represents a chat.", [
    %{
      description:
        "Unique identifier for this chat. This number may have more than 32 significant bits and some programming languages may have difficulty/silent defects in interpreting it. But it has at most 52 significant bits, so a signed 64-bit integer or double-precision float type are safe for storing this identifier.",
      name: :id,
      optional: false,
      type: :integer
    },
    %{
      description:
        "Type of the chat, can be either “private”, “group”, “supergroup” or “channel”",
      name: :type,
      optional: false,
      type: :string
    },
    %{
      description: "Optional. Title, for supergroups, channels and group chats",
      name: :title,
      optional: true,
      type: :string
    },
    %{
      description: "Optional. Username, for private chats, supergroups and channels if available",
      name: :username,
      optional: true,
      type: :string
    },
    %{
      description: "Optional. First name of the other party in a private chat",
      name: :first_name,
      optional: true,
      type: :string
    },
    %{
      description: "Optional. Last name of the other party in a private chat",
      name: :last_name,
      optional: true,
      type: :string
    },
    %{
      description: "Optional. True, if the supergroup chat is a forum (has topics enabled)",
      name: :is_forum,
      optional: true,
      type: :boolean
    }
  ])

  deftype(ChatFullInfo, "This object contains full information about a chat.", [
    %{
      description:
        "Unique identifier for this chat. This number may have more than 32 significant bits and some programming languages may have difficulty/silent defects in interpreting it. But it has at most 52 significant bits, so a signed 64-bit integer or double-precision float type are safe for storing this identifier.",
      name: :id,
      optional: false,
      type: :integer
    },
    %{
      description:
        "Type of the chat, can be either “private”, “group”, “supergroup” or “channel”",
      name: :type,
      optional: false,
      type: :string
    },
    %{
      description: "Optional. Title, for supergroups, channels and group chats",
      name: :title,
      optional: true,
      type: :string
    },
    %{
      description: "Optional. Username, for private chats, supergroups and channels if available",
      name: :username,
      optional: true,
      type: :string
    },
    %{
      description: "Optional. First name of the other party in a private chat",
      name: :first_name,
      optional: true,
      type: :string
    },
    %{
      description: "Optional. Last name of the other party in a private chat",
      name: :last_name,
      optional: true,
      type: :string
    },
    %{
      description: "Optional. True, if the supergroup chat is a forum (has topics enabled)",
      name: :is_forum,
      optional: true,
      type: :boolean
    },
    %{
      description:
        "Identifier of the accent color for the chat name and backgrounds of the chat photo, reply header, and link preview. See accent colors for more details.",
      name: :accent_color_id,
      optional: false,
      type: :integer
    },
    %{
      description: "The maximum number of reactions that can be set on a message in the chat",
      name: :max_reaction_count,
      optional: false,
      type: :integer
    },
    %{
      description: "Optional. Chat photo",
      name: :photo,
      optional: true,
      type: Telegex.Type.ChatPhoto
    },
    %{
      description:
        "Optional. If non-empty, the list of all active chat usernames; for private chats, supergroups and channels",
      name: :active_usernames,
      optional: true,
      type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: :string}
    },
    %{
      description: "Optional. For private chats, the date of birth of the user",
      name: :birthdate,
      optional: true,
      type: Telegex.Type.Birthdate
    },
    %{
      description:
        "Optional. For private chats with business accounts, the intro of the business",
      name: :business_intro,
      optional: true,
      type: Telegex.Type.BusinessIntro
    },
    %{
      description:
        "Optional. For private chats with business accounts, the location of the business",
      name: :business_location,
      optional: true,
      type: Telegex.Type.BusinessLocation
    },
    %{
      description:
        "Optional. For private chats with business accounts, the opening hours of the business",
      name: :business_opening_hours,
      optional: true,
      type: Telegex.Type.BusinessOpeningHours
    },
    %{
      description: "Optional. For private chats, the personal channel of the user",
      name: :personal_chat,
      optional: true,
      type: Telegex.Type.Chat
    },
    %{
      description:
        "Optional. List of available reactions allowed in the chat. If omitted, then all emoji reactions are allowed.",
      name: :available_reactions,
      optional: true,
      type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.ReactionType}
    },
    %{
      description:
        "Optional. Custom emoji identifier of the emoji chosen by the chat for the reply header and link preview background",
      name: :background_custom_emoji_id,
      optional: true,
      type: :string
    },
    %{
      description:
        "Optional. Identifier of the accent color for the chat's profile background. See profile accent colors for more details.",
      name: :profile_accent_color_id,
      optional: true,
      type: :integer
    },
    %{
      description:
        "Optional. Custom emoji identifier of the emoji chosen by the chat for its profile background",
      name: :profile_background_custom_emoji_id,
      optional: true,
      type: :string
    },
    %{
      description:
        "Optional. Custom emoji identifier of the emoji status of the chat or the other party in a private chat",
      name: :emoji_status_custom_emoji_id,
      optional: true,
      type: :string
    },
    %{
      description:
        "Optional. Expiration date of the emoji status of the chat or the other party in a private chat, in Unix time, if any",
      name: :emoji_status_expiration_date,
      optional: true,
      type: :integer
    },
    %{
      description: "Optional. Bio of the other party in a private chat",
      name: :bio,
      optional: true,
      type: :string
    },
    %{
      description:
        "Optional. True, if privacy settings of the other party in the private chat allows to use tg://user?id=<user_id> links only in chats with the user",
      name: :has_private_forwards,
      optional: true,
      type: :boolean
    },
    %{
      description:
        "Optional. True, if the privacy settings of the other party restrict sending voice and video note messages in the private chat",
      name: :has_restricted_voice_and_video_messages,
      optional: true,
      type: :boolean
    },
    %{
      description:
        "Optional. True, if users need to join the supergroup before they can send messages",
      name: :join_to_send_messages,
      optional: true,
      type: :boolean
    },
    %{
      description:
        "Optional. True, if all users directly joining the supergroup without using an invite link need to be approved by supergroup administrators",
      name: :join_by_request,
      optional: true,
      type: :boolean
    },
    %{
      description: "Optional. Description, for groups, supergroups and channel chats",
      name: :description,
      optional: true,
      type: :string
    },
    %{
      description: "Optional. Primary invite link, for groups, supergroups and channel chats",
      name: :invite_link,
      optional: true,
      type: :string
    },
    %{
      description: "Optional. The most recent pinned message (by sending date)",
      name: :pinned_message,
      optional: true,
      type: Telegex.Type.Message
    },
    %{
      description: "Optional. Default chat member permissions, for groups and supergroups",
      name: :permissions,
      optional: true,
      type: Telegex.Type.ChatPermissions
    },
    %{
      description:
        "Optional. True, if paid media messages can be sent or forwarded to the channel chat. The field is available only for channel chats.",
      name: :can_send_paid_media,
      optional: true,
      type: :boolean
    },
    %{
      description:
        "Optional. For supergroups, the minimum allowed delay between consecutive messages sent by each unprivileged user; in seconds",
      name: :slow_mode_delay,
      optional: true,
      type: :integer
    },
    %{
      description:
        "Optional. For supergroups, the minimum number of boosts that a non-administrator user needs to add in order to ignore slow mode and chat permissions",
      name: :unrestrict_boost_count,
      optional: true,
      type: :integer
    },
    %{
      description:
        "Optional. The time after which all messages sent to the chat will be automatically deleted; in seconds",
      name: :message_auto_delete_time,
      optional: true,
      type: :integer
    },
    %{
      description:
        "Optional. True, if aggressive anti-spam checks are enabled in the supergroup. The field is only available to chat administrators.",
      name: :has_aggressive_anti_spam_enabled,
      optional: true,
      type: :boolean
    },
    %{
      description:
        "Optional. True, if non-administrators can only get the list of bots and administrators in the chat",
      name: :has_hidden_members,
      optional: true,
      type: :boolean
    },
    %{
      description: "Optional. True, if messages from the chat can't be forwarded to other chats",
      name: :has_protected_content,
      optional: true,
      type: :boolean
    },
    %{
      description:
        "Optional. True, if new chat members will have access to old messages; available only to chat administrators",
      name: :has_visible_history,
      optional: true,
      type: :boolean
    },
    %{
      description: "Optional. For supergroups, name of the group sticker set",
      name: :sticker_set_name,
      optional: true,
      type: :string
    },
    %{
      description: "Optional. True, if the bot can change the group sticker set",
      name: :can_set_sticker_set,
      optional: true,
      type: :boolean
    },
    %{
      description:
        "Optional. For supergroups, the name of the group's custom emoji sticker set. Custom emoji from this set can be used by all users and bots in the group.",
      name: :custom_emoji_sticker_set_name,
      optional: true,
      type: :string
    },
    %{
      description:
        "Optional. Unique identifier for the linked chat, i.e. the discussion group identifier for a channel and vice versa; for supergroups and channel chats. This identifier may be greater than 32 bits and some programming languages may have difficulty/silent defects in interpreting it. But it is smaller than 52 bits, so a signed 64 bit integer or double-precision float type are safe for storing this identifier.",
      name: :linked_chat_id,
      optional: true,
      type: :integer
    },
    %{
      description: "Optional. For supergroups, the location to which the supergroup is connected",
      name: :location,
      optional: true,
      type: Telegex.Type.ChatLocation
    }
  ])

  deftype(Message, "This object represents a message.", [
    %{
      description:
        "Unique message identifier inside this chat. In specific instances (e.g., message containing a video sent to a big chat), the server might automatically schedule a message instead of sending it immediately. In such cases, this field will be 0 and the relevant message will be unusable until it is actually sent",
      name: :message_id,
      optional: false,
      type: :integer
    },
    %{
      description:
        "Optional. Unique identifier of a message thread to which the message belongs; for supergroups only",
      name: :message_thread_id,
      optional: true,
      type: :integer
    },
    %{
      description:
        "Optional. Sender of the message; may be empty for messages sent to channels. For backward compatibility, if the message was sent on behalf of a chat, the field contains a fake sender user in non-channel chats",
      name: :from,
      optional: true,
      type: Telegex.Type.User
    },
    %{
      description:
        "Optional. Sender of the message when sent on behalf of a chat. For example, the supergroup itself for messages sent by its anonymous administrators or a linked channel for messages automatically forwarded to the channel's discussion group. For backward compatibility, if the message was sent on behalf of a chat, the field from contains a fake sender user in non-channel chats.",
      name: :sender_chat,
      optional: true,
      type: Telegex.Type.Chat
    },
    %{
      description:
        "Optional. If the sender of the message boosted the chat, the number of boosts added by the user",
      name: :sender_boost_count,
      optional: true,
      type: :integer
    },
    %{
      description:
        "Optional. The bot that actually sent the message on behalf of the business account. Available only for outgoing messages sent on behalf of the connected business account.",
      name: :sender_business_bot,
      optional: true,
      type: Telegex.Type.User
    },
    %{
      description:
        "Date the message was sent in Unix time. It is always a positive number, representing a valid date.",
      name: :date,
      optional: false,
      type: :integer
    },
    %{
      description:
        "Optional. Unique identifier of the business connection from which the message was received. If non-empty, the message belongs to a chat of the corresponding business account that is independent from any potential bot chat which might share the same identifier.",
      name: :business_connection_id,
      optional: true,
      type: :string
    },
    %{
      description: "Chat the message belongs to",
      name: :chat,
      optional: false,
      type: Telegex.Type.Chat
    },
    %{
      description: "Optional. Information about the original message for forwarded messages",
      name: :forward_origin,
      optional: true,
      type: Telegex.Type.MessageOrigin
    },
    %{
      description: "Optional. True, if the message is sent to a forum topic",
      name: :is_topic_message,
      optional: true,
      type: :boolean
    },
    %{
      description:
        "Optional. True, if the message is a channel post that was automatically forwarded to the connected discussion group",
      name: :is_automatic_forward,
      optional: true,
      type: :boolean
    },
    %{
      description:
        "Optional. For replies in the same chat and message thread, the original message. Note that the Message object in this field will not contain further reply_to_message fields even if it itself is a reply.",
      name: :reply_to_message,
      optional: true,
      type: Telegex.Type.Message
    },
    %{
      description:
        "Optional. Information about the message that is being replied to, which may come from another chat or forum topic",
      name: :external_reply,
      optional: true,
      type: Telegex.Type.ExternalReplyInfo
    },
    %{
      description:
        "Optional. For replies that quote part of the original message, the quoted part of the message",
      name: :quote,
      optional: true,
      type: Telegex.Type.TextQuote
    },
    %{
      description: "Optional. For replies to a story, the original story",
      name: :reply_to_story,
      optional: true,
      type: Telegex.Type.Story
    },
    %{
      description: "Optional. Bot through which the message was sent",
      name: :via_bot,
      optional: true,
      type: Telegex.Type.User
    },
    %{
      description: "Optional. Date the message was last edited in Unix time",
      name: :edit_date,
      optional: true,
      type: :integer
    },
    %{
      description: "Optional. True, if the message can't be forwarded",
      name: :has_protected_content,
      optional: true,
      type: :boolean
    },
    %{
      description:
        "Optional. True, if the message was sent by an implicit action, for example, as an away or a greeting business message, or as a scheduled message",
      name: :is_from_offline,
      optional: true,
      type: :boolean
    },
    %{
      description:
        "Optional. The unique identifier of a media message group this message belongs to",
      name: :media_group_id,
      optional: true,
      type: :string
    },
    %{
      description:
        "Optional. Signature of the post author for messages in channels, or the custom title of an anonymous group administrator",
      name: :author_signature,
      optional: true,
      type: :string
    },
    %{
      description: "Optional. For text messages, the actual UTF-8 text of the message",
      name: :text,
      optional: true,
      type: :string
    },
    %{
      description:
        "Optional. For text messages, special entities like usernames, URLs, bot commands, etc. that appear in the text",
      name: :entities,
      optional: true,
      type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity}
    },
    %{
      description:
        "Optional. Options used for link preview generation for the message, if it is a text message and link preview options were changed",
      name: :link_preview_options,
      optional: true,
      type: Telegex.Type.LinkPreviewOptions
    },
    %{
      description: "Optional. Unique identifier of the message effect added to the message",
      name: :effect_id,
      optional: true,
      type: :string
    },
    %{
      description:
        "Optional. Message is an animation, information about the animation. For backward compatibility, when this field is set, the document field will also be set",
      name: :animation,
      optional: true,
      type: Telegex.Type.Animation
    },
    %{
      description: "Optional. Message is an audio file, information about the file",
      name: :audio,
      optional: true,
      type: Telegex.Type.Audio
    },
    %{
      description: "Optional. Message is a general file, information about the file",
      name: :document,
      optional: true,
      type: Telegex.Type.Document
    },
    %{
      description: "Optional. Message contains paid media; information about the paid media",
      name: :paid_media,
      optional: true,
      type: Telegex.Type.PaidMediaInfo
    },
    %{
      description: "Optional. Message is a photo, available sizes of the photo",
      name: :photo,
      optional: true,
      type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.PhotoSize}
    },
    %{
      description: "Optional. Message is a sticker, information about the sticker",
      name: :sticker,
      optional: true,
      type: Telegex.Type.Sticker
    },
    %{
      description: "Optional. Message is a forwarded story",
      name: :story,
      optional: true,
      type: Telegex.Type.Story
    },
    %{
      description: "Optional. Message is a video, information about the video",
      name: :video,
      optional: true,
      type: Telegex.Type.Video
    },
    %{
      description: "Optional. Message is a video note, information about the video message",
      name: :video_note,
      optional: true,
      type: Telegex.Type.VideoNote
    },
    %{
      description: "Optional. Message is a voice message, information about the file",
      name: :voice,
      optional: true,
      type: Telegex.Type.Voice
    },
    %{
      description:
        "Optional. Caption for the animation, audio, document, paid media, photo, video or voice",
      name: :caption,
      optional: true,
      type: :string
    },
    %{
      description:
        "Optional. For messages with a caption, special entities like usernames, URLs, bot commands, etc. that appear in the caption",
      name: :caption_entities,
      optional: true,
      type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity}
    },
    %{
      description: "Optional. True, if the caption must be shown above the message media",
      name: :show_caption_above_media,
      optional: true,
      type: :boolean
    },
    %{
      description: "Optional. True, if the message media is covered by a spoiler animation",
      name: :has_media_spoiler,
      optional: true,
      type: :boolean
    },
    %{
      description: "Optional. Message is a shared contact, information about the contact",
      name: :contact,
      optional: true,
      type: Telegex.Type.Contact
    },
    %{
      description: "Optional. Message is a dice with random value",
      name: :dice,
      optional: true,
      type: Telegex.Type.Dice
    },
    %{
      description: "Optional. Message is a game, information about the game. More about games »",
      name: :game,
      optional: true,
      type: Telegex.Type.Game
    },
    %{
      description: "Optional. Message is a native poll, information about the poll",
      name: :poll,
      optional: true,
      type: Telegex.Type.Poll
    },
    %{
      description:
        "Optional. Message is a venue, information about the venue. For backward compatibility, when this field is set, the location field will also be set",
      name: :venue,
      optional: true,
      type: Telegex.Type.Venue
    },
    %{
      description: "Optional. Message is a shared location, information about the location",
      name: :location,
      optional: true,
      type: Telegex.Type.Location
    },
    %{
      description:
        "Optional. New members that were added to the group or supergroup and information about them (the bot itself may be one of these members)",
      name: :new_chat_members,
      optional: true,
      type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.User}
    },
    %{
      description:
        "Optional. A member was removed from the group, information about them (this member may be the bot itself)",
      name: :left_chat_member,
      optional: true,
      type: Telegex.Type.User
    },
    %{
      description: "Optional. A chat title was changed to this value",
      name: :new_chat_title,
      optional: true,
      type: :string
    },
    %{
      description: "Optional. A chat photo was change to this value",
      name: :new_chat_photo,
      optional: true,
      type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.PhotoSize}
    },
    %{
      description: "Optional. Service message: the chat photo was deleted",
      name: :delete_chat_photo,
      optional: true,
      type: :boolean
    },
    %{
      description: "Optional. Service message: the group has been created",
      name: :group_chat_created,
      optional: true,
      type: :boolean
    },
    %{
      description:
        "Optional. Service message: the supergroup has been created. This field can't be received in a message coming through updates, because bot can't be a member of a supergroup when it is created. It can only be found in reply_to_message if someone replies to a very first message in a directly created supergroup.",
      name: :supergroup_chat_created,
      optional: true,
      type: :boolean
    },
    %{
      description:
        "Optional. Service message: the channel has been created. This field can't be received in a message coming through updates, because bot can't be a member of a channel when it is created. It can only be found in reply_to_message if someone replies to a very first message in a channel.",
      name: :channel_chat_created,
      optional: true,
      type: :boolean
    },
    %{
      description: "Optional. Service message: auto-delete timer settings changed in the chat",
      name: :message_auto_delete_timer_changed,
      optional: true,
      type: Telegex.Type.MessageAutoDeleteTimerChanged
    },
    %{
      description:
        "Optional. The group has been migrated to a supergroup with the specified identifier. This number may have more than 32 significant bits and some programming languages may have difficulty/silent defects in interpreting it. But it has at most 52 significant bits, so a signed 64-bit integer or double-precision float type are safe for storing this identifier.",
      name: :migrate_to_chat_id,
      optional: true,
      type: :integer
    },
    %{
      description:
        "Optional. The supergroup has been migrated from a group with the specified identifier. This number may have more than 32 significant bits and some programming languages may have difficulty/silent defects in interpreting it. But it has at most 52 significant bits, so a signed 64-bit integer or double-precision float type are safe for storing this identifier.",
      name: :migrate_from_chat_id,
      optional: true,
      type: :integer
    },
    %{
      description:
        "Optional. Specified message was pinned. Note that the Message object in this field will not contain further reply_to_message fields even if it itself is a reply.",
      name: :pinned_message,
      optional: true,
      type: Telegex.Type.MaybeInaccessibleMessage
    },
    %{
      description:
        "Optional. Message is an invoice for a payment, information about the invoice. More about payments »",
      name: :invoice,
      optional: true,
      type: Telegex.Type.Invoice
    },
    %{
      description:
        "Optional. Message is a service message about a successful payment, information about the payment. More about payments »",
      name: :successful_payment,
      optional: true,
      type: Telegex.Type.SuccessfulPayment
    },
    %{
      description:
        "Optional. Message is a service message about a refunded payment, information about the payment. More about payments »",
      name: :refunded_payment,
      optional: true,
      type: Telegex.Type.RefundedPayment
    },
    %{
      description: "Optional. Service message: users were shared with the bot",
      name: :users_shared,
      optional: true,
      type: Telegex.Type.UsersShared
    },
    %{
      description: "Optional. Service message: a chat was shared with the bot",
      name: :chat_shared,
      optional: true,
      type: Telegex.Type.ChatShared
    },
    %{
      description:
        "Optional. The domain name of the website on which the user has logged in. More about Telegram Login »",
      name: :connected_website,
      optional: true,
      type: :string
    },
    %{
      description:
        "Optional. Service message: the user allowed the bot to write messages after adding it to the attachment or side menu, launching a Web App from a link, or accepting an explicit request from a Web App sent by the method requestWriteAccess",
      name: :write_access_allowed,
      optional: true,
      type: Telegex.Type.WriteAccessAllowed
    },
    %{
      description: "Optional. Telegram Passport data",
      name: :passport_data,
      optional: true,
      type: Telegex.Type.PassportData
    },
    %{
      description:
        "Optional. Service message. A user in the chat triggered another user's proximity alert while sharing Live Location.",
      name: :proximity_alert_triggered,
      optional: true,
      type: Telegex.Type.ProximityAlertTriggered
    },
    %{
      description: "Optional. Service message: user boosted the chat",
      name: :boost_added,
      optional: true,
      type: Telegex.Type.ChatBoostAdded
    },
    %{
      description: "Optional. Service message: chat background set",
      name: :chat_background_set,
      optional: true,
      type: Telegex.Type.ChatBackground
    },
    %{
      description: "Optional. Service message: forum topic created",
      name: :forum_topic_created,
      optional: true,
      type: Telegex.Type.ForumTopicCreated
    },
    %{
      description: "Optional. Service message: forum topic edited",
      name: :forum_topic_edited,
      optional: true,
      type: Telegex.Type.ForumTopicEdited
    },
    %{
      description: "Optional. Service message: forum topic closed",
      name: :forum_topic_closed,
      optional: true,
      type: Telegex.Type.ForumTopicClosed
    },
    %{
      description: "Optional. Service message: forum topic reopened",
      name: :forum_topic_reopened,
      optional: true,
      type: Telegex.Type.ForumTopicReopened
    },
    %{
      description: "Optional. Service message: the 'General' forum topic hidden",
      name: :general_forum_topic_hidden,
      optional: true,
      type: Telegex.Type.GeneralForumTopicHidden
    },
    %{
      description: "Optional. Service message: the 'General' forum topic unhidden",
      name: :general_forum_topic_unhidden,
      optional: true,
      type: Telegex.Type.GeneralForumTopicUnhidden
    },
    %{
      description: "Optional. Service message: a scheduled giveaway was created",
      name: :giveaway_created,
      optional: true,
      type: Telegex.Type.GiveawayCreated
    },
    %{
      description: "Optional. The message is a scheduled giveaway message",
      name: :giveaway,
      optional: true,
      type: Telegex.Type.Giveaway
    },
    %{
      description: "Optional. A giveaway with public winners was completed",
      name: :giveaway_winners,
      optional: true,
      type: Telegex.Type.GiveawayWinners
    },
    %{
      description: "Optional. Service message: a giveaway without public winners was completed",
      name: :giveaway_completed,
      optional: true,
      type: Telegex.Type.GiveawayCompleted
    },
    %{
      description: "Optional. Service message: video chat scheduled",
      name: :video_chat_scheduled,
      optional: true,
      type: Telegex.Type.VideoChatScheduled
    },
    %{
      description: "Optional. Service message: video chat started",
      name: :video_chat_started,
      optional: true,
      type: Telegex.Type.VideoChatStarted
    },
    %{
      description: "Optional. Service message: video chat ended",
      name: :video_chat_ended,
      optional: true,
      type: Telegex.Type.VideoChatEnded
    },
    %{
      description: "Optional. Service message: new participants invited to a video chat",
      name: :video_chat_participants_invited,
      optional: true,
      type: Telegex.Type.VideoChatParticipantsInvited
    },
    %{
      description: "Optional. Service message: data sent by a Web App",
      name: :web_app_data,
      optional: true,
      type: Telegex.Type.WebAppData
    },
    %{
      description:
        "Optional. Inline keyboard attached to the message. login_url buttons are represented as ordinary url buttons.",
      name: :reply_markup,
      optional: true,
      type: Telegex.Type.InlineKeyboardMarkup
    }
  ])

  deftype(MessageId, "This object represents a unique message identifier.", [
    %{
      description:
        "Unique message identifier. In specific instances (e.g., message containing a video sent to a big chat), the server might automatically schedule a message instead of sending it immediately. In such cases, this field will be 0 and the relevant message will be unusable until it is actually sent",
      name: :message_id,
      optional: false,
      type: :integer
    }
  ])

  deftype(
    InaccessibleMessage,
    "This object describes a message that was deleted or is otherwise inaccessible to the bot.",
    [
      %{
        description: "Chat the message belonged to",
        name: :chat,
        optional: false,
        type: Telegex.Type.Chat
      },
      %{
        description: "Unique message identifier inside the chat",
        name: :message_id,
        optional: false,
        type: :integer
      },
      %{
        description:
          "Always 0. The field can be used to differentiate regular and inaccessible messages.",
        name: :date,
        optional: false,
        type: :integer
      }
    ]
  )

  deftype(
    MessageEntity,
    "This object represents one special entity in a text message. For example, hashtags, usernames, URLs, etc.",
    [
      %{
        description:
          "Type of the entity. Currently, can be “mention” (@username), “hashtag” (#hashtag or #hashtag@chatusername), “cashtag” ($USD or $USD@chatusername), “bot_command” (/start@jobs_bot), “url” (https://telegram.org), “email” (do-not-reply@telegram.org), “phone_number” (+1-212-555-0123), “bold” (bold text), “italic” (italic text), “underline” (underlined text), “strikethrough” (strikethrough text), “spoiler” (spoiler message), “blockquote” (block quotation), “expandable_blockquote” (collapsed-by-default block quotation), “code” (monowidth string), “pre” (monowidth block), “text_link” (for clickable text URLs), “text_mention” (for users without usernames), “custom_emoji” (for inline custom emoji stickers)",
        name: :type,
        optional: false,
        type: :string
      },
      %{
        description: "Offset in UTF-16 code units to the start of the entity",
        name: :offset,
        optional: false,
        type: :integer
      },
      %{
        description: "Length of the entity in UTF-16 code units",
        name: :length,
        optional: false,
        type: :integer
      },
      %{
        description:
          "Optional. For “text_link” only, URL that will be opened after user taps on the text",
        name: :url,
        optional: true,
        type: :string
      },
      %{
        description: "Optional. For “text_mention” only, the mentioned user",
        name: :user,
        optional: true,
        type: Telegex.Type.User
      },
      %{
        description: "Optional. For “pre” only, the programming language of the entity text",
        name: :language,
        optional: true,
        type: :string
      },
      %{
        description:
          "Optional. For “custom_emoji” only, unique identifier of the custom emoji. Use getCustomEmojiStickers to get full information about the sticker",
        name: :custom_emoji_id,
        optional: true,
        type: :string
      }
    ]
  )

  deftype(
    TextQuote,
    "This object contains information about the quoted part of a message that is replied to by the given message.",
    [
      %{
        description:
          "Text of the quoted part of a message that is replied to by the given message",
        name: :text,
        optional: false,
        type: :string
      },
      %{
        description:
          "Optional. Special entities that appear in the quote. Currently, only bold, italic, underline, strikethrough, spoiler, and custom_emoji entities are kept in quotes.",
        name: :entities,
        optional: true,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity}
      },
      %{
        description:
          "Approximate quote position in the original message in UTF-16 code units as specified by the sender",
        name: :position,
        optional: false,
        type: :integer
      },
      %{
        description:
          "Optional. True, if the quote was chosen manually by the message sender. Otherwise, the quote was added automatically by the server.",
        name: :is_manual,
        optional: true,
        type: :boolean
      }
    ]
  )

  deftype(
    ExternalReplyInfo,
    "This object contains information about a message that is being replied to, which may come from another chat or forum topic.",
    [
      %{
        description: "Origin of the message replied to by the given message",
        name: :origin,
        optional: false,
        type: Telegex.Type.MessageOrigin
      },
      %{
        description:
          "Optional. Chat the original message belongs to. Available only if the chat is a supergroup or a channel.",
        name: :chat,
        optional: true,
        type: Telegex.Type.Chat
      },
      %{
        description:
          "Optional. Unique message identifier inside the original chat. Available only if the original chat is a supergroup or a channel.",
        name: :message_id,
        optional: true,
        type: :integer
      },
      %{
        description:
          "Optional. Options used for link preview generation for the original message, if it is a text message",
        name: :link_preview_options,
        optional: true,
        type: Telegex.Type.LinkPreviewOptions
      },
      %{
        description: "Optional. Message is an animation, information about the animation",
        name: :animation,
        optional: true,
        type: Telegex.Type.Animation
      },
      %{
        description: "Optional. Message is an audio file, information about the file",
        name: :audio,
        optional: true,
        type: Telegex.Type.Audio
      },
      %{
        description: "Optional. Message is a general file, information about the file",
        name: :document,
        optional: true,
        type: Telegex.Type.Document
      },
      %{
        description: "Optional. Message contains paid media; information about the paid media",
        name: :paid_media,
        optional: true,
        type: Telegex.Type.PaidMediaInfo
      },
      %{
        description: "Optional. Message is a photo, available sizes of the photo",
        name: :photo,
        optional: true,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.PhotoSize}
      },
      %{
        description: "Optional. Message is a sticker, information about the sticker",
        name: :sticker,
        optional: true,
        type: Telegex.Type.Sticker
      },
      %{
        description: "Optional. Message is a forwarded story",
        name: :story,
        optional: true,
        type: Telegex.Type.Story
      },
      %{
        description: "Optional. Message is a video, information about the video",
        name: :video,
        optional: true,
        type: Telegex.Type.Video
      },
      %{
        description: "Optional. Message is a video note, information about the video message",
        name: :video_note,
        optional: true,
        type: Telegex.Type.VideoNote
      },
      %{
        description: "Optional. Message is a voice message, information about the file",
        name: :voice,
        optional: true,
        type: Telegex.Type.Voice
      },
      %{
        description: "Optional. True, if the message media is covered by a spoiler animation",
        name: :has_media_spoiler,
        optional: true,
        type: :boolean
      },
      %{
        description: "Optional. Message is a shared contact, information about the contact",
        name: :contact,
        optional: true,
        type: Telegex.Type.Contact
      },
      %{
        description: "Optional. Message is a dice with random value",
        name: :dice,
        optional: true,
        type: Telegex.Type.Dice
      },
      %{
        description:
          "Optional. Message is a game, information about the game. More about games »",
        name: :game,
        optional: true,
        type: Telegex.Type.Game
      },
      %{
        description: "Optional. Message is a scheduled giveaway, information about the giveaway",
        name: :giveaway,
        optional: true,
        type: Telegex.Type.Giveaway
      },
      %{
        description: "Optional. A giveaway with public winners was completed",
        name: :giveaway_winners,
        optional: true,
        type: Telegex.Type.GiveawayWinners
      },
      %{
        description:
          "Optional. Message is an invoice for a payment, information about the invoice. More about payments »",
        name: :invoice,
        optional: true,
        type: Telegex.Type.Invoice
      },
      %{
        description: "Optional. Message is a shared location, information about the location",
        name: :location,
        optional: true,
        type: Telegex.Type.Location
      },
      %{
        description: "Optional. Message is a native poll, information about the poll",
        name: :poll,
        optional: true,
        type: Telegex.Type.Poll
      },
      %{
        description: "Optional. Message is a venue, information about the venue",
        name: :venue,
        optional: true,
        type: Telegex.Type.Venue
      }
    ]
  )

  deftype(ReplyParameters, "Describes reply parameters for the message that is being sent.", [
    %{
      description:
        "Identifier of the message that will be replied to in the current chat, or in the chat chat_id if it is specified",
      name: :message_id,
      optional: false,
      type: :integer
    },
    %{
      description:
        "Optional. If the message to be replied to is from a different chat, unique identifier for the chat or username of the channel (in the format @channelusername). Not supported for messages sent on behalf of a business account.",
      name: :chat_id,
      optional: true,
      type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
    },
    %{
      description:
        "Optional. Pass True if the message should be sent even if the specified message to be replied to is not found. Always False for replies in another chat or forum topic. Always True for messages sent on behalf of a business account.",
      name: :allow_sending_without_reply,
      optional: true,
      type: :boolean
    },
    %{
      description:
        "Optional. Quoted part of the message to be replied to; 0-1024 characters after entities parsing. The quote must be an exact substring of the message to be replied to, including bold, italic, underline, strikethrough, spoiler, and custom_emoji entities. The message will fail to send if the quote isn't found in the original message.",
      name: :quote,
      optional: true,
      type: :string
    },
    %{
      description:
        "Optional. Mode for parsing entities in the quote. See formatting options for more details.",
      name: :quote_parse_mode,
      optional: true,
      type: :string
    },
    %{
      description:
        "Optional. A JSON-serialized list of special entities that appear in the quote. It can be specified instead of quote_parse_mode.",
      name: :quote_entities,
      optional: true,
      type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity}
    },
    %{
      description: "Optional. Position of the quote in the original message in UTF-16 code units",
      name: :quote_position,
      optional: true,
      type: :integer
    }
  ])

  deftype(MessageOriginUser, "The message was originally sent by a known user.", [
    %{
      description: "Type of the message origin, always “user”",
      name: :type,
      optional: false,
      type: :string
    },
    %{
      description: "Date the message was sent originally in Unix time",
      name: :date,
      optional: false,
      type: :integer
    },
    %{
      description: "User that sent the message originally",
      name: :sender_user,
      optional: false,
      type: Telegex.Type.User
    }
  ])

  deftype(MessageOriginHiddenUser, "The message was originally sent by an unknown user.", [
    %{
      description: "Type of the message origin, always “hidden_user”",
      name: :type,
      optional: false,
      type: :string
    },
    %{
      description: "Date the message was sent originally in Unix time",
      name: :date,
      optional: false,
      type: :integer
    },
    %{
      description: "Name of the user that sent the message originally",
      name: :sender_user_name,
      optional: false,
      type: :string
    }
  ])

  deftype(
    MessageOriginChat,
    "The message was originally sent on behalf of a chat to a group chat.",
    [
      %{
        description: "Type of the message origin, always “chat”",
        name: :type,
        optional: false,
        type: :string
      },
      %{
        description: "Date the message was sent originally in Unix time",
        name: :date,
        optional: false,
        type: :integer
      },
      %{
        description: "Chat that sent the message originally",
        name: :sender_chat,
        optional: false,
        type: Telegex.Type.Chat
      },
      %{
        description:
          "Optional. For messages originally sent by an anonymous chat administrator, original message author signature",
        name: :author_signature,
        optional: true,
        type: :string
      }
    ]
  )

  deftype(MessageOriginChannel, "The message was originally sent to a channel chat.", [
    %{
      description: "Type of the message origin, always “channel”",
      name: :type,
      optional: false,
      type: :string
    },
    %{
      description: "Date the message was sent originally in Unix time",
      name: :date,
      optional: false,
      type: :integer
    },
    %{
      description: "Channel chat to which the message was originally sent",
      name: :chat,
      optional: false,
      type: Telegex.Type.Chat
    },
    %{
      description: "Unique message identifier inside the chat",
      name: :message_id,
      optional: false,
      type: :integer
    },
    %{
      description: "Optional. Signature of the original post author",
      name: :author_signature,
      optional: true,
      type: :string
    }
  ])

  deftype(
    PhotoSize,
    "This object represents one size of a photo or a file / sticker thumbnail.",
    [
      %{
        description: "Identifier for this file, which can be used to download or reuse the file",
        name: :file_id,
        optional: false,
        type: :string
      },
      %{
        description:
          "Unique identifier for this file, which is supposed to be the same over time and for different bots. Can't be used to download or reuse the file.",
        name: :file_unique_id,
        optional: false,
        type: :string
      },
      %{description: "Photo width", name: :width, optional: false, type: :integer},
      %{description: "Photo height", name: :height, optional: false, type: :integer},
      %{
        description: "Optional. File size in bytes",
        name: :file_size,
        optional: true,
        type: :integer
      }
    ]
  )

  deftype(
    Animation,
    "This object represents an animation file (GIF or H.264/MPEG-4 AVC video without sound).",
    [
      %{
        description: "Identifier for this file, which can be used to download or reuse the file",
        name: :file_id,
        optional: false,
        type: :string
      },
      %{
        description:
          "Unique identifier for this file, which is supposed to be the same over time and for different bots. Can't be used to download or reuse the file.",
        name: :file_unique_id,
        optional: false,
        type: :string
      },
      %{
        description: "Video width as defined by the sender",
        name: :width,
        optional: false,
        type: :integer
      },
      %{
        description: "Video height as defined by the sender",
        name: :height,
        optional: false,
        type: :integer
      },
      %{
        description: "Duration of the video in seconds as defined by the sender",
        name: :duration,
        optional: false,
        type: :integer
      },
      %{
        description: "Optional. Animation thumbnail as defined by the sender",
        name: :thumbnail,
        optional: true,
        type: Telegex.Type.PhotoSize
      },
      %{
        description: "Optional. Original animation filename as defined by the sender",
        name: :file_name,
        optional: true,
        type: :string
      },
      %{
        description: "Optional. MIME type of the file as defined by the sender",
        name: :mime_type,
        optional: true,
        type: :string
      },
      %{
        description:
          "Optional. File size in bytes. It can be bigger than 2^31 and some programming languages may have difficulty/silent defects in interpreting it. But it has at most 52 significant bits, so a signed 64-bit integer or double-precision float type are safe for storing this value.",
        name: :file_size,
        optional: true,
        type: :integer
      }
    ]
  )

  deftype(
    Audio,
    "This object represents an audio file to be treated as music by the Telegram clients.",
    [
      %{
        description: "Identifier for this file, which can be used to download or reuse the file",
        name: :file_id,
        optional: false,
        type: :string
      },
      %{
        description:
          "Unique identifier for this file, which is supposed to be the same over time and for different bots. Can't be used to download or reuse the file.",
        name: :file_unique_id,
        optional: false,
        type: :string
      },
      %{
        description: "Duration of the audio in seconds as defined by the sender",
        name: :duration,
        optional: false,
        type: :integer
      },
      %{
        description: "Optional. Performer of the audio as defined by the sender or by audio tags",
        name: :performer,
        optional: true,
        type: :string
      },
      %{
        description: "Optional. Title of the audio as defined by the sender or by audio tags",
        name: :title,
        optional: true,
        type: :string
      },
      %{
        description: "Optional. Original filename as defined by the sender",
        name: :file_name,
        optional: true,
        type: :string
      },
      %{
        description: "Optional. MIME type of the file as defined by the sender",
        name: :mime_type,
        optional: true,
        type: :string
      },
      %{
        description:
          "Optional. File size in bytes. It can be bigger than 2^31 and some programming languages may have difficulty/silent defects in interpreting it. But it has at most 52 significant bits, so a signed 64-bit integer or double-precision float type are safe for storing this value.",
        name: :file_size,
        optional: true,
        type: :integer
      },
      %{
        description: "Optional. Thumbnail of the album cover to which the music file belongs",
        name: :thumbnail,
        optional: true,
        type: Telegex.Type.PhotoSize
      }
    ]
  )

  deftype(
    Document,
    "This object represents a general file (as opposed to photos, voice messages and audio files).",
    [
      %{
        description: "Identifier for this file, which can be used to download or reuse the file",
        name: :file_id,
        optional: false,
        type: :string
      },
      %{
        description:
          "Unique identifier for this file, which is supposed to be the same over time and for different bots. Can't be used to download or reuse the file.",
        name: :file_unique_id,
        optional: false,
        type: :string
      },
      %{
        description: "Optional. Document thumbnail as defined by the sender",
        name: :thumbnail,
        optional: true,
        type: Telegex.Type.PhotoSize
      },
      %{
        description: "Optional. Original filename as defined by the sender",
        name: :file_name,
        optional: true,
        type: :string
      },
      %{
        description: "Optional. MIME type of the file as defined by the sender",
        name: :mime_type,
        optional: true,
        type: :string
      },
      %{
        description:
          "Optional. File size in bytes. It can be bigger than 2^31 and some programming languages may have difficulty/silent defects in interpreting it. But it has at most 52 significant bits, so a signed 64-bit integer or double-precision float type are safe for storing this value.",
        name: :file_size,
        optional: true,
        type: :integer
      }
    ]
  )

  deftype(Story, "This object represents a story.", [
    %{
      description: "Chat that posted the story",
      name: :chat,
      optional: false,
      type: Telegex.Type.Chat
    },
    %{
      description: "Unique identifier for the story in the chat",
      name: :id,
      optional: false,
      type: :integer
    }
  ])

  deftype(Video, "This object represents a video file.", [
    %{
      description: "Identifier for this file, which can be used to download or reuse the file",
      name: :file_id,
      optional: false,
      type: :string
    },
    %{
      description:
        "Unique identifier for this file, which is supposed to be the same over time and for different bots. Can't be used to download or reuse the file.",
      name: :file_unique_id,
      optional: false,
      type: :string
    },
    %{
      description: "Video width as defined by the sender",
      name: :width,
      optional: false,
      type: :integer
    },
    %{
      description: "Video height as defined by the sender",
      name: :height,
      optional: false,
      type: :integer
    },
    %{
      description: "Duration of the video in seconds as defined by the sender",
      name: :duration,
      optional: false,
      type: :integer
    },
    %{
      description: "Optional. Video thumbnail",
      name: :thumbnail,
      optional: true,
      type: Telegex.Type.PhotoSize
    },
    %{
      description: "Optional. Original filename as defined by the sender",
      name: :file_name,
      optional: true,
      type: :string
    },
    %{
      description: "Optional. MIME type of the file as defined by the sender",
      name: :mime_type,
      optional: true,
      type: :string
    },
    %{
      description:
        "Optional. File size in bytes. It can be bigger than 2^31 and some programming languages may have difficulty/silent defects in interpreting it. But it has at most 52 significant bits, so a signed 64-bit integer or double-precision float type are safe for storing this value.",
      name: :file_size,
      optional: true,
      type: :integer
    }
  ])

  deftype(
    VideoNote,
    "This object represents a video message (available in Telegram apps as of v.4.0).",
    [
      %{
        description: "Identifier for this file, which can be used to download or reuse the file",
        name: :file_id,
        optional: false,
        type: :string
      },
      %{
        description:
          "Unique identifier for this file, which is supposed to be the same over time and for different bots. Can't be used to download or reuse the file.",
        name: :file_unique_id,
        optional: false,
        type: :string
      },
      %{
        description:
          "Video width and height (diameter of the video message) as defined by the sender",
        name: :length,
        optional: false,
        type: :integer
      },
      %{
        description: "Duration of the video in seconds as defined by the sender",
        name: :duration,
        optional: false,
        type: :integer
      },
      %{
        description: "Optional. Video thumbnail",
        name: :thumbnail,
        optional: true,
        type: Telegex.Type.PhotoSize
      },
      %{
        description: "Optional. File size in bytes",
        name: :file_size,
        optional: true,
        type: :integer
      }
    ]
  )

  deftype(Voice, "This object represents a voice note.", [
    %{
      description: "Identifier for this file, which can be used to download or reuse the file",
      name: :file_id,
      optional: false,
      type: :string
    },
    %{
      description:
        "Unique identifier for this file, which is supposed to be the same over time and for different bots. Can't be used to download or reuse the file.",
      name: :file_unique_id,
      optional: false,
      type: :string
    },
    %{
      description: "Duration of the audio in seconds as defined by the sender",
      name: :duration,
      optional: false,
      type: :integer
    },
    %{
      description: "Optional. MIME type of the file as defined by the sender",
      name: :mime_type,
      optional: true,
      type: :string
    },
    %{
      description:
        "Optional. File size in bytes. It can be bigger than 2^31 and some programming languages may have difficulty/silent defects in interpreting it. But it has at most 52 significant bits, so a signed 64-bit integer or double-precision float type are safe for storing this value.",
      name: :file_size,
      optional: true,
      type: :integer
    }
  ])

  deftype(PaidMediaInfo, "Describes the paid media added to a message.", [
    %{
      description: "The number of Telegram Stars that must be paid to buy access to the media",
      name: :star_count,
      optional: false,
      type: :integer
    },
    %{
      description: "Information about the paid media",
      name: :paid_media,
      optional: false,
      type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.PaidMedia}
    }
  ])

  deftype(PaidMediaPreview, "The paid media isn't available before the payment.", [
    %{
      description: "Type of the paid media, always “preview”",
      name: :type,
      optional: false,
      type: :string
    },
    %{
      description: "Optional. Media width as defined by the sender",
      name: :width,
      optional: true,
      type: :integer
    },
    %{
      description: "Optional. Media height as defined by the sender",
      name: :height,
      optional: true,
      type: :integer
    },
    %{
      description: "Optional. Duration of the media in seconds as defined by the sender",
      name: :duration,
      optional: true,
      type: :integer
    }
  ])

  deftype(PaidMediaPhoto, "The paid media is a photo.", [
    %{
      description: "Type of the paid media, always “photo”",
      name: :type,
      optional: false,
      type: :string
    },
    %{
      description: "The photo",
      name: :photo,
      optional: false,
      type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.PhotoSize}
    }
  ])

  deftype(PaidMediaVideo, "The paid media is a video.", [
    %{
      description: "Type of the paid media, always “video”",
      name: :type,
      optional: false,
      type: :string
    },
    %{description: "The video", name: :video, optional: false, type: Telegex.Type.Video}
  ])

  deftype(Contact, "This object represents a phone contact.", [
    %{description: "Contact's phone number", name: :phone_number, optional: false, type: :string},
    %{description: "Contact's first name", name: :first_name, optional: false, type: :string},
    %{
      description: "Optional. Contact's last name",
      name: :last_name,
      optional: true,
      type: :string
    },
    %{
      description:
        "Optional. Contact's user identifier in Telegram. This number may have more than 32 significant bits and some programming languages may have difficulty/silent defects in interpreting it. But it has at most 52 significant bits, so a 64-bit integer or double-precision float type are safe for storing this identifier.",
      name: :user_id,
      optional: true,
      type: :integer
    },
    %{
      description: "Optional. Additional data about the contact in the form of a vCard",
      name: :vcard,
      optional: true,
      type: :string
    }
  ])

  deftype(Dice, "This object represents an animated emoji that displays a random value.", [
    %{
      description: "Emoji on which the dice throw animation is based",
      name: :emoji,
      optional: false,
      type: :string
    },
    %{
      description:
        "Value of the dice, 1-6 for “”, “” and “” base emoji, 1-5 for “” and “” base emoji, 1-64 for “” base emoji",
      name: :value,
      optional: false,
      type: :integer
    }
  ])

  deftype(PollOption, "This object contains information about one answer option in a poll.", [
    %{description: "Option text, 1-100 characters", name: :text, optional: false, type: :string},
    %{
      description:
        "Optional. Special entities that appear in the option text. Currently, only custom emoji entities are allowed in poll option texts",
      name: :text_entities,
      optional: true,
      type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity}
    },
    %{
      description: "Number of users that voted for this option",
      name: :voter_count,
      optional: false,
      type: :integer
    }
  ])

  deftype(
    InputPollOption,
    "This object contains information about one answer option in a poll to be sent.",
    [
      %{
        description: "Option text, 1-100 characters",
        name: :text,
        optional: false,
        type: :string
      },
      %{
        description:
          "Optional. Mode for parsing entities in the text. See formatting options for more details. Currently, only custom emoji entities are allowed",
        name: :text_parse_mode,
        optional: true,
        type: :string
      },
      %{
        description:
          "Optional. A JSON-serialized list of special entities that appear in the poll option text. It can be specified instead of text_parse_mode",
        name: :text_entities,
        optional: true,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity}
      }
    ]
  )

  deftype(PollAnswer, "This object represents an answer of a user in a non-anonymous poll.", [
    %{description: "Unique poll identifier", name: :poll_id, optional: false, type: :string},
    %{
      description:
        "Optional. The chat that changed the answer to the poll, if the voter is anonymous",
      name: :voter_chat,
      optional: true,
      type: Telegex.Type.Chat
    },
    %{
      description:
        "Optional. The user that changed the answer to the poll, if the voter isn't anonymous",
      name: :user,
      optional: true,
      type: Telegex.Type.User
    },
    %{
      description:
        "0-based identifiers of chosen answer options. May be empty if the vote was retracted.",
      name: :option_ids,
      optional: false,
      type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: :integer}
    }
  ])

  deftype(Poll, "This object contains information about a poll.", [
    %{description: "Unique poll identifier", name: :id, optional: false, type: :string},
    %{
      description: "Poll question, 1-300 characters",
      name: :question,
      optional: false,
      type: :string
    },
    %{
      description:
        "Optional. Special entities that appear in the question. Currently, only custom emoji entities are allowed in poll questions",
      name: :question_entities,
      optional: true,
      type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity}
    },
    %{
      description: "List of poll options",
      name: :options,
      optional: false,
      type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.PollOption}
    },
    %{
      description: "Total number of users that voted in the poll",
      name: :total_voter_count,
      optional: false,
      type: :integer
    },
    %{
      description: "True, if the poll is closed",
      name: :is_closed,
      optional: false,
      type: :boolean
    },
    %{
      description: "True, if the poll is anonymous",
      name: :is_anonymous,
      optional: false,
      type: :boolean
    },
    %{
      description: "Poll type, currently can be “regular” or “quiz”",
      name: :type,
      optional: false,
      type: :string
    },
    %{
      description: "True, if the poll allows multiple answers",
      name: :allows_multiple_answers,
      optional: false,
      type: :boolean
    },
    %{
      description:
        "Optional. 0-based identifier of the correct answer option. Available only for polls in the quiz mode, which are closed, or was sent (not forwarded) by the bot or to the private chat with the bot.",
      name: :correct_option_id,
      optional: true,
      type: :integer
    },
    %{
      description:
        "Optional. Text that is shown when a user chooses an incorrect answer or taps on the lamp icon in a quiz-style poll, 0-200 characters",
      name: :explanation,
      optional: true,
      type: :string
    },
    %{
      description:
        "Optional. Special entities like usernames, URLs, bot commands, etc. that appear in the explanation",
      name: :explanation_entities,
      optional: true,
      type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity}
    },
    %{
      description: "Optional. Amount of time in seconds the poll will be active after creation",
      name: :open_period,
      optional: true,
      type: :integer
    },
    %{
      description:
        "Optional. Point in time (Unix timestamp) when the poll will be automatically closed",
      name: :close_date,
      optional: true,
      type: :integer
    }
  ])

  deftype(Location, "This object represents a point on the map.", [
    %{
      description: "Latitude as defined by the sender",
      name: :latitude,
      optional: false,
      type: :float
    },
    %{
      description: "Longitude as defined by the sender",
      name: :longitude,
      optional: false,
      type: :float
    },
    %{
      description:
        "Optional. The radius of uncertainty for the location, measured in meters; 0-1500",
      name: :horizontal_accuracy,
      optional: true,
      type: :float
    },
    %{
      description:
        "Optional. Time relative to the message sending date, during which the location can be updated; in seconds. For active live locations only.",
      name: :live_period,
      optional: true,
      type: :integer
    },
    %{
      description:
        "Optional. The direction in which user is moving, in degrees; 1-360. For active live locations only.",
      name: :heading,
      optional: true,
      type: :integer
    },
    %{
      description:
        "Optional. The maximum distance for proximity alerts about approaching another chat member, in meters. For sent live locations only.",
      name: :proximity_alert_radius,
      optional: true,
      type: :integer
    }
  ])

  deftype(Venue, "This object represents a venue.", [
    %{
      description: "Venue location. Can't be a live location",
      name: :location,
      optional: false,
      type: Telegex.Type.Location
    },
    %{description: "Name of the venue", name: :title, optional: false, type: :string},
    %{description: "Address of the venue", name: :address, optional: false, type: :string},
    %{
      description: "Optional. Foursquare identifier of the venue",
      name: :foursquare_id,
      optional: true,
      type: :string
    },
    %{
      description:
        "Optional. Foursquare type of the venue. (For example, “arts_entertainment/default”, “arts_entertainment/aquarium” or “food/icecream”.)",
      name: :foursquare_type,
      optional: true,
      type: :string
    },
    %{
      description: "Optional. Google Places identifier of the venue",
      name: :google_place_id,
      optional: true,
      type: :string
    },
    %{
      description: "Optional. Google Places type of the venue. (See supported types.)",
      name: :google_place_type,
      optional: true,
      type: :string
    }
  ])

  deftype(WebAppData, "Describes data sent from a Web App to the bot.", [
    %{
      description: "The data. Be aware that a bad client can send arbitrary data in this field.",
      name: :data,
      optional: false,
      type: :string
    },
    %{
      description:
        "Text of the web_app keyboard button from which the Web App was opened. Be aware that a bad client can send arbitrary data in this field.",
      name: :button_text,
      optional: false,
      type: :string
    }
  ])

  deftype(
    ProximityAlertTriggered,
    "This object represents the content of a service message, sent whenever a user in the chat triggers a proximity alert set by another user.",
    [
      %{
        description: "User that triggered the alert",
        name: :traveler,
        optional: false,
        type: Telegex.Type.User
      },
      %{
        description: "User that set the alert",
        name: :watcher,
        optional: false,
        type: Telegex.Type.User
      },
      %{
        description: "The distance between the users",
        name: :distance,
        optional: false,
        type: :integer
      }
    ]
  )

  deftype(
    MessageAutoDeleteTimerChanged,
    "This object represents a service message about a change in auto-delete timer settings.",
    [
      %{
        description: "New auto-delete time for messages in the chat; in seconds",
        name: :message_auto_delete_time,
        optional: false,
        type: :integer
      }
    ]
  )

  deftype(
    ChatBoostAdded,
    "This object represents a service message about a user boosting a chat.",
    [
      %{
        description: "Number of boosts added by the user",
        name: :boost_count,
        optional: false,
        type: :integer
      }
    ]
  )

  deftype(BackgroundFillSolid, "The background is filled using the selected color.", [
    %{
      description: "Type of the background fill, always “solid”",
      name: :type,
      optional: false,
      type: :string
    },
    %{
      description: "The color of the background fill in the RGB24 format",
      name: :color,
      optional: false,
      type: :integer
    }
  ])

  deftype(BackgroundFillGradient, "The background is a gradient fill.", [
    %{
      description: "Type of the background fill, always “gradient”",
      name: :type,
      optional: false,
      type: :string
    },
    %{
      description: "Top color of the gradient in the RGB24 format",
      name: :top_color,
      optional: false,
      type: :integer
    },
    %{
      description: "Bottom color of the gradient in the RGB24 format",
      name: :bottom_color,
      optional: false,
      type: :integer
    },
    %{
      description: "Clockwise rotation angle of the background fill in degrees; 0-359",
      name: :rotation_angle,
      optional: false,
      type: :integer
    }
  ])

  deftype(
    BackgroundFillFreeformGradient,
    "The background is a freeform gradient that rotates after every message in the chat.",
    [
      %{
        description: "Type of the background fill, always “freeform_gradient”",
        name: :type,
        optional: false,
        type: :string
      },
      %{
        description:
          "A list of the 3 or 4 base colors that are used to generate the freeform gradient in the RGB24 format",
        name: :colors,
        optional: false,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: :integer}
      }
    ]
  )

  deftype(
    BackgroundTypeFill,
    "The background is automatically filled based on the selected colors.",
    [
      %{
        description: "Type of the background, always “fill”",
        name: :type,
        optional: false,
        type: :string
      },
      %{
        description: "The background fill",
        name: :fill,
        optional: false,
        type: Telegex.Type.BackgroundFill
      },
      %{
        description: "Dimming of the background in dark themes, as a percentage; 0-100",
        name: :dark_theme_dimming,
        optional: false,
        type: :integer
      }
    ]
  )

  deftype(BackgroundTypeWallpaper, "The background is a wallpaper in the JPEG format.", [
    %{
      description: "Type of the background, always “wallpaper”",
      name: :type,
      optional: false,
      type: :string
    },
    %{
      description: "Document with the wallpaper",
      name: :document,
      optional: false,
      type: Telegex.Type.Document
    },
    %{
      description: "Dimming of the background in dark themes, as a percentage; 0-100",
      name: :dark_theme_dimming,
      optional: false,
      type: :integer
    },
    %{
      description:
        "Optional. True, if the wallpaper is downscaled to fit in a 450x450 square and then box-blurred with radius 12",
      name: :is_blurred,
      optional: true,
      type: :boolean
    },
    %{
      description: "Optional. True, if the background moves slightly when the device is tilted",
      name: :is_moving,
      optional: true,
      type: :boolean
    }
  ])

  deftype(
    BackgroundTypePattern,
    "The background is a PNG or TGV (gzipped subset of SVG with MIME type “application/x-tgwallpattern”) pattern to be combined with the background fill chosen by the user.",
    [
      %{
        description: "Type of the background, always “pattern”",
        name: :type,
        optional: false,
        type: :string
      },
      %{
        description: "Document with the pattern",
        name: :document,
        optional: false,
        type: Telegex.Type.Document
      },
      %{
        description: "The background fill that is combined with the pattern",
        name: :fill,
        optional: false,
        type: Telegex.Type.BackgroundFill
      },
      %{
        description:
          "Intensity of the pattern when it is shown above the filled background; 0-100",
        name: :intensity,
        optional: false,
        type: :integer
      },
      %{
        description:
          "Optional. True, if the background fill must be applied only to the pattern itself. All other pixels are black in this case. For dark themes only",
        name: :is_inverted,
        optional: true,
        type: :boolean
      },
      %{
        description: "Optional. True, if the background moves slightly when the device is tilted",
        name: :is_moving,
        optional: true,
        type: :boolean
      }
    ]
  )

  deftype(
    BackgroundTypeChatTheme,
    "The background is taken directly from a built-in chat theme.",
    [
      %{
        description: "Type of the background, always “chat_theme”",
        name: :type,
        optional: false,
        type: :string
      },
      %{
        description: "Name of the chat theme, which is usually an emoji",
        name: :theme_name,
        optional: false,
        type: :string
      }
    ]
  )

  deftype(ChatBackground, "This object represents a chat background.", [
    %{
      description: "Type of the background",
      name: :type,
      optional: false,
      type: Telegex.Type.BackgroundType
    }
  ])

  deftype(
    ForumTopicCreated,
    "This object represents a service message about a new forum topic created in the chat.",
    [
      %{description: "Name of the topic", name: :name, optional: false, type: :string},
      %{
        description: "Color of the topic icon in RGB format",
        name: :icon_color,
        optional: false,
        type: :integer
      },
      %{
        description: "Optional. Unique identifier of the custom emoji shown as the topic icon",
        name: :icon_custom_emoji_id,
        optional: true,
        type: :string
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
        description: "Optional. New name of the topic, if it was edited",
        name: :name,
        optional: true,
        type: :string
      },
      %{
        description:
          "Optional. New identifier of the custom emoji shown as the topic icon, if it was edited; an empty string if the icon was removed",
        name: :icon_custom_emoji_id,
        optional: true,
        type: :string
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
    SharedUser,
    "This object contains information about a user that was shared with the bot using a KeyboardButtonRequestUsers button.",
    [
      %{
        description:
          "Identifier of the shared user. This number may have more than 32 significant bits and some programming languages may have difficulty/silent defects in interpreting it. But it has at most 52 significant bits, so 64-bit integers or double-precision float types are safe for storing these identifiers. The bot may not have access to the user and could be unable to use this identifier, unless the user is already known to the bot by some other means.",
        name: :user_id,
        optional: false,
        type: :integer
      },
      %{
        description: "Optional. First name of the user, if the name was requested by the bot",
        name: :first_name,
        optional: true,
        type: :string
      },
      %{
        description: "Optional. Last name of the user, if the name was requested by the bot",
        name: :last_name,
        optional: true,
        type: :string
      },
      %{
        description: "Optional. Username of the user, if the username was requested by the bot",
        name: :username,
        optional: true,
        type: :string
      },
      %{
        description:
          "Optional. Available sizes of the chat photo, if the photo was requested by the bot",
        name: :photo,
        optional: true,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.PhotoSize}
      }
    ]
  )

  deftype(
    UsersShared,
    "This object contains information about the users whose identifiers were shared with the bot using a KeyboardButtonRequestUsers button.",
    [
      %{
        description: "Identifier of the request",
        name: :request_id,
        optional: false,
        type: :integer
      },
      %{
        description: "Information about users shared with the bot.",
        name: :users,
        optional: false,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.SharedUser}
      }
    ]
  )

  deftype(
    ChatShared,
    "This object contains information about a chat that was shared with the bot using a KeyboardButtonRequestChat button.",
    [
      %{
        description: "Identifier of the request",
        name: :request_id,
        optional: false,
        type: :integer
      },
      %{
        description:
          "Identifier of the shared chat. This number may have more than 32 significant bits and some programming languages may have difficulty/silent defects in interpreting it. But it has at most 52 significant bits, so a 64-bit integer or double-precision float type are safe for storing this identifier. The bot may not have access to the chat and could be unable to use this identifier, unless the chat is already known to the bot by some other means.",
        name: :chat_id,
        optional: false,
        type: :integer
      },
      %{
        description: "Optional. Title of the chat, if the title was requested by the bot.",
        name: :title,
        optional: true,
        type: :string
      },
      %{
        description:
          "Optional. Username of the chat, if the username was requested by the bot and available.",
        name: :username,
        optional: true,
        type: :string
      },
      %{
        description:
          "Optional. Available sizes of the chat photo, if the photo was requested by the bot",
        name: :photo,
        optional: true,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.PhotoSize}
      }
    ]
  )

  deftype(
    WriteAccessAllowed,
    "This object represents a service message about a user allowing a bot to write messages after adding it to the attachment menu, launching a Web App from a link, or accepting an explicit request from a Web App sent by the method requestWriteAccess.",
    [
      %{
        description:
          "Optional. True, if the access was granted after the user accepted an explicit request from a Web App sent by the method requestWriteAccess",
        name: :from_request,
        optional: true,
        type: :boolean
      },
      %{
        description:
          "Optional. Name of the Web App, if the access was granted when the Web App was launched from a link",
        name: :web_app_name,
        optional: true,
        type: :string
      },
      %{
        description:
          "Optional. True, if the access was granted when the bot was added to the attachment or side menu",
        name: :from_attachment_menu,
        optional: true,
        type: :boolean
      }
    ]
  )

  deftype(
    VideoChatScheduled,
    "This object represents a service message about a video chat scheduled in the chat.",
    [
      %{
        description:
          "Point in time (Unix timestamp) when the video chat is supposed to be started by a chat administrator",
        name: :start_date,
        optional: false,
        type: :integer
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
        description: "Video chat duration in seconds",
        name: :duration,
        optional: false,
        type: :integer
      }
    ]
  )

  deftype(
    VideoChatParticipantsInvited,
    "This object represents a service message about new members invited to a video chat.",
    [
      %{
        description: "New members that were invited to the video chat",
        name: :users,
        optional: false,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.User}
      }
    ]
  )

  deftype(
    GiveawayCreated,
    "This object represents a service message about the creation of a scheduled giveaway.",
    [
      %{
        description:
          "Optional. The number of Telegram Stars to be split between giveaway winners; for Telegram Star giveaways only",
        name: :prize_star_count,
        optional: true,
        type: :integer
      }
    ]
  )

  deftype(Giveaway, "This object represents a message about a scheduled giveaway.", [
    %{
      description: "The list of chats which the user must join to participate in the giveaway",
      name: :chats,
      optional: false,
      type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.Chat}
    },
    %{
      description: "Point in time (Unix timestamp) when winners of the giveaway will be selected",
      name: :winners_selection_date,
      optional: false,
      type: :integer
    },
    %{
      description:
        "The number of users which are supposed to be selected as winners of the giveaway",
      name: :winner_count,
      optional: false,
      type: :integer
    },
    %{
      description:
        "Optional. True, if only users who join the chats after the giveaway started should be eligible to win",
      name: :only_new_members,
      optional: true,
      type: :boolean
    },
    %{
      description: "Optional. True, if the list of giveaway winners will be visible to everyone",
      name: :has_public_winners,
      optional: true,
      type: :boolean
    },
    %{
      description: "Optional. Description of additional giveaway prize",
      name: :prize_description,
      optional: true,
      type: :string
    },
    %{
      description:
        "Optional. A list of two-letter ISO 3166-1 alpha-2 country codes indicating the countries from which eligible users for the giveaway must come. If empty, then all users can participate in the giveaway. Users with a phone number that was bought on Fragment can always participate in giveaways.",
      name: :country_codes,
      optional: true,
      type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: :string}
    },
    %{
      description:
        "Optional. The number of Telegram Stars to be split between giveaway winners; for Telegram Star giveaways only",
      name: :prize_star_count,
      optional: true,
      type: :integer
    },
    %{
      description:
        "Optional. The number of months the Telegram Premium subscription won from the giveaway will be active for; for Telegram Premium giveaways only",
      name: :premium_subscription_month_count,
      optional: true,
      type: :integer
    }
  ])

  deftype(
    GiveawayWinners,
    "This object represents a message about the completion of a giveaway with public winners.",
    [
      %{
        description: "The chat that created the giveaway",
        name: :chat,
        optional: false,
        type: Telegex.Type.Chat
      },
      %{
        description: "Identifier of the message with the giveaway in the chat",
        name: :giveaway_message_id,
        optional: false,
        type: :integer
      },
      %{
        description: "Point in time (Unix timestamp) when winners of the giveaway were selected",
        name: :winners_selection_date,
        optional: false,
        type: :integer
      },
      %{
        description: "Total number of winners in the giveaway",
        name: :winner_count,
        optional: false,
        type: :integer
      },
      %{
        description: "List of up to 100 winners of the giveaway",
        name: :winners,
        optional: false,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.User}
      },
      %{
        description:
          "Optional. The number of other chats the user had to join in order to be eligible for the giveaway",
        name: :additional_chat_count,
        optional: true,
        type: :integer
      },
      %{
        description:
          "Optional. The number of Telegram Stars that were split between giveaway winners; for Telegram Star giveaways only",
        name: :prize_star_count,
        optional: true,
        type: :integer
      },
      %{
        description:
          "Optional. The number of months the Telegram Premium subscription won from the giveaway will be active for; for Telegram Premium giveaways only",
        name: :premium_subscription_month_count,
        optional: true,
        type: :integer
      },
      %{
        description: "Optional. Number of undistributed prizes",
        name: :unclaimed_prize_count,
        optional: true,
        type: :integer
      },
      %{
        description:
          "Optional. True, if only users who had joined the chats after the giveaway started were eligible to win",
        name: :only_new_members,
        optional: true,
        type: :boolean
      },
      %{
        description:
          "Optional. True, if the giveaway was canceled because the payment for it was refunded",
        name: :was_refunded,
        optional: true,
        type: :boolean
      },
      %{
        description: "Optional. Description of additional giveaway prize",
        name: :prize_description,
        optional: true,
        type: :string
      }
    ]
  )

  deftype(
    GiveawayCompleted,
    "This object represents a service message about the completion of a giveaway without public winners.",
    [
      %{
        description: "Number of winners in the giveaway",
        name: :winner_count,
        optional: false,
        type: :integer
      },
      %{
        description: "Optional. Number of undistributed prizes",
        name: :unclaimed_prize_count,
        optional: true,
        type: :integer
      },
      %{
        description:
          "Optional. Message with the giveaway that was completed, if it wasn't deleted",
        name: :giveaway_message,
        optional: true,
        type: Telegex.Type.Message
      },
      %{
        description:
          "Optional. True, if the giveaway is a Telegram Star giveaway. Otherwise, currently, the giveaway is a Telegram Premium giveaway.",
        name: :is_star_giveaway,
        optional: true,
        type: :boolean
      }
    ]
  )

  deftype(LinkPreviewOptions, "Describes the options used for link preview generation.", [
    %{
      description: "Optional. True, if the link preview is disabled",
      name: :is_disabled,
      optional: true,
      type: :boolean
    },
    %{
      description:
        "Optional. URL to use for the link preview. If empty, then the first URL found in the message text will be used",
      name: :url,
      optional: true,
      type: :string
    },
    %{
      description:
        "Optional. True, if the media in the link preview is supposed to be shrunk; ignored if the URL isn't explicitly specified or media size change isn't supported for the preview",
      name: :prefer_small_media,
      optional: true,
      type: :boolean
    },
    %{
      description:
        "Optional. True, if the media in the link preview is supposed to be enlarged; ignored if the URL isn't explicitly specified or media size change isn't supported for the preview",
      name: :prefer_large_media,
      optional: true,
      type: :boolean
    },
    %{
      description:
        "Optional. True, if the link preview must be shown above the message text; otherwise, the link preview will be shown below the message text",
      name: :show_above_text,
      optional: true,
      type: :boolean
    }
  ])

  deftype(UserProfilePhotos, "This object represent a user's profile pictures.", [
    %{
      description: "Total number of profile pictures the target user has",
      name: :total_count,
      optional: false,
      type: :integer
    },
    %{
      description: "Requested profile pictures (in up to 4 sizes each)",
      name: :photos,
      optional: false,
      type: %{
        __struct__: Telegex.TypeDefiner.ArrayType,
        elem_type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.PhotoSize}
      }
    }
  ])

  deftype(
    File,
    "This object represents a file ready to be downloaded. The file can be downloaded via the link https://api.telegram.org/file/bot<token>/<file_path>. It is guaranteed that the link will be valid for at least 1 hour. When the link expires, a new one can be requested by calling getFile.",
    [
      %{
        description: "Identifier for this file, which can be used to download or reuse the file",
        name: :file_id,
        optional: false,
        type: :string
      },
      %{
        description:
          "Unique identifier for this file, which is supposed to be the same over time and for different bots. Can't be used to download or reuse the file.",
        name: :file_unique_id,
        optional: false,
        type: :string
      },
      %{
        description:
          "Optional. File size in bytes. It can be bigger than 2^31 and some programming languages may have difficulty/silent defects in interpreting it. But it has at most 52 significant bits, so a signed 64-bit integer or double-precision float type are safe for storing this value.",
        name: :file_size,
        optional: true,
        type: :integer
      },
      %{
        description:
          "Optional. File path. Use https://api.telegram.org/file/bot<token>/<file_path> to get the file.",
        name: :file_path,
        optional: true,
        type: :string
      }
    ]
  )

  deftype(WebAppInfo, "Describes a Web App.", [
    %{
      description:
        "An HTTPS URL of a Web App to be opened with additional data as specified in Initializing Web Apps",
      name: :url,
      optional: false,
      type: :string
    }
  ])

  deftype(
    ReplyKeyboardMarkup,
    "This object represents a custom keyboard with reply options (see Introduction to bots for details and examples). Not supported in channels and for messages sent on behalf of a Telegram Business account.",
    [
      %{
        description:
          "Array of button rows, each represented by an Array of KeyboardButton objects",
        name: :keyboard,
        optional: false,
        type: %{
          __struct__: Telegex.TypeDefiner.ArrayType,
          elem_type: %{
            __struct__: Telegex.TypeDefiner.ArrayType,
            elem_type: Telegex.Type.KeyboardButton
          }
        }
      },
      %{
        description:
          "Optional. Requests clients to always show the keyboard when the regular keyboard is hidden. Defaults to false, in which case the custom keyboard can be hidden and opened with a keyboard icon.",
        name: :is_persistent,
        optional: true,
        type: :boolean
      },
      %{
        description:
          "Optional. Requests clients to resize the keyboard vertically for optimal fit (e.g., make the keyboard smaller if there are just two rows of buttons). Defaults to false, in which case the custom keyboard is always of the same height as the app's standard keyboard.",
        name: :resize_keyboard,
        optional: true,
        type: :boolean
      },
      %{
        description:
          "Optional. Requests clients to hide the keyboard as soon as it's been used. The keyboard will still be available, but clients will automatically display the usual letter-keyboard in the chat - the user can press a special button in the input field to see the custom keyboard again. Defaults to false.",
        name: :one_time_keyboard,
        optional: true,
        type: :boolean
      },
      %{
        description:
          "Optional. The placeholder to be shown in the input field when the keyboard is active; 1-64 characters",
        name: :input_field_placeholder,
        optional: true,
        type: :string
      },
      %{
        description:
          "Optional. Use this parameter if you want to show the keyboard to specific users only. Targets: 1) users that are @mentioned in the text of the Message object; 2) if the bot's message is a reply to a message in the same chat and forum topic, sender of the original message.\n\nExample: A user requests to change the bot's language, bot replies to the request with a keyboard to select the new language. Other users in the group don't see the keyboard.",
        name: :selective,
        optional: true,
        type: :boolean
      }
    ]
  )

  deftype(
    KeyboardButton,
    "This object represents one button of the reply keyboard. At most one of the optional fields must be used to specify type of the button. For simple text buttons, String can be used instead of this object to specify the button text.",
    [
      %{
        description:
          "Text of the button. If none of the optional fields are used, it will be sent as a message when the button is pressed",
        name: :text,
        optional: false,
        type: :string
      },
      %{
        description:
          "Optional. If specified, pressing the button will open a list of suitable users. Identifiers of selected users will be sent to the bot in a “users_shared” service message. Available in private chats only.",
        name: :request_users,
        optional: true,
        type: Telegex.Type.KeyboardButtonRequestUsers
      },
      %{
        description:
          "Optional. If specified, pressing the button will open a list of suitable chats. Tapping on a chat will send its identifier to the bot in a “chat_shared” service message. Available in private chats only.",
        name: :request_chat,
        optional: true,
        type: Telegex.Type.KeyboardButtonRequestChat
      },
      %{
        description:
          "Optional. If True, the user's phone number will be sent as a contact when the button is pressed. Available in private chats only.",
        name: :request_contact,
        optional: true,
        type: :boolean
      },
      %{
        description:
          "Optional. If True, the user's current location will be sent when the button is pressed. Available in private chats only.",
        name: :request_location,
        optional: true,
        type: :boolean
      },
      %{
        description:
          "Optional. If specified, the user will be asked to create a poll and send it to the bot when the button is pressed. Available in private chats only.",
        name: :request_poll,
        optional: true,
        type: Telegex.Type.KeyboardButtonPollType
      },
      %{
        description:
          "Optional. If specified, the described Web App will be launched when the button is pressed. The Web App will be able to send a “web_app_data” service message. Available in private chats only.",
        name: :web_app,
        optional: true,
        type: Telegex.Type.WebAppInfo
      }
    ]
  )

  deftype(
    KeyboardButtonRequestUsers,
    "This object defines the criteria used to request suitable users. Information about the selected users will be shared with the bot when the corresponding button is pressed. More about requesting users »",
    [
      %{
        description:
          "Signed 32-bit identifier of the request that will be received back in the UsersShared object. Must be unique within the message",
        name: :request_id,
        optional: false,
        type: :integer
      },
      %{
        description:
          "Optional. Pass True to request bots, pass False to request regular users. If not specified, no additional restrictions are applied.",
        name: :user_is_bot,
        optional: true,
        type: :boolean
      },
      %{
        description:
          "Optional. Pass True to request premium users, pass False to request non-premium users. If not specified, no additional restrictions are applied.",
        name: :user_is_premium,
        optional: true,
        type: :boolean
      },
      %{
        description: "Optional. The maximum number of users to be selected; 1-10. Defaults to 1.",
        name: :max_quantity,
        optional: true,
        type: :integer
      },
      %{
        description: "Optional. Pass True to request the users' first and last names",
        name: :request_name,
        optional: true,
        type: :boolean
      },
      %{
        description: "Optional. Pass True to request the users' usernames",
        name: :request_username,
        optional: true,
        type: :boolean
      },
      %{
        description: "Optional. Pass True to request the users' photos",
        name: :request_photo,
        optional: true,
        type: :boolean
      }
    ]
  )

  deftype(
    KeyboardButtonRequestChat,
    "This object defines the criteria used to request a suitable chat. Information about the selected chat will be shared with the bot when the corresponding button is pressed. The bot will be granted requested rights in the chat if appropriate. More about requesting chats ».",
    [
      %{
        description:
          "Signed 32-bit identifier of the request, which will be received back in the ChatShared object. Must be unique within the message",
        name: :request_id,
        optional: false,
        type: :integer
      },
      %{
        description:
          "Pass True to request a channel chat, pass False to request a group or a supergroup chat.",
        name: :chat_is_channel,
        optional: false,
        type: :boolean
      },
      %{
        description:
          "Optional. Pass True to request a forum supergroup, pass False to request a non-forum chat. If not specified, no additional restrictions are applied.",
        name: :chat_is_forum,
        optional: true,
        type: :boolean
      },
      %{
        description:
          "Optional. Pass True to request a supergroup or a channel with a username, pass False to request a chat without a username. If not specified, no additional restrictions are applied.",
        name: :chat_has_username,
        optional: true,
        type: :boolean
      },
      %{
        description:
          "Optional. Pass True to request a chat owned by the user. Otherwise, no additional restrictions are applied.",
        name: :chat_is_created,
        optional: true,
        type: :boolean
      },
      %{
        description:
          "Optional. A JSON-serialized object listing the required administrator rights of the user in the chat. The rights must be a superset of bot_administrator_rights. If not specified, no additional restrictions are applied.",
        name: :user_administrator_rights,
        optional: true,
        type: Telegex.Type.ChatAdministratorRights
      },
      %{
        description:
          "Optional. A JSON-serialized object listing the required administrator rights of the bot in the chat. The rights must be a subset of user_administrator_rights. If not specified, no additional restrictions are applied.",
        name: :bot_administrator_rights,
        optional: true,
        type: Telegex.Type.ChatAdministratorRights
      },
      %{
        description:
          "Optional. Pass True to request a chat with the bot as a member. Otherwise, no additional restrictions are applied.",
        name: :bot_is_member,
        optional: true,
        type: :boolean
      },
      %{
        description: "Optional. Pass True to request the chat's title",
        name: :request_title,
        optional: true,
        type: :boolean
      },
      %{
        description: "Optional. Pass True to request the chat's username",
        name: :request_username,
        optional: true,
        type: :boolean
      },
      %{
        description: "Optional. Pass True to request the chat's photo",
        name: :request_photo,
        optional: true,
        type: :boolean
      }
    ]
  )

  deftype(
    KeyboardButtonPollType,
    "This object represents type of a poll, which is allowed to be created and sent when the corresponding button is pressed.",
    [
      %{
        description:
          "Optional. If quiz is passed, the user will be allowed to create only polls in the quiz mode. If regular is passed, only regular polls will be allowed. Otherwise, the user will be allowed to create a poll of any type.",
        name: :type,
        optional: true,
        type: :string
      }
    ]
  )

  deftype(
    ReplyKeyboardRemove,
    "Upon receiving a message with this object, Telegram clients will remove the current custom keyboard and display the default letter-keyboard. By default, custom keyboards are displayed until a new keyboard is sent by a bot. An exception is made for one-time keyboards that are hidden immediately after the user presses a button (see ReplyKeyboardMarkup). Not supported in channels and for messages sent on behalf of a Telegram Business account.",
    [
      %{
        description:
          "Requests clients to remove the custom keyboard (user will not be able to summon this keyboard; if you want to hide the keyboard from sight but keep it accessible, use one_time_keyboard in ReplyKeyboardMarkup)",
        name: :remove_keyboard,
        optional: false,
        type: :boolean
      },
      %{
        description:
          "Optional. Use this parameter if you want to remove the keyboard for specific users only. Targets: 1) users that are @mentioned in the text of the Message object; 2) if the bot's message is a reply to a message in the same chat and forum topic, sender of the original message.\n\nExample: A user votes in a poll, bot returns confirmation message in reply to the vote and removes the keyboard for that user, while still showing the keyboard with poll options to users who haven't voted yet.",
        name: :selective,
        optional: true,
        type: :boolean
      }
    ]
  )

  deftype(
    InlineKeyboardMarkup,
    "This object represents an inline keyboard that appears right next to the message it belongs to.",
    [
      %{
        description:
          "Array of button rows, each represented by an Array of InlineKeyboardButton objects",
        name: :inline_keyboard,
        optional: false,
        type: %{
          __struct__: Telegex.TypeDefiner.ArrayType,
          elem_type: %{
            __struct__: Telegex.TypeDefiner.ArrayType,
            elem_type: Telegex.Type.InlineKeyboardButton
          }
        }
      }
    ]
  )

  deftype(
    InlineKeyboardButton,
    "This object represents one button of an inline keyboard. Exactly one of the optional fields must be used to specify type of the button.",
    [
      %{description: "Label text on the button", name: :text, optional: false, type: :string},
      %{
        description:
          "Optional. HTTP or tg:// URL to be opened when the button is pressed. Links tg://user?id=<user_id> can be used to mention a user by their identifier without using a username, if this is allowed by their privacy settings.",
        name: :url,
        optional: true,
        type: :string
      },
      %{
        description:
          "Optional. Data to be sent in a callback query to the bot when the button is pressed, 1-64 bytes",
        name: :callback_data,
        optional: true,
        type: :string
      },
      %{
        description:
          "Optional. Description of the Web App that will be launched when the user presses the button. The Web App will be able to send an arbitrary message on behalf of the user using the method answerWebAppQuery. Available only in private chats between a user and the bot. Not supported for messages sent on behalf of a Telegram Business account.",
        name: :web_app,
        optional: true,
        type: Telegex.Type.WebAppInfo
      },
      %{
        description:
          "Optional. An HTTPS URL used to automatically authorize the user. Can be used as a replacement for the Telegram Login Widget.",
        name: :login_url,
        optional: true,
        type: Telegex.Type.LoginUrl
      },
      %{
        description:
          "Optional. If set, pressing the button will prompt the user to select one of their chats, open that chat and insert the bot's username and the specified inline query in the input field. May be empty, in which case just the bot's username will be inserted. Not supported for messages sent on behalf of a Telegram Business account.",
        name: :switch_inline_query,
        optional: true,
        type: :string
      },
      %{
        description:
          "Optional. If set, pressing the button will insert the bot's username and the specified inline query in the current chat's input field. May be empty, in which case only the bot's username will be inserted.\n\nThis offers a quick way for the user to open your bot in inline mode in the same chat - good for selecting something from multiple options. Not supported in channels and for messages sent on behalf of a Telegram Business account.",
        name: :switch_inline_query_current_chat,
        optional: true,
        type: :string
      },
      %{
        description:
          "Optional. If set, pressing the button will prompt the user to select one of their chats of the specified type, open that chat and insert the bot's username and the specified inline query in the input field. Not supported for messages sent on behalf of a Telegram Business account.",
        name: :switch_inline_query_chosen_chat,
        optional: true,
        type: Telegex.Type.SwitchInlineQueryChosenChat
      },
      %{
        description:
          "Optional. Description of the button that copies the specified text to the clipboard.",
        name: :copy_text,
        optional: true,
        type: Telegex.Type.CopyTextButton
      },
      %{
        description:
          "Optional. Description of the game that will be launched when the user presses the button.\n\nNOTE: This type of button must always be the first button in the first row.",
        name: :callback_game,
        optional: true,
        type: Telegex.Type.CallbackGame
      },
      %{
        description:
          "Optional. Specify True, to send a Pay button. Substrings “” and “XTR” in the buttons's text will be replaced with a Telegram Star icon.\n\nNOTE: This type of button must always be the first button in the first row and can only be used in invoice messages.",
        name: :pay,
        optional: true,
        type: :boolean
      }
    ]
  )

  deftype(
    LoginUrl,
    "This object represents a parameter of the inline keyboard button used to automatically authorize a user. Serves as a great replacement for the Telegram Login Widget when the user is coming from Telegram. All the user needs to do is tap/click a button and confirm that they want to log in:",
    [
      %{
        description:
          "An HTTPS URL to be opened with user authorization data added to the query string when the button is pressed. If the user refuses to provide authorization data, the original URL without information about the user will be opened. The data added is the same as described in Receiving authorization data.\n\nNOTE: You must always check the hash of the received data to verify the authentication and the integrity of the data as described in Checking authorization.",
        name: :url,
        optional: false,
        type: :string
      },
      %{
        description: "Optional. New text of the button in forwarded messages.",
        name: :forward_text,
        optional: true,
        type: :string
      },
      %{
        description:
          "Optional. Username of a bot, which will be used for user authorization. See Setting up a bot for more details. If not specified, the current bot's username will be assumed. The url's domain must be the same as the domain linked with the bot. See Linking your domain to the bot for more details.",
        name: :bot_username,
        optional: true,
        type: :string
      },
      %{
        description:
          "Optional. Pass True to request the permission for your bot to send messages to the user.",
        name: :request_write_access,
        optional: true,
        type: :boolean
      }
    ]
  )

  deftype(
    SwitchInlineQueryChosenChat,
    "This object represents an inline button that switches the current user to inline mode in a chosen chat, with an optional default inline query.",
    [
      %{
        description:
          "Optional. The default inline query to be inserted in the input field. If left empty, only the bot's username will be inserted",
        name: :query,
        optional: true,
        type: :string
      },
      %{
        description: "Optional. True, if private chats with users can be chosen",
        name: :allow_user_chats,
        optional: true,
        type: :boolean
      },
      %{
        description: "Optional. True, if private chats with bots can be chosen",
        name: :allow_bot_chats,
        optional: true,
        type: :boolean
      },
      %{
        description: "Optional. True, if group and supergroup chats can be chosen",
        name: :allow_group_chats,
        optional: true,
        type: :boolean
      },
      %{
        description: "Optional. True, if channel chats can be chosen",
        name: :allow_channel_chats,
        optional: true,
        type: :boolean
      }
    ]
  )

  deftype(
    CopyTextButton,
    "This object represents an inline keyboard button that copies specified text to the clipboard.",
    [
      %{
        description: "The text to be copied to the clipboard; 1-256 characters",
        name: :text,
        optional: false,
        type: :string
      }
    ]
  )

  deftype(
    CallbackQuery,
    "This object represents an incoming callback query from a callback button in an inline keyboard. If the button that originated the query was attached to a message sent by the bot, the field message will be present. If the button was attached to a message sent via the bot (in inline mode), the field inline_message_id will be present. Exactly one of the fields data or game_short_name will be present.",
    [
      %{
        description: "Unique identifier for this query",
        name: :id,
        optional: false,
        type: :string
      },
      %{description: "Sender", name: :from, optional: false, type: Telegex.Type.User},
      %{
        description:
          "Optional. Message sent by the bot with the callback button that originated the query",
        name: :message,
        optional: true,
        type: Telegex.Type.MaybeInaccessibleMessage
      },
      %{
        description:
          "Optional. Identifier of the message sent via the bot in inline mode, that originated the query.",
        name: :inline_message_id,
        optional: true,
        type: :string
      },
      %{
        description:
          "Global identifier, uniquely corresponding to the chat to which the message with the callback button was sent. Useful for high scores in games.",
        name: :chat_instance,
        optional: false,
        type: :string
      },
      %{
        description:
          "Optional. Data associated with the callback button. Be aware that the message originated the query can contain no callback buttons with this data.",
        name: :data,
        optional: true,
        type: :string
      },
      %{
        description:
          "Optional. Short name of a Game to be returned, serves as the unique identifier for the game",
        name: :game_short_name,
        optional: true,
        type: :string
      }
    ]
  )

  deftype(
    ForceReply,
    "Upon receiving a message with this object, Telegram clients will display a reply interface to the user (act as if the user has selected the bot's message and tapped 'Reply'). This can be extremely useful if you want to create user-friendly step-by-step interfaces without having to sacrifice privacy mode. Not supported in channels and for messages sent on behalf of a Telegram Business account.",
    [
      %{
        description:
          "Shows reply interface to the user, as if they manually selected the bot's message and tapped 'Reply'",
        name: :force_reply,
        optional: false,
        type: :boolean
      },
      %{
        description:
          "Optional. The placeholder to be shown in the input field when the reply is active; 1-64 characters",
        name: :input_field_placeholder,
        optional: true,
        type: :string
      },
      %{
        description:
          "Optional. Use this parameter if you want to force reply from specific users only. Targets: 1) users that are @mentioned in the text of the Message object; 2) if the bot's message is a reply to a message in the same chat and forum topic, sender of the original message.",
        name: :selective,
        optional: true,
        type: :boolean
      }
    ]
  )

  deftype(ChatPhoto, "This object represents a chat photo.", [
    %{
      description:
        "File identifier of small (160x160) chat photo. This file_id can be used only for photo download and only for as long as the photo is not changed.",
      name: :small_file_id,
      optional: false,
      type: :string
    },
    %{
      description:
        "Unique file identifier of small (160x160) chat photo, which is supposed to be the same over time and for different bots. Can't be used to download or reuse the file.",
      name: :small_file_unique_id,
      optional: false,
      type: :string
    },
    %{
      description:
        "File identifier of big (640x640) chat photo. This file_id can be used only for photo download and only for as long as the photo is not changed.",
      name: :big_file_id,
      optional: false,
      type: :string
    },
    %{
      description:
        "Unique file identifier of big (640x640) chat photo, which is supposed to be the same over time and for different bots. Can't be used to download or reuse the file.",
      name: :big_file_unique_id,
      optional: false,
      type: :string
    }
  ])

  deftype(ChatInviteLink, "Represents an invite link for a chat.", [
    %{
      description:
        "The invite link. If the link was created by another chat administrator, then the second part of the link will be replaced with “…”.",
      name: :invite_link,
      optional: false,
      type: :string
    },
    %{
      description: "Creator of the link",
      name: :creator,
      optional: false,
      type: Telegex.Type.User
    },
    %{
      description:
        "True, if users joining the chat via the link need to be approved by chat administrators",
      name: :creates_join_request,
      optional: false,
      type: :boolean
    },
    %{
      description: "True, if the link is primary",
      name: :is_primary,
      optional: false,
      type: :boolean
    },
    %{
      description: "True, if the link is revoked",
      name: :is_revoked,
      optional: false,
      type: :boolean
    },
    %{description: "Optional. Invite link name", name: :name, optional: true, type: :string},
    %{
      description:
        "Optional. Point in time (Unix timestamp) when the link will expire or has been expired",
      name: :expire_date,
      optional: true,
      type: :integer
    },
    %{
      description:
        "Optional. The maximum number of users that can be members of the chat simultaneously after joining the chat via this invite link; 1-99999",
      name: :member_limit,
      optional: true,
      type: :integer
    },
    %{
      description: "Optional. Number of pending join requests created using this link",
      name: :pending_join_request_count,
      optional: true,
      type: :integer
    },
    %{
      description:
        "Optional. The number of seconds the subscription will be active for before the next payment",
      name: :subscription_period,
      optional: true,
      type: :integer
    },
    %{
      description:
        "Optional. The amount of Telegram Stars a user must pay initially and after each subsequent subscription period to be a member of the chat using the link",
      name: :subscription_price,
      optional: true,
      type: :integer
    }
  ])

  deftype(ChatAdministratorRights, "Represents the rights of an administrator in a chat.", [
    %{
      description: "True, if the user's presence in the chat is hidden",
      name: :is_anonymous,
      optional: false,
      type: :boolean
    },
    %{
      description:
        "True, if the administrator can access the chat event log, get boost list, see hidden supergroup and channel members, report spam messages and ignore slow mode. Implied by any other administrator privilege.",
      name: :can_manage_chat,
      optional: false,
      type: :boolean
    },
    %{
      description: "True, if the administrator can delete messages of other users",
      name: :can_delete_messages,
      optional: false,
      type: :boolean
    },
    %{
      description: "True, if the administrator can manage video chats",
      name: :can_manage_video_chats,
      optional: false,
      type: :boolean
    },
    %{
      description:
        "True, if the administrator can restrict, ban or unban chat members, or access supergroup statistics",
      name: :can_restrict_members,
      optional: false,
      type: :boolean
    },
    %{
      description:
        "True, if the administrator can add new administrators with a subset of their own privileges or demote administrators that they have promoted, directly or indirectly (promoted by administrators that were appointed by the user)",
      name: :can_promote_members,
      optional: false,
      type: :boolean
    },
    %{
      description:
        "True, if the user is allowed to change the chat title, photo and other settings",
      name: :can_change_info,
      optional: false,
      type: :boolean
    },
    %{
      description: "True, if the user is allowed to invite new users to the chat",
      name: :can_invite_users,
      optional: false,
      type: :boolean
    },
    %{
      description: "True, if the administrator can post stories to the chat",
      name: :can_post_stories,
      optional: false,
      type: :boolean
    },
    %{
      description:
        "True, if the administrator can edit stories posted by other users, post stories to the chat page, pin chat stories, and access the chat's story archive",
      name: :can_edit_stories,
      optional: false,
      type: :boolean
    },
    %{
      description: "True, if the administrator can delete stories posted by other users",
      name: :can_delete_stories,
      optional: false,
      type: :boolean
    },
    %{
      description:
        "Optional. True, if the administrator can post messages in the channel, or access channel statistics; for channels only",
      name: :can_post_messages,
      optional: true,
      type: :boolean
    },
    %{
      description:
        "Optional. True, if the administrator can edit messages of other users and can pin messages; for channels only",
      name: :can_edit_messages,
      optional: true,
      type: :boolean
    },
    %{
      description:
        "Optional. True, if the user is allowed to pin messages; for groups and supergroups only",
      name: :can_pin_messages,
      optional: true,
      type: :boolean
    },
    %{
      description:
        "Optional. True, if the user is allowed to create, rename, close, and reopen forum topics; for supergroups only",
      name: :can_manage_topics,
      optional: true,
      type: :boolean
    }
  ])

  deftype(ChatMemberUpdated, "This object represents changes in the status of a chat member.", [
    %{
      description: "Chat the user belongs to",
      name: :chat,
      optional: false,
      type: Telegex.Type.Chat
    },
    %{
      description: "Performer of the action, which resulted in the change",
      name: :from,
      optional: false,
      type: Telegex.Type.User
    },
    %{
      description: "Date the change was done in Unix time",
      name: :date,
      optional: false,
      type: :integer
    },
    %{
      description: "Previous information about the chat member",
      name: :old_chat_member,
      optional: false,
      type: Telegex.Type.ChatMember
    },
    %{
      description: "New information about the chat member",
      name: :new_chat_member,
      optional: false,
      type: Telegex.Type.ChatMember
    },
    %{
      description:
        "Optional. Chat invite link, which was used by the user to join the chat; for joining by invite link events only.",
      name: :invite_link,
      optional: true,
      type: Telegex.Type.ChatInviteLink
    },
    %{
      description:
        "Optional. True, if the user joined the chat after sending a direct join request without using an invite link and being approved by an administrator",
      name: :via_join_request,
      optional: true,
      type: :boolean
    },
    %{
      description: "Optional. True, if the user joined the chat via a chat folder invite link",
      name: :via_chat_folder_invite_link,
      optional: true,
      type: :boolean
    }
  ])

  deftype(
    ChatMemberOwner,
    "Represents a chat member that owns the chat and has all administrator privileges.",
    [
      %{
        description: "The member's status in the chat, always “creator”",
        name: :status,
        optional: false,
        type: :string
      },
      %{
        description: "Information about the user",
        name: :user,
        optional: false,
        type: Telegex.Type.User
      },
      %{
        description: "True, if the user's presence in the chat is hidden",
        name: :is_anonymous,
        optional: false,
        type: :boolean
      },
      %{
        description: "Optional. Custom title for this user",
        name: :custom_title,
        optional: true,
        type: :string
      }
    ]
  )

  deftype(
    ChatMemberAdministrator,
    "Represents a chat member that has some additional privileges.",
    [
      %{
        description: "The member's status in the chat, always “administrator”",
        name: :status,
        optional: false,
        type: :string
      },
      %{
        description: "Information about the user",
        name: :user,
        optional: false,
        type: Telegex.Type.User
      },
      %{
        description: "True, if the bot is allowed to edit administrator privileges of that user",
        name: :can_be_edited,
        optional: false,
        type: :boolean
      },
      %{
        description: "True, if the user's presence in the chat is hidden",
        name: :is_anonymous,
        optional: false,
        type: :boolean
      },
      %{
        description:
          "True, if the administrator can access the chat event log, get boost list, see hidden supergroup and channel members, report spam messages and ignore slow mode. Implied by any other administrator privilege.",
        name: :can_manage_chat,
        optional: false,
        type: :boolean
      },
      %{
        description: "True, if the administrator can delete messages of other users",
        name: :can_delete_messages,
        optional: false,
        type: :boolean
      },
      %{
        description: "True, if the administrator can manage video chats",
        name: :can_manage_video_chats,
        optional: false,
        type: :boolean
      },
      %{
        description:
          "True, if the administrator can restrict, ban or unban chat members, or access supergroup statistics",
        name: :can_restrict_members,
        optional: false,
        type: :boolean
      },
      %{
        description:
          "True, if the administrator can add new administrators with a subset of their own privileges or demote administrators that they have promoted, directly or indirectly (promoted by administrators that were appointed by the user)",
        name: :can_promote_members,
        optional: false,
        type: :boolean
      },
      %{
        description:
          "True, if the user is allowed to change the chat title, photo and other settings",
        name: :can_change_info,
        optional: false,
        type: :boolean
      },
      %{
        description: "True, if the user is allowed to invite new users to the chat",
        name: :can_invite_users,
        optional: false,
        type: :boolean
      },
      %{
        description: "True, if the administrator can post stories to the chat",
        name: :can_post_stories,
        optional: false,
        type: :boolean
      },
      %{
        description:
          "True, if the administrator can edit stories posted by other users, post stories to the chat page, pin chat stories, and access the chat's story archive",
        name: :can_edit_stories,
        optional: false,
        type: :boolean
      },
      %{
        description: "True, if the administrator can delete stories posted by other users",
        name: :can_delete_stories,
        optional: false,
        type: :boolean
      },
      %{
        description:
          "Optional. True, if the administrator can post messages in the channel, or access channel statistics; for channels only",
        name: :can_post_messages,
        optional: true,
        type: :boolean
      },
      %{
        description:
          "Optional. True, if the administrator can edit messages of other users and can pin messages; for channels only",
        name: :can_edit_messages,
        optional: true,
        type: :boolean
      },
      %{
        description:
          "Optional. True, if the user is allowed to pin messages; for groups and supergroups only",
        name: :can_pin_messages,
        optional: true,
        type: :boolean
      },
      %{
        description:
          "Optional. True, if the user is allowed to create, rename, close, and reopen forum topics; for supergroups only",
        name: :can_manage_topics,
        optional: true,
        type: :boolean
      },
      %{
        description: "Optional. Custom title for this user",
        name: :custom_title,
        optional: true,
        type: :string
      }
    ]
  )

  deftype(
    ChatMemberMember,
    "Represents a chat member that has no additional privileges or restrictions.",
    [
      %{
        description: "The member's status in the chat, always “member”",
        name: :status,
        optional: false,
        type: :string
      },
      %{
        description: "Information about the user",
        name: :user,
        optional: false,
        type: Telegex.Type.User
      },
      %{
        description: "Optional. Date when the user's subscription will expire; Unix time",
        name: :until_date,
        optional: true,
        type: :integer
      }
    ]
  )

  deftype(
    ChatMemberRestricted,
    "Represents a chat member that is under certain restrictions in the chat. Supergroups only.",
    [
      %{
        description: "The member's status in the chat, always “restricted”",
        name: :status,
        optional: false,
        type: :string
      },
      %{
        description: "Information about the user",
        name: :user,
        optional: false,
        type: Telegex.Type.User
      },
      %{
        description: "True, if the user is a member of the chat at the moment of the request",
        name: :is_member,
        optional: false,
        type: :boolean
      },
      %{
        description:
          "True, if the user is allowed to send text messages, contacts, giveaways, giveaway winners, invoices, locations and venues",
        name: :can_send_messages,
        optional: false,
        type: :boolean
      },
      %{
        description: "True, if the user is allowed to send audios",
        name: :can_send_audios,
        optional: false,
        type: :boolean
      },
      %{
        description: "True, if the user is allowed to send documents",
        name: :can_send_documents,
        optional: false,
        type: :boolean
      },
      %{
        description: "True, if the user is allowed to send photos",
        name: :can_send_photos,
        optional: false,
        type: :boolean
      },
      %{
        description: "True, if the user is allowed to send videos",
        name: :can_send_videos,
        optional: false,
        type: :boolean
      },
      %{
        description: "True, if the user is allowed to send video notes",
        name: :can_send_video_notes,
        optional: false,
        type: :boolean
      },
      %{
        description: "True, if the user is allowed to send voice notes",
        name: :can_send_voice_notes,
        optional: false,
        type: :boolean
      },
      %{
        description: "True, if the user is allowed to send polls",
        name: :can_send_polls,
        optional: false,
        type: :boolean
      },
      %{
        description:
          "True, if the user is allowed to send animations, games, stickers and use inline bots",
        name: :can_send_other_messages,
        optional: false,
        type: :boolean
      },
      %{
        description: "True, if the user is allowed to add web page previews to their messages",
        name: :can_add_web_page_previews,
        optional: false,
        type: :boolean
      },
      %{
        description:
          "True, if the user is allowed to change the chat title, photo and other settings",
        name: :can_change_info,
        optional: false,
        type: :boolean
      },
      %{
        description: "True, if the user is allowed to invite new users to the chat",
        name: :can_invite_users,
        optional: false,
        type: :boolean
      },
      %{
        description: "True, if the user is allowed to pin messages",
        name: :can_pin_messages,
        optional: false,
        type: :boolean
      },
      %{
        description: "True, if the user is allowed to create forum topics",
        name: :can_manage_topics,
        optional: false,
        type: :boolean
      },
      %{
        description:
          "Date when restrictions will be lifted for this user; Unix time. If 0, then the user is restricted forever",
        name: :until_date,
        optional: false,
        type: :integer
      }
    ]
  )

  deftype(
    ChatMemberLeft,
    "Represents a chat member that isn't currently a member of the chat, but may join it themselves.",
    [
      %{
        description: "The member's status in the chat, always “left”",
        name: :status,
        optional: false,
        type: :string
      },
      %{
        description: "Information about the user",
        name: :user,
        optional: false,
        type: Telegex.Type.User
      }
    ]
  )

  deftype(
    ChatMemberBanned,
    "Represents a chat member that was banned in the chat and can't return to the chat or view chat messages.",
    [
      %{
        description: "The member's status in the chat, always “kicked”",
        name: :status,
        optional: false,
        type: :string
      },
      %{
        description: "Information about the user",
        name: :user,
        optional: false,
        type: Telegex.Type.User
      },
      %{
        description:
          "Date when restrictions will be lifted for this user; Unix time. If 0, then the user is banned forever",
        name: :until_date,
        optional: false,
        type: :integer
      }
    ]
  )

  deftype(ChatJoinRequest, "Represents a join request sent to a chat.", [
    %{
      description: "Chat to which the request was sent",
      name: :chat,
      optional: false,
      type: Telegex.Type.Chat
    },
    %{
      description: "User that sent the join request",
      name: :from,
      optional: false,
      type: Telegex.Type.User
    },
    %{
      description:
        "Identifier of a private chat with the user who sent the join request. This number may have more than 32 significant bits and some programming languages may have difficulty/silent defects in interpreting it. But it has at most 52 significant bits, so a 64-bit integer or double-precision float type are safe for storing this identifier. The bot can use this identifier for 5 minutes to send messages until the join request is processed, assuming no other administrator contacted the user.",
      name: :user_chat_id,
      optional: false,
      type: :integer
    },
    %{
      description: "Date the request was sent in Unix time",
      name: :date,
      optional: false,
      type: :integer
    },
    %{description: "Optional. Bio of the user.", name: :bio, optional: true, type: :string},
    %{
      description:
        "Optional. Chat invite link that was used by the user to send the join request",
      name: :invite_link,
      optional: true,
      type: Telegex.Type.ChatInviteLink
    }
  ])

  deftype(
    ChatPermissions,
    "Describes actions that a non-administrator user is allowed to take in a chat.",
    [
      %{
        description:
          "Optional. True, if the user is allowed to send text messages, contacts, giveaways, giveaway winners, invoices, locations and venues",
        name: :can_send_messages,
        optional: true,
        type: :boolean
      },
      %{
        description: "Optional. True, if the user is allowed to send audios",
        name: :can_send_audios,
        optional: true,
        type: :boolean
      },
      %{
        description: "Optional. True, if the user is allowed to send documents",
        name: :can_send_documents,
        optional: true,
        type: :boolean
      },
      %{
        description: "Optional. True, if the user is allowed to send photos",
        name: :can_send_photos,
        optional: true,
        type: :boolean
      },
      %{
        description: "Optional. True, if the user is allowed to send videos",
        name: :can_send_videos,
        optional: true,
        type: :boolean
      },
      %{
        description: "Optional. True, if the user is allowed to send video notes",
        name: :can_send_video_notes,
        optional: true,
        type: :boolean
      },
      %{
        description: "Optional. True, if the user is allowed to send voice notes",
        name: :can_send_voice_notes,
        optional: true,
        type: :boolean
      },
      %{
        description: "Optional. True, if the user is allowed to send polls",
        name: :can_send_polls,
        optional: true,
        type: :boolean
      },
      %{
        description:
          "Optional. True, if the user is allowed to send animations, games, stickers and use inline bots",
        name: :can_send_other_messages,
        optional: true,
        type: :boolean
      },
      %{
        description:
          "Optional. True, if the user is allowed to add web page previews to their messages",
        name: :can_add_web_page_previews,
        optional: true,
        type: :boolean
      },
      %{
        description:
          "Optional. True, if the user is allowed to change the chat title, photo and other settings. Ignored in public supergroups",
        name: :can_change_info,
        optional: true,
        type: :boolean
      },
      %{
        description: "Optional. True, if the user is allowed to invite new users to the chat",
        name: :can_invite_users,
        optional: true,
        type: :boolean
      },
      %{
        description:
          "Optional. True, if the user is allowed to pin messages. Ignored in public supergroups",
        name: :can_pin_messages,
        optional: true,
        type: :boolean
      },
      %{
        description:
          "Optional. True, if the user is allowed to create forum topics. If omitted defaults to the value of can_pin_messages",
        name: :can_manage_topics,
        optional: true,
        type: :boolean
      }
    ]
  )

  deftype(Birthdate, "Describes the birthdate of a user.", [
    %{description: "Day of the user's birth; 1-31", name: :day, optional: false, type: :integer},
    %{
      description: "Month of the user's birth; 1-12",
      name: :month,
      optional: false,
      type: :integer
    },
    %{
      description: "Optional. Year of the user's birth",
      name: :year,
      optional: true,
      type: :integer
    }
  ])

  deftype(
    BusinessIntro,
    "Contains information about the start page settings of a Telegram Business account.",
    [
      %{
        description: "Optional. Title text of the business intro",
        name: :title,
        optional: true,
        type: :string
      },
      %{
        description: "Optional. Message text of the business intro",
        name: :message,
        optional: true,
        type: :string
      },
      %{
        description: "Optional. Sticker of the business intro",
        name: :sticker,
        optional: true,
        type: Telegex.Type.Sticker
      }
    ]
  )

  deftype(
    BusinessLocation,
    "Contains information about the location of a Telegram Business account.",
    [
      %{description: "Address of the business", name: :address, optional: false, type: :string},
      %{
        description: "Optional. Location of the business",
        name: :location,
        optional: true,
        type: Telegex.Type.Location
      }
    ]
  )

  deftype(
    BusinessOpeningHoursInterval,
    "Describes an interval of time during which a business is open.",
    [
      %{
        description:
          "The minute's sequence number in a week, starting on Monday, marking the start of the time interval during which the business is open; 0 - 7 * 24 * 60",
        name: :opening_minute,
        optional: false,
        type: :integer
      },
      %{
        description:
          "The minute's sequence number in a week, starting on Monday, marking the end of the time interval during which the business is open; 0 - 8 * 24 * 60",
        name: :closing_minute,
        optional: false,
        type: :integer
      }
    ]
  )

  deftype(BusinessOpeningHours, "Describes the opening hours of a business.", [
    %{
      description: "Unique name of the time zone for which the opening hours are defined",
      name: :time_zone_name,
      optional: false,
      type: :string
    },
    %{
      description: "List of time intervals describing business opening hours",
      name: :opening_hours,
      optional: false,
      type: %{
        __struct__: Telegex.TypeDefiner.ArrayType,
        elem_type: Telegex.Type.BusinessOpeningHoursInterval
      }
    }
  ])

  deftype(ChatLocation, "Represents a location to which a chat is connected.", [
    %{
      description: "The location to which the supergroup is connected. Can't be a live location.",
      name: :location,
      optional: false,
      type: Telegex.Type.Location
    },
    %{
      description: "Location address; 1-64 characters, as defined by the chat owner",
      name: :address,
      optional: false,
      type: :string
    }
  ])

  deftype(ReactionTypeEmoji, "The reaction is based on an emoji.", [
    %{
      description: "Type of the reaction, always “emoji”",
      name: :type,
      optional: false,
      type: :string
    },
    %{
      description:
        "Reaction emoji. Currently, it can be one of \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\"",
      name: :emoji,
      optional: false,
      type: :string
    }
  ])

  deftype(ReactionTypeCustomEmoji, "The reaction is based on a custom emoji.", [
    %{
      description: "Type of the reaction, always “custom_emoji”",
      name: :type,
      optional: false,
      type: :string
    },
    %{
      description: "Custom emoji identifier",
      name: :custom_emoji_id,
      optional: false,
      type: :string
    }
  ])

  deftype(ReactionTypePaid, "The reaction is paid.", [
    %{
      description: "Type of the reaction, always “paid”",
      name: :type,
      optional: false,
      type: :string
    }
  ])

  deftype(
    ReactionCount,
    "Represents a reaction added to a message along with the number of times it was added.",
    [
      %{
        description: "Type of the reaction",
        name: :type,
        optional: false,
        type: Telegex.Type.ReactionType
      },
      %{
        description: "Number of times the reaction was added",
        name: :total_count,
        optional: false,
        type: :integer
      }
    ]
  )

  deftype(
    MessageReactionUpdated,
    "This object represents a change of a reaction on a message performed by a user.",
    [
      %{
        description: "The chat containing the message the user reacted to",
        name: :chat,
        optional: false,
        type: Telegex.Type.Chat
      },
      %{
        description: "Unique identifier of the message inside the chat",
        name: :message_id,
        optional: false,
        type: :integer
      },
      %{
        description: "Optional. The user that changed the reaction, if the user isn't anonymous",
        name: :user,
        optional: true,
        type: Telegex.Type.User
      },
      %{
        description:
          "Optional. The chat on behalf of which the reaction was changed, if the user is anonymous",
        name: :actor_chat,
        optional: true,
        type: Telegex.Type.Chat
      },
      %{
        description: "Date of the change in Unix time",
        name: :date,
        optional: false,
        type: :integer
      },
      %{
        description: "Previous list of reaction types that were set by the user",
        name: :old_reaction,
        optional: false,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.ReactionType}
      },
      %{
        description: "New list of reaction types that have been set by the user",
        name: :new_reaction,
        optional: false,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.ReactionType}
      }
    ]
  )

  deftype(
    MessageReactionCountUpdated,
    "This object represents reaction changes on a message with anonymous reactions.",
    [
      %{
        description: "The chat containing the message",
        name: :chat,
        optional: false,
        type: Telegex.Type.Chat
      },
      %{
        description: "Unique message identifier inside the chat",
        name: :message_id,
        optional: false,
        type: :integer
      },
      %{
        description: "Date of the change in Unix time",
        name: :date,
        optional: false,
        type: :integer
      },
      %{
        description: "List of reactions that are present on the message",
        name: :reactions,
        optional: false,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.ReactionCount}
      }
    ]
  )

  deftype(ForumTopic, "This object represents a forum topic.", [
    %{
      description: "Unique identifier of the forum topic",
      name: :message_thread_id,
      optional: false,
      type: :integer
    },
    %{description: "Name of the topic", name: :name, optional: false, type: :string},
    %{
      description: "Color of the topic icon in RGB format",
      name: :icon_color,
      optional: false,
      type: :integer
    },
    %{
      description: "Optional. Unique identifier of the custom emoji shown as the topic icon",
      name: :icon_custom_emoji_id,
      optional: true,
      type: :string
    }
  ])

  deftype(BotCommand, "This object represents a bot command.", [
    %{
      description:
        "Text of the command; 1-32 characters. Can contain only lowercase English letters, digits and underscores.",
      name: :command,
      optional: false,
      type: :string
    },
    %{
      description: "Description of the command; 1-256 characters.",
      name: :description,
      optional: false,
      type: :string
    }
  ])

  deftype(
    BotCommandScopeDefault,
    "Represents the default scope of bot commands. Default commands are used if no commands with a narrower scope are specified for the user.",
    [%{description: "Scope type, must be default", name: :type, optional: false, type: :string}]
  )

  deftype(
    BotCommandScopeAllPrivateChats,
    "Represents the scope of bot commands, covering all private chats.",
    [
      %{
        description: "Scope type, must be all_private_chats",
        name: :type,
        optional: false,
        type: :string
      }
    ]
  )

  deftype(
    BotCommandScopeAllGroupChats,
    "Represents the scope of bot commands, covering all group and supergroup chats.",
    [
      %{
        description: "Scope type, must be all_group_chats",
        name: :type,
        optional: false,
        type: :string
      }
    ]
  )

  deftype(
    BotCommandScopeAllChatAdministrators,
    "Represents the scope of bot commands, covering all group and supergroup chat administrators.",
    [
      %{
        description: "Scope type, must be all_chat_administrators",
        name: :type,
        optional: false,
        type: :string
      }
    ]
  )

  deftype(
    BotCommandScopeChat,
    "Represents the scope of bot commands, covering a specific chat.",
    [
      %{description: "Scope type, must be chat", name: :type, optional: false, type: :string},
      %{
        description:
          "Unique identifier for the target chat or username of the target supergroup (in the format @supergroupusername)",
        name: :chat_id,
        optional: false,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      }
    ]
  )

  deftype(
    BotCommandScopeChatAdministrators,
    "Represents the scope of bot commands, covering all administrators of a specific group or supergroup chat.",
    [
      %{
        description: "Scope type, must be chat_administrators",
        name: :type,
        optional: false,
        type: :string
      },
      %{
        description:
          "Unique identifier for the target chat or username of the target supergroup (in the format @supergroupusername)",
        name: :chat_id,
        optional: false,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      }
    ]
  )

  deftype(
    BotCommandScopeChatMember,
    "Represents the scope of bot commands, covering a specific member of a group or supergroup chat.",
    [
      %{
        description: "Scope type, must be chat_member",
        name: :type,
        optional: false,
        type: :string
      },
      %{
        description:
          "Unique identifier for the target chat or username of the target supergroup (in the format @supergroupusername)",
        name: :chat_id,
        optional: false,
        type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [:integer, :string]}
      },
      %{
        description: "Unique identifier of the target user",
        name: :user_id,
        optional: false,
        type: :integer
      }
    ]
  )

  deftype(BotName, "This object represents the bot's name.", [
    %{description: "The bot's name", name: :name, optional: false, type: :string}
  ])

  deftype(BotDescription, "This object represents the bot's description.", [
    %{description: "The bot's description", name: :description, optional: false, type: :string}
  ])

  deftype(BotShortDescription, "This object represents the bot's short description.", [
    %{
      description: "The bot's short description",
      name: :short_description,
      optional: false,
      type: :string
    }
  ])

  deftype(
    MenuButtonCommands,
    "Represents a menu button, which opens the bot's list of commands.",
    [
      %{
        description: "Type of the button, must be commands",
        name: :type,
        optional: false,
        type: :string
      }
    ]
  )

  deftype(MenuButtonWebApp, "Represents a menu button, which launches a Web App.", [
    %{
      description: "Type of the button, must be web_app",
      name: :type,
      optional: false,
      type: :string
    },
    %{description: "Text on the button", name: :text, optional: false, type: :string},
    %{
      description:
        "Description of the Web App that will be launched when the user presses the button. The Web App will be able to send an arbitrary message on behalf of the user using the method answerWebAppQuery. Alternatively, a t.me link to a Web App of the bot can be specified in the object instead of the Web App's URL, in which case the Web App will be opened as if the user pressed the link.",
      name: :web_app,
      optional: false,
      type: Telegex.Type.WebAppInfo
    }
  ])

  deftype(MenuButtonDefault, "Describes that no specific value for the menu button was set.", [
    %{
      description: "Type of the button, must be default",
      name: :type,
      optional: false,
      type: :string
    }
  ])

  deftype(
    ChatBoostSourcePremium,
    "The boost was obtained by subscribing to Telegram Premium or by gifting a Telegram Premium subscription to another user.",
    [
      %{
        description: "Source of the boost, always “premium”",
        name: :source,
        optional: false,
        type: :string
      },
      %{
        description: "User that boosted the chat",
        name: :user,
        optional: false,
        type: Telegex.Type.User
      }
    ]
  )

  deftype(
    ChatBoostSourceGiftCode,
    "The boost was obtained by the creation of Telegram Premium gift codes to boost a chat. Each such code boosts the chat 4 times for the duration of the corresponding Telegram Premium subscription.",
    [
      %{
        description: "Source of the boost, always “gift_code”",
        name: :source,
        optional: false,
        type: :string
      },
      %{
        description: "User for which the gift code was created",
        name: :user,
        optional: false,
        type: Telegex.Type.User
      }
    ]
  )

  deftype(
    ChatBoostSourceGiveaway,
    "The boost was obtained by the creation of a Telegram Premium or a Telegram Star giveaway. This boosts the chat 4 times for the duration of the corresponding Telegram Premium subscription for Telegram Premium giveaways and prize_star_count / 500 times for one year for Telegram Star giveaways.",
    [
      %{
        description: "Source of the boost, always “giveaway”",
        name: :source,
        optional: false,
        type: :string
      },
      %{
        description:
          "Identifier of a message in the chat with the giveaway; the message could have been deleted already. May be 0 if the message isn't sent yet.",
        name: :giveaway_message_id,
        optional: false,
        type: :integer
      },
      %{
        description:
          "Optional. User that won the prize in the giveaway if any; for Telegram Premium giveaways only",
        name: :user,
        optional: true,
        type: Telegex.Type.User
      },
      %{
        description:
          "Optional. The number of Telegram Stars to be split between giveaway winners; for Telegram Star giveaways only",
        name: :prize_star_count,
        optional: true,
        type: :integer
      },
      %{
        description:
          "Optional. True, if the giveaway was completed, but there was no user to win the prize",
        name: :is_unclaimed,
        optional: true,
        type: :boolean
      }
    ]
  )

  deftype(ChatBoost, "This object contains information about a chat boost.", [
    %{
      description: "Unique identifier of the boost",
      name: :boost_id,
      optional: false,
      type: :string
    },
    %{
      description: "Point in time (Unix timestamp) when the chat was boosted",
      name: :add_date,
      optional: false,
      type: :integer
    },
    %{
      description:
        "Point in time (Unix timestamp) when the boost will automatically expire, unless the booster's Telegram Premium subscription is prolonged",
      name: :expiration_date,
      optional: false,
      type: :integer
    },
    %{
      description: "Source of the added boost",
      name: :source,
      optional: false,
      type: Telegex.Type.ChatBoostSource
    }
  ])

  deftype(ChatBoostUpdated, "This object represents a boost added to a chat or changed.", [
    %{
      description: "Chat which was boosted",
      name: :chat,
      optional: false,
      type: Telegex.Type.Chat
    },
    %{
      description: "Information about the chat boost",
      name: :boost,
      optional: false,
      type: Telegex.Type.ChatBoost
    }
  ])

  deftype(ChatBoostRemoved, "This object represents a boost removed from a chat.", [
    %{
      description: "Chat which was boosted",
      name: :chat,
      optional: false,
      type: Telegex.Type.Chat
    },
    %{
      description: "Unique identifier of the boost",
      name: :boost_id,
      optional: false,
      type: :string
    },
    %{
      description: "Point in time (Unix timestamp) when the boost was removed",
      name: :remove_date,
      optional: false,
      type: :integer
    },
    %{
      description: "Source of the removed boost",
      name: :source,
      optional: false,
      type: Telegex.Type.ChatBoostSource
    }
  ])

  deftype(UserChatBoosts, "This object represents a list of boosts added to a chat by a user.", [
    %{
      description: "The list of boosts added to the chat by the user",
      name: :boosts,
      optional: false,
      type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.ChatBoost}
    }
  ])

  deftype(BusinessConnection, "Describes the connection of the bot with a business account.", [
    %{
      description: "Unique identifier of the business connection",
      name: :id,
      optional: false,
      type: :string
    },
    %{
      description: "Business account user that created the business connection",
      name: :user,
      optional: false,
      type: Telegex.Type.User
    },
    %{
      description:
        "Identifier of a private chat with the user who created the business connection. This number may have more than 32 significant bits and some programming languages may have difficulty/silent defects in interpreting it. But it has at most 52 significant bits, so a 64-bit integer or double-precision float type are safe for storing this identifier.",
      name: :user_chat_id,
      optional: false,
      type: :integer
    },
    %{
      description: "Date the connection was established in Unix time",
      name: :date,
      optional: false,
      type: :integer
    },
    %{
      description:
        "True, if the bot can act on behalf of the business account in chats that were active in the last 24 hours",
      name: :can_reply,
      optional: false,
      type: :boolean
    },
    %{
      description: "True, if the connection is active",
      name: :is_enabled,
      optional: false,
      type: :boolean
    }
  ])

  deftype(
    BusinessMessagesDeleted,
    "This object is received when messages are deleted from a connected business account.",
    [
      %{
        description: "Unique identifier of the business connection",
        name: :business_connection_id,
        optional: false,
        type: :string
      },
      %{
        description:
          "Information about a chat in the business account. The bot may not have access to the chat or the corresponding user.",
        name: :chat,
        optional: false,
        type: Telegex.Type.Chat
      },
      %{
        description:
          "The list of identifiers of deleted messages in the chat of the business account",
        name: :message_ids,
        optional: false,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: :integer}
      }
    ]
  )

  deftype(ResponseParameters, "Describes why a request was unsuccessful.", [
    %{
      description:
        "Optional. The group has been migrated to a supergroup with the specified identifier. This number may have more than 32 significant bits and some programming languages may have difficulty/silent defects in interpreting it. But it has at most 52 significant bits, so a signed 64-bit integer or double-precision float type are safe for storing this identifier.",
      name: :migrate_to_chat_id,
      optional: true,
      type: :integer
    },
    %{
      description:
        "Optional. In case of exceeding flood control, the number of seconds left to wait before the request can be repeated",
      name: :retry_after,
      optional: true,
      type: :integer
    }
  ])

  deftype(InputMediaPhoto, "Represents a photo to be sent.", [
    %{
      description: "Type of the result, must be photo",
      name: :type,
      optional: false,
      type: :string
    },
    %{
      description:
        "File to send. Pass a file_id to send a file that exists on the Telegram servers (recommended), pass an HTTP URL for Telegram to get a file from the Internet, or pass “attach://<file_attach_name>” to upload a new one using multipart/form-data under <file_attach_name> name. More information on Sending Files »",
      name: :media,
      optional: false,
      type: :string
    },
    %{
      description:
        "Optional. Caption of the photo to be sent, 0-1024 characters after entities parsing",
      name: :caption,
      optional: true,
      type: :string
    },
    %{
      description:
        "Optional. Mode for parsing entities in the photo caption. See formatting options for more details.",
      name: :parse_mode,
      optional: true,
      type: :string
    },
    %{
      description:
        "Optional. List of special entities that appear in the caption, which can be specified instead of parse_mode",
      name: :caption_entities,
      optional: true,
      type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity}
    },
    %{
      description: "Optional. Pass True, if the caption must be shown above the message media",
      name: :show_caption_above_media,
      optional: true,
      type: :boolean
    },
    %{
      description:
        "Optional. Pass True if the photo needs to be covered with a spoiler animation",
      name: :has_spoiler,
      optional: true,
      type: :boolean
    }
  ])

  deftype(InputMediaVideo, "Represents a video to be sent.", [
    %{
      description: "Type of the result, must be video",
      name: :type,
      optional: false,
      type: :string
    },
    %{
      description:
        "File to send. Pass a file_id to send a file that exists on the Telegram servers (recommended), pass an HTTP URL for Telegram to get a file from the Internet, or pass “attach://<file_attach_name>” to upload a new one using multipart/form-data under <file_attach_name> name. More information on Sending Files »",
      name: :media,
      optional: false,
      type: :string
    },
    %{
      description:
        "Optional. Thumbnail of the file sent; can be ignored if thumbnail generation for the file is supported server-side. The thumbnail should be in JPEG format and less than 200 kB in size. A thumbnail's width and height should not exceed 320. Ignored if the file is not uploaded using multipart/form-data. Thumbnails can't be reused and can be only uploaded as a new file, so you can pass “attach://<file_attach_name>” if the thumbnail was uploaded using multipart/form-data under <file_attach_name>. More information on Sending Files »",
      name: :thumbnail,
      optional: true,
      type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [Telegex.Type.InputFile, :string]}
    },
    %{
      description:
        "Optional. Caption of the video to be sent, 0-1024 characters after entities parsing",
      name: :caption,
      optional: true,
      type: :string
    },
    %{
      description:
        "Optional. Mode for parsing entities in the video caption. See formatting options for more details.",
      name: :parse_mode,
      optional: true,
      type: :string
    },
    %{
      description:
        "Optional. List of special entities that appear in the caption, which can be specified instead of parse_mode",
      name: :caption_entities,
      optional: true,
      type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity}
    },
    %{
      description: "Optional. Pass True, if the caption must be shown above the message media",
      name: :show_caption_above_media,
      optional: true,
      type: :boolean
    },
    %{description: "Optional. Video width", name: :width, optional: true, type: :integer},
    %{description: "Optional. Video height", name: :height, optional: true, type: :integer},
    %{
      description: "Optional. Video duration in seconds",
      name: :duration,
      optional: true,
      type: :integer
    },
    %{
      description: "Optional. Pass True if the uploaded video is suitable for streaming",
      name: :supports_streaming,
      optional: true,
      type: :boolean
    },
    %{
      description:
        "Optional. Pass True if the video needs to be covered with a spoiler animation",
      name: :has_spoiler,
      optional: true,
      type: :boolean
    }
  ])

  deftype(
    InputMediaAnimation,
    "Represents an animation file (GIF or H.264/MPEG-4 AVC video without sound) to be sent.",
    [
      %{
        description: "Type of the result, must be animation",
        name: :type,
        optional: false,
        type: :string
      },
      %{
        description:
          "File to send. Pass a file_id to send a file that exists on the Telegram servers (recommended), pass an HTTP URL for Telegram to get a file from the Internet, or pass “attach://<file_attach_name>” to upload a new one using multipart/form-data under <file_attach_name> name. More information on Sending Files »",
        name: :media,
        optional: false,
        type: :string
      },
      %{
        description:
          "Optional. Thumbnail of the file sent; can be ignored if thumbnail generation for the file is supported server-side. The thumbnail should be in JPEG format and less than 200 kB in size. A thumbnail's width and height should not exceed 320. Ignored if the file is not uploaded using multipart/form-data. Thumbnails can't be reused and can be only uploaded as a new file, so you can pass “attach://<file_attach_name>” if the thumbnail was uploaded using multipart/form-data under <file_attach_name>. More information on Sending Files »",
        name: :thumbnail,
        optional: true,
        type: %{
          __struct__: Telegex.TypeDefiner.UnionType,
          types: [Telegex.Type.InputFile, :string]
        }
      },
      %{
        description:
          "Optional. Caption of the animation to be sent, 0-1024 characters after entities parsing",
        name: :caption,
        optional: true,
        type: :string
      },
      %{
        description:
          "Optional. Mode for parsing entities in the animation caption. See formatting options for more details.",
        name: :parse_mode,
        optional: true,
        type: :string
      },
      %{
        description:
          "Optional. List of special entities that appear in the caption, which can be specified instead of parse_mode",
        name: :caption_entities,
        optional: true,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity}
      },
      %{
        description: "Optional. Pass True, if the caption must be shown above the message media",
        name: :show_caption_above_media,
        optional: true,
        type: :boolean
      },
      %{description: "Optional. Animation width", name: :width, optional: true, type: :integer},
      %{description: "Optional. Animation height", name: :height, optional: true, type: :integer},
      %{
        description: "Optional. Animation duration in seconds",
        name: :duration,
        optional: true,
        type: :integer
      },
      %{
        description:
          "Optional. Pass True if the animation needs to be covered with a spoiler animation",
        name: :has_spoiler,
        optional: true,
        type: :boolean
      }
    ]
  )

  deftype(InputMediaAudio, "Represents an audio file to be treated as music to be sent.", [
    %{
      description: "Type of the result, must be audio",
      name: :type,
      optional: false,
      type: :string
    },
    %{
      description:
        "File to send. Pass a file_id to send a file that exists on the Telegram servers (recommended), pass an HTTP URL for Telegram to get a file from the Internet, or pass “attach://<file_attach_name>” to upload a new one using multipart/form-data under <file_attach_name> name. More information on Sending Files »",
      name: :media,
      optional: false,
      type: :string
    },
    %{
      description:
        "Optional. Thumbnail of the file sent; can be ignored if thumbnail generation for the file is supported server-side. The thumbnail should be in JPEG format and less than 200 kB in size. A thumbnail's width and height should not exceed 320. Ignored if the file is not uploaded using multipart/form-data. Thumbnails can't be reused and can be only uploaded as a new file, so you can pass “attach://<file_attach_name>” if the thumbnail was uploaded using multipart/form-data under <file_attach_name>. More information on Sending Files »",
      name: :thumbnail,
      optional: true,
      type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [Telegex.Type.InputFile, :string]}
    },
    %{
      description:
        "Optional. Caption of the audio to be sent, 0-1024 characters after entities parsing",
      name: :caption,
      optional: true,
      type: :string
    },
    %{
      description:
        "Optional. Mode for parsing entities in the audio caption. See formatting options for more details.",
      name: :parse_mode,
      optional: true,
      type: :string
    },
    %{
      description:
        "Optional. List of special entities that appear in the caption, which can be specified instead of parse_mode",
      name: :caption_entities,
      optional: true,
      type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity}
    },
    %{
      description: "Optional. Duration of the audio in seconds",
      name: :duration,
      optional: true,
      type: :integer
    },
    %{
      description: "Optional. Performer of the audio",
      name: :performer,
      optional: true,
      type: :string
    },
    %{description: "Optional. Title of the audio", name: :title, optional: true, type: :string}
  ])

  deftype(InputMediaDocument, "Represents a general file to be sent.", [
    %{
      description: "Type of the result, must be document",
      name: :type,
      optional: false,
      type: :string
    },
    %{
      description:
        "File to send. Pass a file_id to send a file that exists on the Telegram servers (recommended), pass an HTTP URL for Telegram to get a file from the Internet, or pass “attach://<file_attach_name>” to upload a new one using multipart/form-data under <file_attach_name> name. More information on Sending Files »",
      name: :media,
      optional: false,
      type: :string
    },
    %{
      description:
        "Optional. Thumbnail of the file sent; can be ignored if thumbnail generation for the file is supported server-side. The thumbnail should be in JPEG format and less than 200 kB in size. A thumbnail's width and height should not exceed 320. Ignored if the file is not uploaded using multipart/form-data. Thumbnails can't be reused and can be only uploaded as a new file, so you can pass “attach://<file_attach_name>” if the thumbnail was uploaded using multipart/form-data under <file_attach_name>. More information on Sending Files »",
      name: :thumbnail,
      optional: true,
      type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [Telegex.Type.InputFile, :string]}
    },
    %{
      description:
        "Optional. Caption of the document to be sent, 0-1024 characters after entities parsing",
      name: :caption,
      optional: true,
      type: :string
    },
    %{
      description:
        "Optional. Mode for parsing entities in the document caption. See formatting options for more details.",
      name: :parse_mode,
      optional: true,
      type: :string
    },
    %{
      description:
        "Optional. List of special entities that appear in the caption, which can be specified instead of parse_mode",
      name: :caption_entities,
      optional: true,
      type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity}
    },
    %{
      description:
        "Optional. Disables automatic server-side content type detection for files uploaded using multipart/form-data. Always True, if the document is sent as part of an album.",
      name: :disable_content_type_detection,
      optional: true,
      type: :boolean
    }
  ])

  deftype(
    InputFile,
    "This object represents the contents of a file to be uploaded. Must be posted using multipart/form-data in the usual way that files are uploaded via the browser.",
    []
  )

  deftype(InputPaidMediaPhoto, "The paid media to send is a photo.", [
    %{
      description: "Type of the media, must be photo",
      name: :type,
      optional: false,
      type: :string
    },
    %{
      description:
        "File to send. Pass a file_id to send a file that exists on the Telegram servers (recommended), pass an HTTP URL for Telegram to get a file from the Internet, or pass “attach://<file_attach_name>” to upload a new one using multipart/form-data under <file_attach_name> name. More information on Sending Files »",
      name: :media,
      optional: false,
      type: :string
    }
  ])

  deftype(InputPaidMediaVideo, "The paid media to send is a video.", [
    %{
      description: "Type of the media, must be video",
      name: :type,
      optional: false,
      type: :string
    },
    %{
      description:
        "File to send. Pass a file_id to send a file that exists on the Telegram servers (recommended), pass an HTTP URL for Telegram to get a file from the Internet, or pass “attach://<file_attach_name>” to upload a new one using multipart/form-data under <file_attach_name> name. More information on Sending Files »",
      name: :media,
      optional: false,
      type: :string
    },
    %{
      description:
        "Optional. Thumbnail of the file sent; can be ignored if thumbnail generation for the file is supported server-side. The thumbnail should be in JPEG format and less than 200 kB in size. A thumbnail's width and height should not exceed 320. Ignored if the file is not uploaded using multipart/form-data. Thumbnails can't be reused and can be only uploaded as a new file, so you can pass “attach://<file_attach_name>” if the thumbnail was uploaded using multipart/form-data under <file_attach_name>. More information on Sending Files »",
      name: :thumbnail,
      optional: true,
      type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [Telegex.Type.InputFile, :string]}
    },
    %{description: "Optional. Video width", name: :width, optional: true, type: :integer},
    %{description: "Optional. Video height", name: :height, optional: true, type: :integer},
    %{
      description: "Optional. Video duration in seconds",
      name: :duration,
      optional: true,
      type: :integer
    },
    %{
      description: "Optional. Pass True if the uploaded video is suitable for streaming",
      name: :supports_streaming,
      optional: true,
      type: :boolean
    }
  ])

  deftype(Sticker, "This object represents a sticker.", [
    %{
      description: "Identifier for this file, which can be used to download or reuse the file",
      name: :file_id,
      optional: false,
      type: :string
    },
    %{
      description:
        "Unique identifier for this file, which is supposed to be the same over time and for different bots. Can't be used to download or reuse the file.",
      name: :file_unique_id,
      optional: false,
      type: :string
    },
    %{
      description:
        "Type of the sticker, currently one of “regular”, “mask”, “custom_emoji”. The type of the sticker is independent from its format, which is determined by the fields is_animated and is_video.",
      name: :type,
      optional: false,
      type: :string
    },
    %{description: "Sticker width", name: :width, optional: false, type: :integer},
    %{description: "Sticker height", name: :height, optional: false, type: :integer},
    %{
      description: "True, if the sticker is animated",
      name: :is_animated,
      optional: false,
      type: :boolean
    },
    %{
      description: "True, if the sticker is a video sticker",
      name: :is_video,
      optional: false,
      type: :boolean
    },
    %{
      description: "Optional. Sticker thumbnail in the .WEBP or .JPG format",
      name: :thumbnail,
      optional: true,
      type: Telegex.Type.PhotoSize
    },
    %{
      description: "Optional. Emoji associated with the sticker",
      name: :emoji,
      optional: true,
      type: :string
    },
    %{
      description: "Optional. Name of the sticker set to which the sticker belongs",
      name: :set_name,
      optional: true,
      type: :string
    },
    %{
      description: "Optional. For premium regular stickers, premium animation for the sticker",
      name: :premium_animation,
      optional: true,
      type: Telegex.Type.File
    },
    %{
      description: "Optional. For mask stickers, the position where the mask should be placed",
      name: :mask_position,
      optional: true,
      type: Telegex.Type.MaskPosition
    },
    %{
      description: "Optional. For custom emoji stickers, unique identifier of the custom emoji",
      name: :custom_emoji_id,
      optional: true,
      type: :string
    },
    %{
      description:
        "Optional. True, if the sticker must be repainted to a text color in messages, the color of the Telegram Premium badge in emoji status, white color on chat photos, or another appropriate color in other places",
      name: :needs_repainting,
      optional: true,
      type: :boolean
    },
    %{
      description: "Optional. File size in bytes",
      name: :file_size,
      optional: true,
      type: :integer
    }
  ])

  deftype(StickerSet, "This object represents a sticker set.", [
    %{description: "Sticker set name", name: :name, optional: false, type: :string},
    %{description: "Sticker set title", name: :title, optional: false, type: :string},
    %{
      description:
        "Type of stickers in the set, currently one of “regular”, “mask”, “custom_emoji”",
      name: :sticker_type,
      optional: false,
      type: :string
    },
    %{
      description: "List of all set stickers",
      name: :stickers,
      optional: false,
      type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.Sticker}
    },
    %{
      description: "Optional. Sticker set thumbnail in the .WEBP, .TGS, or .WEBM format",
      name: :thumbnail,
      optional: true,
      type: Telegex.Type.PhotoSize
    }
  ])

  deftype(
    MaskPosition,
    "This object describes the position on faces where a mask should be placed by default.",
    [
      %{
        description:
          "The part of the face relative to which the mask should be placed. One of “forehead”, “eyes”, “mouth”, or “chin”.",
        name: :point,
        optional: false,
        type: :string
      },
      %{
        description:
          "Shift by X-axis measured in widths of the mask scaled to the face size, from left to right. For example, choosing -1.0 will place mask just to the left of the default mask position.",
        name: :x_shift,
        optional: false,
        type: :float
      },
      %{
        description:
          "Shift by Y-axis measured in heights of the mask scaled to the face size, from top to bottom. For example, 1.0 will place the mask just below the default mask position.",
        name: :y_shift,
        optional: false,
        type: :float
      },
      %{
        description: "Mask scaling coefficient. For example, 2.0 means double size.",
        name: :scale,
        optional: false,
        type: :float
      }
    ]
  )

  deftype(InputSticker, "This object describes a sticker to be added to a sticker set.", [
    %{
      description:
        "The added sticker. Pass a file_id as a String to send a file that already exists on the Telegram servers, pass an HTTP URL as a String for Telegram to get a file from the Internet, upload a new one using multipart/form-data, or pass “attach://<file_attach_name>” to upload a new one using multipart/form-data under <file_attach_name> name. Animated and video stickers can't be uploaded via HTTP URL. More information on Sending Files »",
      name: :sticker,
      optional: false,
      type: %{__struct__: Telegex.TypeDefiner.UnionType, types: [Telegex.Type.InputFile, :string]}
    },
    %{
      description:
        "Format of the added sticker, must be one of “static” for a .WEBP or .PNG image, “animated” for a .TGS animation, “video” for a WEBM video",
      name: :format,
      optional: false,
      type: :string
    },
    %{
      description: "List of 1-20 emoji associated with the sticker",
      name: :emoji_list,
      optional: false,
      type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: :string}
    },
    %{
      description:
        "Optional. Position where the mask should be placed on faces. For “mask” stickers only.",
      name: :mask_position,
      optional: true,
      type: Telegex.Type.MaskPosition
    },
    %{
      description:
        "Optional. List of 0-20 search keywords for the sticker with total length of up to 64 characters. For “regular” and “custom_emoji” stickers only.",
      name: :keywords,
      optional: true,
      type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: :string}
    }
  ])

  deftype(
    InlineQuery,
    "This object represents an incoming inline query. When the user sends an empty query, your bot could return some default or trending results.",
    [
      %{
        description: "Unique identifier for this query",
        name: :id,
        optional: false,
        type: :string
      },
      %{description: "Sender", name: :from, optional: false, type: Telegex.Type.User},
      %{
        description: "Text of the query (up to 256 characters)",
        name: :query,
        optional: false,
        type: :string
      },
      %{
        description: "Offset of the results to be returned, can be controlled by the bot",
        name: :offset,
        optional: false,
        type: :string
      },
      %{
        description:
          "Optional. Type of the chat from which the inline query was sent. Can be either “sender” for a private chat with the inline query sender, “private”, “group”, “supergroup”, or “channel”. The chat type should be always known for requests sent from official clients and most third-party clients, unless the request was sent from a secret chat",
        name: :chat_type,
        optional: true,
        type: :string
      },
      %{
        description: "Optional. Sender location, only for bots that request user location",
        name: :location,
        optional: true,
        type: Telegex.Type.Location
      }
    ]
  )

  deftype(
    InlineQueryResultsButton,
    "This object represents a button to be shown above inline query results. You must use exactly one of the optional fields.",
    [
      %{description: "Label text on the button", name: :text, optional: false, type: :string},
      %{
        description:
          "Optional. Description of the Web App that will be launched when the user presses the button. The Web App will be able to switch back to the inline mode using the method switchInlineQuery inside the Web App.",
        name: :web_app,
        optional: true,
        type: Telegex.Type.WebAppInfo
      },
      %{
        description:
          "Optional. Deep-linking parameter for the /start message sent to the bot when a user presses the button. 1-64 characters, only A-Z, a-z, 0-9, _ and - are allowed.\n\nExample: An inline bot that sends YouTube videos can ask the user to connect the bot to their YouTube account to adapt search results accordingly. To do this, it displays a 'Connect your YouTube account' button above the results, or even before showing any. The user presses the button, switches to a private chat with the bot and, in doing so, passes a start parameter that instructs the bot to return an OAuth link. Once done, the bot can offer a switch_inline button so that the user can easily return to the chat where they wanted to use the bot's inline capabilities.",
        name: :start_parameter,
        optional: true,
        type: :string
      }
    ]
  )

  deftype(InlineQueryResultArticle, "Represents a link to an article or web page.", [
    %{
      description: "Type of the result, must be article",
      name: :type,
      optional: false,
      type: :string
    },
    %{
      description: "Unique identifier for this result, 1-64 Bytes",
      name: :id,
      optional: false,
      type: :string
    },
    %{description: "Title of the result", name: :title, optional: false, type: :string},
    %{
      description: "Content of the message to be sent",
      name: :input_message_content,
      optional: false,
      type: Telegex.Type.InputMessageContent
    },
    %{
      description: "Optional. Inline keyboard attached to the message",
      name: :reply_markup,
      optional: true,
      type: Telegex.Type.InlineKeyboardMarkup
    },
    %{description: "Optional. URL of the result", name: :url, optional: true, type: :string},
    %{
      description: "Optional. Pass True if you don't want the URL to be shown in the message",
      name: :hide_url,
      optional: true,
      type: :boolean
    },
    %{
      description: "Optional. Short description of the result",
      name: :description,
      optional: true,
      type: :string
    },
    %{
      description: "Optional. Url of the thumbnail for the result",
      name: :thumbnail_url,
      optional: true,
      type: :string
    },
    %{
      description: "Optional. Thumbnail width",
      name: :thumbnail_width,
      optional: true,
      type: :integer
    },
    %{
      description: "Optional. Thumbnail height",
      name: :thumbnail_height,
      optional: true,
      type: :integer
    }
  ])

  deftype(
    InlineQueryResultPhoto,
    "Represents a link to a photo. By default, this photo will be sent by the user with optional caption. Alternatively, you can use input_message_content to send a message with the specified content instead of the photo.",
    [
      %{
        description: "Type of the result, must be photo",
        name: :type,
        optional: false,
        type: :string
      },
      %{
        description: "Unique identifier for this result, 1-64 bytes",
        name: :id,
        optional: false,
        type: :string
      },
      %{
        description:
          "A valid URL of the photo. Photo must be in JPEG format. Photo size must not exceed 5MB",
        name: :photo_url,
        optional: false,
        type: :string
      },
      %{
        description: "URL of the thumbnail for the photo",
        name: :thumbnail_url,
        optional: false,
        type: :string
      },
      %{
        description: "Optional. Width of the photo",
        name: :photo_width,
        optional: true,
        type: :integer
      },
      %{
        description: "Optional. Height of the photo",
        name: :photo_height,
        optional: true,
        type: :integer
      },
      %{
        description: "Optional. Title for the result",
        name: :title,
        optional: true,
        type: :string
      },
      %{
        description: "Optional. Short description of the result",
        name: :description,
        optional: true,
        type: :string
      },
      %{
        description:
          "Optional. Caption of the photo to be sent, 0-1024 characters after entities parsing",
        name: :caption,
        optional: true,
        type: :string
      },
      %{
        description:
          "Optional. Mode for parsing entities in the photo caption. See formatting options for more details.",
        name: :parse_mode,
        optional: true,
        type: :string
      },
      %{
        description:
          "Optional. List of special entities that appear in the caption, which can be specified instead of parse_mode",
        name: :caption_entities,
        optional: true,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity}
      },
      %{
        description: "Optional. Pass True, if the caption must be shown above the message media",
        name: :show_caption_above_media,
        optional: true,
        type: :boolean
      },
      %{
        description: "Optional. Inline keyboard attached to the message",
        name: :reply_markup,
        optional: true,
        type: Telegex.Type.InlineKeyboardMarkup
      },
      %{
        description: "Optional. Content of the message to be sent instead of the photo",
        name: :input_message_content,
        optional: true,
        type: Telegex.Type.InputMessageContent
      }
    ]
  )

  deftype(
    InlineQueryResultGif,
    "Represents a link to an animated GIF file. By default, this animated GIF file will be sent by the user with optional caption. Alternatively, you can use input_message_content to send a message with the specified content instead of the animation.",
    [
      %{
        description: "Type of the result, must be gif",
        name: :type,
        optional: false,
        type: :string
      },
      %{
        description: "Unique identifier for this result, 1-64 bytes",
        name: :id,
        optional: false,
        type: :string
      },
      %{
        description: "A valid URL for the GIF file. File size must not exceed 1MB",
        name: :gif_url,
        optional: false,
        type: :string
      },
      %{
        description: "Optional. Width of the GIF",
        name: :gif_width,
        optional: true,
        type: :integer
      },
      %{
        description: "Optional. Height of the GIF",
        name: :gif_height,
        optional: true,
        type: :integer
      },
      %{
        description: "Optional. Duration of the GIF in seconds",
        name: :gif_duration,
        optional: true,
        type: :integer
      },
      %{
        description:
          "URL of the static (JPEG or GIF) or animated (MPEG4) thumbnail for the result",
        name: :thumbnail_url,
        optional: false,
        type: :string
      },
      %{
        description:
          "Optional. MIME type of the thumbnail, must be one of “image/jpeg”, “image/gif”, or “video/mp4”. Defaults to “image/jpeg”",
        name: :thumbnail_mime_type,
        optional: true,
        type: :string
      },
      %{
        description: "Optional. Title for the result",
        name: :title,
        optional: true,
        type: :string
      },
      %{
        description:
          "Optional. Caption of the GIF file to be sent, 0-1024 characters after entities parsing",
        name: :caption,
        optional: true,
        type: :string
      },
      %{
        description:
          "Optional. Mode for parsing entities in the caption. See formatting options for more details.",
        name: :parse_mode,
        optional: true,
        type: :string
      },
      %{
        description:
          "Optional. List of special entities that appear in the caption, which can be specified instead of parse_mode",
        name: :caption_entities,
        optional: true,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity}
      },
      %{
        description: "Optional. Pass True, if the caption must be shown above the message media",
        name: :show_caption_above_media,
        optional: true,
        type: :boolean
      },
      %{
        description: "Optional. Inline keyboard attached to the message",
        name: :reply_markup,
        optional: true,
        type: Telegex.Type.InlineKeyboardMarkup
      },
      %{
        description: "Optional. Content of the message to be sent instead of the GIF animation",
        name: :input_message_content,
        optional: true,
        type: Telegex.Type.InputMessageContent
      }
    ]
  )

  deftype(
    InlineQueryResultMpeg4Gif,
    "Represents a link to a video animation (H.264/MPEG-4 AVC video without sound). By default, this animated MPEG-4 file will be sent by the user with optional caption. Alternatively, you can use input_message_content to send a message with the specified content instead of the animation.",
    [
      %{
        description: "Type of the result, must be mpeg4_gif",
        name: :type,
        optional: false,
        type: :string
      },
      %{
        description: "Unique identifier for this result, 1-64 bytes",
        name: :id,
        optional: false,
        type: :string
      },
      %{
        description: "A valid URL for the MPEG4 file. File size must not exceed 1MB",
        name: :mpeg4_url,
        optional: false,
        type: :string
      },
      %{description: "Optional. Video width", name: :mpeg4_width, optional: true, type: :integer},
      %{
        description: "Optional. Video height",
        name: :mpeg4_height,
        optional: true,
        type: :integer
      },
      %{
        description: "Optional. Video duration in seconds",
        name: :mpeg4_duration,
        optional: true,
        type: :integer
      },
      %{
        description:
          "URL of the static (JPEG or GIF) or animated (MPEG4) thumbnail for the result",
        name: :thumbnail_url,
        optional: false,
        type: :string
      },
      %{
        description:
          "Optional. MIME type of the thumbnail, must be one of “image/jpeg”, “image/gif”, or “video/mp4”. Defaults to “image/jpeg”",
        name: :thumbnail_mime_type,
        optional: true,
        type: :string
      },
      %{
        description: "Optional. Title for the result",
        name: :title,
        optional: true,
        type: :string
      },
      %{
        description:
          "Optional. Caption of the MPEG-4 file to be sent, 0-1024 characters after entities parsing",
        name: :caption,
        optional: true,
        type: :string
      },
      %{
        description:
          "Optional. Mode for parsing entities in the caption. See formatting options for more details.",
        name: :parse_mode,
        optional: true,
        type: :string
      },
      %{
        description:
          "Optional. List of special entities that appear in the caption, which can be specified instead of parse_mode",
        name: :caption_entities,
        optional: true,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity}
      },
      %{
        description: "Optional. Pass True, if the caption must be shown above the message media",
        name: :show_caption_above_media,
        optional: true,
        type: :boolean
      },
      %{
        description: "Optional. Inline keyboard attached to the message",
        name: :reply_markup,
        optional: true,
        type: Telegex.Type.InlineKeyboardMarkup
      },
      %{
        description: "Optional. Content of the message to be sent instead of the video animation",
        name: :input_message_content,
        optional: true,
        type: Telegex.Type.InputMessageContent
      }
    ]
  )

  deftype(
    InlineQueryResultVideo,
    "Represents a link to a page containing an embedded video player or a video file. By default, this video file will be sent by the user with an optional caption. Alternatively, you can use input_message_content to send a message with the specified content instead of the video.",
    [
      %{
        description: "Type of the result, must be video",
        name: :type,
        optional: false,
        type: :string
      },
      %{
        description: "Unique identifier for this result, 1-64 bytes",
        name: :id,
        optional: false,
        type: :string
      },
      %{
        description: "A valid URL for the embedded video player or video file",
        name: :video_url,
        optional: false,
        type: :string
      },
      %{
        description: "MIME type of the content of the video URL, “text/html” or “video/mp4”",
        name: :mime_type,
        optional: false,
        type: :string
      },
      %{
        description: "URL of the thumbnail (JPEG only) for the video",
        name: :thumbnail_url,
        optional: false,
        type: :string
      },
      %{description: "Title for the result", name: :title, optional: false, type: :string},
      %{
        description:
          "Optional. Caption of the video to be sent, 0-1024 characters after entities parsing",
        name: :caption,
        optional: true,
        type: :string
      },
      %{
        description:
          "Optional. Mode for parsing entities in the video caption. See formatting options for more details.",
        name: :parse_mode,
        optional: true,
        type: :string
      },
      %{
        description:
          "Optional. List of special entities that appear in the caption, which can be specified instead of parse_mode",
        name: :caption_entities,
        optional: true,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity}
      },
      %{
        description: "Optional. Pass True, if the caption must be shown above the message media",
        name: :show_caption_above_media,
        optional: true,
        type: :boolean
      },
      %{description: "Optional. Video width", name: :video_width, optional: true, type: :integer},
      %{
        description: "Optional. Video height",
        name: :video_height,
        optional: true,
        type: :integer
      },
      %{
        description: "Optional. Video duration in seconds",
        name: :video_duration,
        optional: true,
        type: :integer
      },
      %{
        description: "Optional. Short description of the result",
        name: :description,
        optional: true,
        type: :string
      },
      %{
        description: "Optional. Inline keyboard attached to the message",
        name: :reply_markup,
        optional: true,
        type: Telegex.Type.InlineKeyboardMarkup
      },
      %{
        description:
          "Optional. Content of the message to be sent instead of the video. This field is required if InlineQueryResultVideo is used to send an HTML-page as a result (e.g., a YouTube video).",
        name: :input_message_content,
        optional: true,
        type: Telegex.Type.InputMessageContent
      }
    ]
  )

  deftype(
    InlineQueryResultAudio,
    "Represents a link to an MP3 audio file. By default, this audio file will be sent by the user. Alternatively, you can use input_message_content to send a message with the specified content instead of the audio.",
    [
      %{
        description: "Type of the result, must be audio",
        name: :type,
        optional: false,
        type: :string
      },
      %{
        description: "Unique identifier for this result, 1-64 bytes",
        name: :id,
        optional: false,
        type: :string
      },
      %{
        description: "A valid URL for the audio file",
        name: :audio_url,
        optional: false,
        type: :string
      },
      %{description: "Title", name: :title, optional: false, type: :string},
      %{
        description: "Optional. Caption, 0-1024 characters after entities parsing",
        name: :caption,
        optional: true,
        type: :string
      },
      %{
        description:
          "Optional. Mode for parsing entities in the audio caption. See formatting options for more details.",
        name: :parse_mode,
        optional: true,
        type: :string
      },
      %{
        description:
          "Optional. List of special entities that appear in the caption, which can be specified instead of parse_mode",
        name: :caption_entities,
        optional: true,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity}
      },
      %{description: "Optional. Performer", name: :performer, optional: true, type: :string},
      %{
        description: "Optional. Audio duration in seconds",
        name: :audio_duration,
        optional: true,
        type: :integer
      },
      %{
        description: "Optional. Inline keyboard attached to the message",
        name: :reply_markup,
        optional: true,
        type: Telegex.Type.InlineKeyboardMarkup
      },
      %{
        description: "Optional. Content of the message to be sent instead of the audio",
        name: :input_message_content,
        optional: true,
        type: Telegex.Type.InputMessageContent
      }
    ]
  )

  deftype(
    InlineQueryResultVoice,
    "Represents a link to a voice recording in an .OGG container encoded with OPUS. By default, this voice recording will be sent by the user. Alternatively, you can use input_message_content to send a message with the specified content instead of the the voice message.",
    [
      %{
        description: "Type of the result, must be voice",
        name: :type,
        optional: false,
        type: :string
      },
      %{
        description: "Unique identifier for this result, 1-64 bytes",
        name: :id,
        optional: false,
        type: :string
      },
      %{
        description: "A valid URL for the voice recording",
        name: :voice_url,
        optional: false,
        type: :string
      },
      %{description: "Recording title", name: :title, optional: false, type: :string},
      %{
        description: "Optional. Caption, 0-1024 characters after entities parsing",
        name: :caption,
        optional: true,
        type: :string
      },
      %{
        description:
          "Optional. Mode for parsing entities in the voice message caption. See formatting options for more details.",
        name: :parse_mode,
        optional: true,
        type: :string
      },
      %{
        description:
          "Optional. List of special entities that appear in the caption, which can be specified instead of parse_mode",
        name: :caption_entities,
        optional: true,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity}
      },
      %{
        description: "Optional. Recording duration in seconds",
        name: :voice_duration,
        optional: true,
        type: :integer
      },
      %{
        description: "Optional. Inline keyboard attached to the message",
        name: :reply_markup,
        optional: true,
        type: Telegex.Type.InlineKeyboardMarkup
      },
      %{
        description: "Optional. Content of the message to be sent instead of the voice recording",
        name: :input_message_content,
        optional: true,
        type: Telegex.Type.InputMessageContent
      }
    ]
  )

  deftype(
    InlineQueryResultDocument,
    "Represents a link to a file. By default, this file will be sent by the user with an optional caption. Alternatively, you can use input_message_content to send a message with the specified content instead of the file. Currently, only .PDF and .ZIP files can be sent using this method.",
    [
      %{
        description: "Type of the result, must be document",
        name: :type,
        optional: false,
        type: :string
      },
      %{
        description: "Unique identifier for this result, 1-64 bytes",
        name: :id,
        optional: false,
        type: :string
      },
      %{description: "Title for the result", name: :title, optional: false, type: :string},
      %{
        description:
          "Optional. Caption of the document to be sent, 0-1024 characters after entities parsing",
        name: :caption,
        optional: true,
        type: :string
      },
      %{
        description:
          "Optional. Mode for parsing entities in the document caption. See formatting options for more details.",
        name: :parse_mode,
        optional: true,
        type: :string
      },
      %{
        description:
          "Optional. List of special entities that appear in the caption, which can be specified instead of parse_mode",
        name: :caption_entities,
        optional: true,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity}
      },
      %{
        description: "A valid URL for the file",
        name: :document_url,
        optional: false,
        type: :string
      },
      %{
        description:
          "MIME type of the content of the file, either “application/pdf” or “application/zip”",
        name: :mime_type,
        optional: false,
        type: :string
      },
      %{
        description: "Optional. Short description of the result",
        name: :description,
        optional: true,
        type: :string
      },
      %{
        description: "Optional. Inline keyboard attached to the message",
        name: :reply_markup,
        optional: true,
        type: Telegex.Type.InlineKeyboardMarkup
      },
      %{
        description: "Optional. Content of the message to be sent instead of the file",
        name: :input_message_content,
        optional: true,
        type: Telegex.Type.InputMessageContent
      },
      %{
        description: "Optional. URL of the thumbnail (JPEG only) for the file",
        name: :thumbnail_url,
        optional: true,
        type: :string
      },
      %{
        description: "Optional. Thumbnail width",
        name: :thumbnail_width,
        optional: true,
        type: :integer
      },
      %{
        description: "Optional. Thumbnail height",
        name: :thumbnail_height,
        optional: true,
        type: :integer
      }
    ]
  )

  deftype(
    InlineQueryResultLocation,
    "Represents a location on a map. By default, the location will be sent by the user. Alternatively, you can use input_message_content to send a message with the specified content instead of the location.",
    [
      %{
        description: "Type of the result, must be location",
        name: :type,
        optional: false,
        type: :string
      },
      %{
        description: "Unique identifier for this result, 1-64 Bytes",
        name: :id,
        optional: false,
        type: :string
      },
      %{
        description: "Location latitude in degrees",
        name: :latitude,
        optional: false,
        type: :float
      },
      %{
        description: "Location longitude in degrees",
        name: :longitude,
        optional: false,
        type: :float
      },
      %{description: "Location title", name: :title, optional: false, type: :string},
      %{
        description:
          "Optional. The radius of uncertainty for the location, measured in meters; 0-1500",
        name: :horizontal_accuracy,
        optional: true,
        type: :float
      },
      %{
        description:
          "Optional. Period in seconds during which the location can be updated, should be between 60 and 86400, or 0x7FFFFFFF for live locations that can be edited indefinitely.",
        name: :live_period,
        optional: true,
        type: :integer
      },
      %{
        description:
          "Optional. For live locations, a direction in which the user is moving, in degrees. Must be between 1 and 360 if specified.",
        name: :heading,
        optional: true,
        type: :integer
      },
      %{
        description:
          "Optional. For live locations, a maximum distance for proximity alerts about approaching another chat member, in meters. Must be between 1 and 100000 if specified.",
        name: :proximity_alert_radius,
        optional: true,
        type: :integer
      },
      %{
        description: "Optional. Inline keyboard attached to the message",
        name: :reply_markup,
        optional: true,
        type: Telegex.Type.InlineKeyboardMarkup
      },
      %{
        description: "Optional. Content of the message to be sent instead of the location",
        name: :input_message_content,
        optional: true,
        type: Telegex.Type.InputMessageContent
      },
      %{
        description: "Optional. Url of the thumbnail for the result",
        name: :thumbnail_url,
        optional: true,
        type: :string
      },
      %{
        description: "Optional. Thumbnail width",
        name: :thumbnail_width,
        optional: true,
        type: :integer
      },
      %{
        description: "Optional. Thumbnail height",
        name: :thumbnail_height,
        optional: true,
        type: :integer
      }
    ]
  )

  deftype(
    InlineQueryResultVenue,
    "Represents a venue. By default, the venue will be sent by the user. Alternatively, you can use input_message_content to send a message with the specified content instead of the venue.",
    [
      %{
        description: "Type of the result, must be venue",
        name: :type,
        optional: false,
        type: :string
      },
      %{
        description: "Unique identifier for this result, 1-64 Bytes",
        name: :id,
        optional: false,
        type: :string
      },
      %{
        description: "Latitude of the venue location in degrees",
        name: :latitude,
        optional: false,
        type: :float
      },
      %{
        description: "Longitude of the venue location in degrees",
        name: :longitude,
        optional: false,
        type: :float
      },
      %{description: "Title of the venue", name: :title, optional: false, type: :string},
      %{description: "Address of the venue", name: :address, optional: false, type: :string},
      %{
        description: "Optional. Foursquare identifier of the venue if known",
        name: :foursquare_id,
        optional: true,
        type: :string
      },
      %{
        description:
          "Optional. Foursquare type of the venue, if known. (For example, “arts_entertainment/default”, “arts_entertainment/aquarium” or “food/icecream”.)",
        name: :foursquare_type,
        optional: true,
        type: :string
      },
      %{
        description: "Optional. Google Places identifier of the venue",
        name: :google_place_id,
        optional: true,
        type: :string
      },
      %{
        description: "Optional. Google Places type of the venue. (See supported types.)",
        name: :google_place_type,
        optional: true,
        type: :string
      },
      %{
        description: "Optional. Inline keyboard attached to the message",
        name: :reply_markup,
        optional: true,
        type: Telegex.Type.InlineKeyboardMarkup
      },
      %{
        description: "Optional. Content of the message to be sent instead of the venue",
        name: :input_message_content,
        optional: true,
        type: Telegex.Type.InputMessageContent
      },
      %{
        description: "Optional. Url of the thumbnail for the result",
        name: :thumbnail_url,
        optional: true,
        type: :string
      },
      %{
        description: "Optional. Thumbnail width",
        name: :thumbnail_width,
        optional: true,
        type: :integer
      },
      %{
        description: "Optional. Thumbnail height",
        name: :thumbnail_height,
        optional: true,
        type: :integer
      }
    ]
  )

  deftype(
    InlineQueryResultContact,
    "Represents a contact with a phone number. By default, this contact will be sent by the user. Alternatively, you can use input_message_content to send a message with the specified content instead of the contact.",
    [
      %{
        description: "Type of the result, must be contact",
        name: :type,
        optional: false,
        type: :string
      },
      %{
        description: "Unique identifier for this result, 1-64 Bytes",
        name: :id,
        optional: false,
        type: :string
      },
      %{
        description: "Contact's phone number",
        name: :phone_number,
        optional: false,
        type: :string
      },
      %{description: "Contact's first name", name: :first_name, optional: false, type: :string},
      %{
        description: "Optional. Contact's last name",
        name: :last_name,
        optional: true,
        type: :string
      },
      %{
        description:
          "Optional. Additional data about the contact in the form of a vCard, 0-2048 bytes",
        name: :vcard,
        optional: true,
        type: :string
      },
      %{
        description: "Optional. Inline keyboard attached to the message",
        name: :reply_markup,
        optional: true,
        type: Telegex.Type.InlineKeyboardMarkup
      },
      %{
        description: "Optional. Content of the message to be sent instead of the contact",
        name: :input_message_content,
        optional: true,
        type: Telegex.Type.InputMessageContent
      },
      %{
        description: "Optional. Url of the thumbnail for the result",
        name: :thumbnail_url,
        optional: true,
        type: :string
      },
      %{
        description: "Optional. Thumbnail width",
        name: :thumbnail_width,
        optional: true,
        type: :integer
      },
      %{
        description: "Optional. Thumbnail height",
        name: :thumbnail_height,
        optional: true,
        type: :integer
      }
    ]
  )

  deftype(InlineQueryResultGame, "Represents a Game.", [
    %{
      description: "Type of the result, must be game",
      name: :type,
      optional: false,
      type: :string
    },
    %{
      description: "Unique identifier for this result, 1-64 bytes",
      name: :id,
      optional: false,
      type: :string
    },
    %{
      description: "Short name of the game",
      name: :game_short_name,
      optional: false,
      type: :string
    },
    %{
      description: "Optional. Inline keyboard attached to the message",
      name: :reply_markup,
      optional: true,
      type: Telegex.Type.InlineKeyboardMarkup
    }
  ])

  deftype(
    InlineQueryResultCachedPhoto,
    "Represents a link to a photo stored on the Telegram servers. By default, this photo will be sent by the user with an optional caption. Alternatively, you can use input_message_content to send a message with the specified content instead of the photo.",
    [
      %{
        description: "Type of the result, must be photo",
        name: :type,
        optional: false,
        type: :string
      },
      %{
        description: "Unique identifier for this result, 1-64 bytes",
        name: :id,
        optional: false,
        type: :string
      },
      %{
        description: "A valid file identifier of the photo",
        name: :photo_file_id,
        optional: false,
        type: :string
      },
      %{
        description: "Optional. Title for the result",
        name: :title,
        optional: true,
        type: :string
      },
      %{
        description: "Optional. Short description of the result",
        name: :description,
        optional: true,
        type: :string
      },
      %{
        description:
          "Optional. Caption of the photo to be sent, 0-1024 characters after entities parsing",
        name: :caption,
        optional: true,
        type: :string
      },
      %{
        description:
          "Optional. Mode for parsing entities in the photo caption. See formatting options for more details.",
        name: :parse_mode,
        optional: true,
        type: :string
      },
      %{
        description:
          "Optional. List of special entities that appear in the caption, which can be specified instead of parse_mode",
        name: :caption_entities,
        optional: true,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity}
      },
      %{
        description: "Optional. Pass True, if the caption must be shown above the message media",
        name: :show_caption_above_media,
        optional: true,
        type: :boolean
      },
      %{
        description: "Optional. Inline keyboard attached to the message",
        name: :reply_markup,
        optional: true,
        type: Telegex.Type.InlineKeyboardMarkup
      },
      %{
        description: "Optional. Content of the message to be sent instead of the photo",
        name: :input_message_content,
        optional: true,
        type: Telegex.Type.InputMessageContent
      }
    ]
  )

  deftype(
    InlineQueryResultCachedGif,
    "Represents a link to an animated GIF file stored on the Telegram servers. By default, this animated GIF file will be sent by the user with an optional caption. Alternatively, you can use input_message_content to send a message with specified content instead of the animation.",
    [
      %{
        description: "Type of the result, must be gif",
        name: :type,
        optional: false,
        type: :string
      },
      %{
        description: "Unique identifier for this result, 1-64 bytes",
        name: :id,
        optional: false,
        type: :string
      },
      %{
        description: "A valid file identifier for the GIF file",
        name: :gif_file_id,
        optional: false,
        type: :string
      },
      %{
        description: "Optional. Title for the result",
        name: :title,
        optional: true,
        type: :string
      },
      %{
        description:
          "Optional. Caption of the GIF file to be sent, 0-1024 characters after entities parsing",
        name: :caption,
        optional: true,
        type: :string
      },
      %{
        description:
          "Optional. Mode for parsing entities in the caption. See formatting options for more details.",
        name: :parse_mode,
        optional: true,
        type: :string
      },
      %{
        description:
          "Optional. List of special entities that appear in the caption, which can be specified instead of parse_mode",
        name: :caption_entities,
        optional: true,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity}
      },
      %{
        description: "Optional. Pass True, if the caption must be shown above the message media",
        name: :show_caption_above_media,
        optional: true,
        type: :boolean
      },
      %{
        description: "Optional. Inline keyboard attached to the message",
        name: :reply_markup,
        optional: true,
        type: Telegex.Type.InlineKeyboardMarkup
      },
      %{
        description: "Optional. Content of the message to be sent instead of the GIF animation",
        name: :input_message_content,
        optional: true,
        type: Telegex.Type.InputMessageContent
      }
    ]
  )

  deftype(
    InlineQueryResultCachedMpeg4Gif,
    "Represents a link to a video animation (H.264/MPEG-4 AVC video without sound) stored on the Telegram servers. By default, this animated MPEG-4 file will be sent by the user with an optional caption. Alternatively, you can use input_message_content to send a message with the specified content instead of the animation.",
    [
      %{
        description: "Type of the result, must be mpeg4_gif",
        name: :type,
        optional: false,
        type: :string
      },
      %{
        description: "Unique identifier for this result, 1-64 bytes",
        name: :id,
        optional: false,
        type: :string
      },
      %{
        description: "A valid file identifier for the MPEG4 file",
        name: :mpeg4_file_id,
        optional: false,
        type: :string
      },
      %{
        description: "Optional. Title for the result",
        name: :title,
        optional: true,
        type: :string
      },
      %{
        description:
          "Optional. Caption of the MPEG-4 file to be sent, 0-1024 characters after entities parsing",
        name: :caption,
        optional: true,
        type: :string
      },
      %{
        description:
          "Optional. Mode for parsing entities in the caption. See formatting options for more details.",
        name: :parse_mode,
        optional: true,
        type: :string
      },
      %{
        description:
          "Optional. List of special entities that appear in the caption, which can be specified instead of parse_mode",
        name: :caption_entities,
        optional: true,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity}
      },
      %{
        description: "Optional. Pass True, if the caption must be shown above the message media",
        name: :show_caption_above_media,
        optional: true,
        type: :boolean
      },
      %{
        description: "Optional. Inline keyboard attached to the message",
        name: :reply_markup,
        optional: true,
        type: Telegex.Type.InlineKeyboardMarkup
      },
      %{
        description: "Optional. Content of the message to be sent instead of the video animation",
        name: :input_message_content,
        optional: true,
        type: Telegex.Type.InputMessageContent
      }
    ]
  )

  deftype(
    InlineQueryResultCachedSticker,
    "Represents a link to a sticker stored on the Telegram servers. By default, this sticker will be sent by the user. Alternatively, you can use input_message_content to send a message with the specified content instead of the sticker.",
    [
      %{
        description: "Type of the result, must be sticker",
        name: :type,
        optional: false,
        type: :string
      },
      %{
        description: "Unique identifier for this result, 1-64 bytes",
        name: :id,
        optional: false,
        type: :string
      },
      %{
        description: "A valid file identifier of the sticker",
        name: :sticker_file_id,
        optional: false,
        type: :string
      },
      %{
        description: "Optional. Inline keyboard attached to the message",
        name: :reply_markup,
        optional: true,
        type: Telegex.Type.InlineKeyboardMarkup
      },
      %{
        description: "Optional. Content of the message to be sent instead of the sticker",
        name: :input_message_content,
        optional: true,
        type: Telegex.Type.InputMessageContent
      }
    ]
  )

  deftype(
    InlineQueryResultCachedDocument,
    "Represents a link to a file stored on the Telegram servers. By default, this file will be sent by the user with an optional caption. Alternatively, you can use input_message_content to send a message with the specified content instead of the file.",
    [
      %{
        description: "Type of the result, must be document",
        name: :type,
        optional: false,
        type: :string
      },
      %{
        description: "Unique identifier for this result, 1-64 bytes",
        name: :id,
        optional: false,
        type: :string
      },
      %{description: "Title for the result", name: :title, optional: false, type: :string},
      %{
        description: "A valid file identifier for the file",
        name: :document_file_id,
        optional: false,
        type: :string
      },
      %{
        description: "Optional. Short description of the result",
        name: :description,
        optional: true,
        type: :string
      },
      %{
        description:
          "Optional. Caption of the document to be sent, 0-1024 characters after entities parsing",
        name: :caption,
        optional: true,
        type: :string
      },
      %{
        description:
          "Optional. Mode for parsing entities in the document caption. See formatting options for more details.",
        name: :parse_mode,
        optional: true,
        type: :string
      },
      %{
        description:
          "Optional. List of special entities that appear in the caption, which can be specified instead of parse_mode",
        name: :caption_entities,
        optional: true,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity}
      },
      %{
        description: "Optional. Inline keyboard attached to the message",
        name: :reply_markup,
        optional: true,
        type: Telegex.Type.InlineKeyboardMarkup
      },
      %{
        description: "Optional. Content of the message to be sent instead of the file",
        name: :input_message_content,
        optional: true,
        type: Telegex.Type.InputMessageContent
      }
    ]
  )

  deftype(
    InlineQueryResultCachedVideo,
    "Represents a link to a video file stored on the Telegram servers. By default, this video file will be sent by the user with an optional caption. Alternatively, you can use input_message_content to send a message with the specified content instead of the video.",
    [
      %{
        description: "Type of the result, must be video",
        name: :type,
        optional: false,
        type: :string
      },
      %{
        description: "Unique identifier for this result, 1-64 bytes",
        name: :id,
        optional: false,
        type: :string
      },
      %{
        description: "A valid file identifier for the video file",
        name: :video_file_id,
        optional: false,
        type: :string
      },
      %{description: "Title for the result", name: :title, optional: false, type: :string},
      %{
        description: "Optional. Short description of the result",
        name: :description,
        optional: true,
        type: :string
      },
      %{
        description:
          "Optional. Caption of the video to be sent, 0-1024 characters after entities parsing",
        name: :caption,
        optional: true,
        type: :string
      },
      %{
        description:
          "Optional. Mode for parsing entities in the video caption. See formatting options for more details.",
        name: :parse_mode,
        optional: true,
        type: :string
      },
      %{
        description:
          "Optional. List of special entities that appear in the caption, which can be specified instead of parse_mode",
        name: :caption_entities,
        optional: true,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity}
      },
      %{
        description: "Optional. Pass True, if the caption must be shown above the message media",
        name: :show_caption_above_media,
        optional: true,
        type: :boolean
      },
      %{
        description: "Optional. Inline keyboard attached to the message",
        name: :reply_markup,
        optional: true,
        type: Telegex.Type.InlineKeyboardMarkup
      },
      %{
        description: "Optional. Content of the message to be sent instead of the video",
        name: :input_message_content,
        optional: true,
        type: Telegex.Type.InputMessageContent
      }
    ]
  )

  deftype(
    InlineQueryResultCachedVoice,
    "Represents a link to a voice message stored on the Telegram servers. By default, this voice message will be sent by the user. Alternatively, you can use input_message_content to send a message with the specified content instead of the voice message.",
    [
      %{
        description: "Type of the result, must be voice",
        name: :type,
        optional: false,
        type: :string
      },
      %{
        description: "Unique identifier for this result, 1-64 bytes",
        name: :id,
        optional: false,
        type: :string
      },
      %{
        description: "A valid file identifier for the voice message",
        name: :voice_file_id,
        optional: false,
        type: :string
      },
      %{description: "Voice message title", name: :title, optional: false, type: :string},
      %{
        description: "Optional. Caption, 0-1024 characters after entities parsing",
        name: :caption,
        optional: true,
        type: :string
      },
      %{
        description:
          "Optional. Mode for parsing entities in the voice message caption. See formatting options for more details.",
        name: :parse_mode,
        optional: true,
        type: :string
      },
      %{
        description:
          "Optional. List of special entities that appear in the caption, which can be specified instead of parse_mode",
        name: :caption_entities,
        optional: true,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity}
      },
      %{
        description: "Optional. Inline keyboard attached to the message",
        name: :reply_markup,
        optional: true,
        type: Telegex.Type.InlineKeyboardMarkup
      },
      %{
        description: "Optional. Content of the message to be sent instead of the voice message",
        name: :input_message_content,
        optional: true,
        type: Telegex.Type.InputMessageContent
      }
    ]
  )

  deftype(
    InlineQueryResultCachedAudio,
    "Represents a link to an MP3 audio file stored on the Telegram servers. By default, this audio file will be sent by the user. Alternatively, you can use input_message_content to send a message with the specified content instead of the audio.",
    [
      %{
        description: "Type of the result, must be audio",
        name: :type,
        optional: false,
        type: :string
      },
      %{
        description: "Unique identifier for this result, 1-64 bytes",
        name: :id,
        optional: false,
        type: :string
      },
      %{
        description: "A valid file identifier for the audio file",
        name: :audio_file_id,
        optional: false,
        type: :string
      },
      %{
        description: "Optional. Caption, 0-1024 characters after entities parsing",
        name: :caption,
        optional: true,
        type: :string
      },
      %{
        description:
          "Optional. Mode for parsing entities in the audio caption. See formatting options for more details.",
        name: :parse_mode,
        optional: true,
        type: :string
      },
      %{
        description:
          "Optional. List of special entities that appear in the caption, which can be specified instead of parse_mode",
        name: :caption_entities,
        optional: true,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity}
      },
      %{
        description: "Optional. Inline keyboard attached to the message",
        name: :reply_markup,
        optional: true,
        type: Telegex.Type.InlineKeyboardMarkup
      },
      %{
        description: "Optional. Content of the message to be sent instead of the audio",
        name: :input_message_content,
        optional: true,
        type: Telegex.Type.InputMessageContent
      }
    ]
  )

  deftype(
    InputTextMessageContent,
    "Represents the content of a text message to be sent as the result of an inline query.",
    [
      %{
        description: "Text of the message to be sent, 1-4096 characters",
        name: :message_text,
        optional: false,
        type: :string
      },
      %{
        description:
          "Optional. Mode for parsing entities in the message text. See formatting options for more details.",
        name: :parse_mode,
        optional: true,
        type: :string
      },
      %{
        description:
          "Optional. List of special entities that appear in message text, which can be specified instead of parse_mode",
        name: :entities,
        optional: true,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity}
      },
      %{
        description: "Optional. Link preview generation options for the message",
        name: :link_preview_options,
        optional: true,
        type: Telegex.Type.LinkPreviewOptions
      }
    ]
  )

  deftype(
    InputLocationMessageContent,
    "Represents the content of a location message to be sent as the result of an inline query.",
    [
      %{
        description: "Latitude of the location in degrees",
        name: :latitude,
        optional: false,
        type: :float
      },
      %{
        description: "Longitude of the location in degrees",
        name: :longitude,
        optional: false,
        type: :float
      },
      %{
        description:
          "Optional. The radius of uncertainty for the location, measured in meters; 0-1500",
        name: :horizontal_accuracy,
        optional: true,
        type: :float
      },
      %{
        description:
          "Optional. Period in seconds during which the location can be updated, should be between 60 and 86400, or 0x7FFFFFFF for live locations that can be edited indefinitely.",
        name: :live_period,
        optional: true,
        type: :integer
      },
      %{
        description:
          "Optional. For live locations, a direction in which the user is moving, in degrees. Must be between 1 and 360 if specified.",
        name: :heading,
        optional: true,
        type: :integer
      },
      %{
        description:
          "Optional. For live locations, a maximum distance for proximity alerts about approaching another chat member, in meters. Must be between 1 and 100000 if specified.",
        name: :proximity_alert_radius,
        optional: true,
        type: :integer
      }
    ]
  )

  deftype(
    InputVenueMessageContent,
    "Represents the content of a venue message to be sent as the result of an inline query.",
    [
      %{
        description: "Latitude of the venue in degrees",
        name: :latitude,
        optional: false,
        type: :float
      },
      %{
        description: "Longitude of the venue in degrees",
        name: :longitude,
        optional: false,
        type: :float
      },
      %{description: "Name of the venue", name: :title, optional: false, type: :string},
      %{description: "Address of the venue", name: :address, optional: false, type: :string},
      %{
        description: "Optional. Foursquare identifier of the venue, if known",
        name: :foursquare_id,
        optional: true,
        type: :string
      },
      %{
        description:
          "Optional. Foursquare type of the venue, if known. (For example, “arts_entertainment/default”, “arts_entertainment/aquarium” or “food/icecream”.)",
        name: :foursquare_type,
        optional: true,
        type: :string
      },
      %{
        description: "Optional. Google Places identifier of the venue",
        name: :google_place_id,
        optional: true,
        type: :string
      },
      %{
        description: "Optional. Google Places type of the venue. (See supported types.)",
        name: :google_place_type,
        optional: true,
        type: :string
      }
    ]
  )

  deftype(
    InputContactMessageContent,
    "Represents the content of a contact message to be sent as the result of an inline query.",
    [
      %{
        description: "Contact's phone number",
        name: :phone_number,
        optional: false,
        type: :string
      },
      %{description: "Contact's first name", name: :first_name, optional: false, type: :string},
      %{
        description: "Optional. Contact's last name",
        name: :last_name,
        optional: true,
        type: :string
      },
      %{
        description:
          "Optional. Additional data about the contact in the form of a vCard, 0-2048 bytes",
        name: :vcard,
        optional: true,
        type: :string
      }
    ]
  )

  deftype(
    InputInvoiceMessageContent,
    "Represents the content of an invoice message to be sent as the result of an inline query.",
    [
      %{
        description: "Product name, 1-32 characters",
        name: :title,
        optional: false,
        type: :string
      },
      %{
        description: "Product description, 1-255 characters",
        name: :description,
        optional: false,
        type: :string
      },
      %{
        description:
          "Bot-defined invoice payload, 1-128 bytes. This will not be displayed to the user, use it for your internal processes.",
        name: :payload,
        optional: false,
        type: :string
      },
      %{
        description:
          "Optional. Payment provider token, obtained via @BotFather. Pass an empty string for payments in Telegram Stars.",
        name: :provider_token,
        optional: true,
        type: :string
      },
      %{
        description:
          "Three-letter ISO 4217 currency code, see more on currencies. Pass “XTR” for payments in Telegram Stars.",
        name: :currency,
        optional: false,
        type: :string
      },
      %{
        description:
          "Price breakdown, a JSON-serialized list of components (e.g. product price, tax, discount, delivery cost, delivery tax, bonus, etc.). Must contain exactly one item for payments in Telegram Stars.",
        name: :prices,
        optional: false,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.LabeledPrice}
      },
      %{
        description:
          "Optional. The maximum accepted amount for tips in the smallest units of the currency (integer, not float/double). For example, for a maximum tip of US$ 1.45 pass max_tip_amount = 145. See the exp parameter in currencies.json, it shows the number of digits past the decimal point for each currency (2 for the majority of currencies). Defaults to 0. Not supported for payments in Telegram Stars.",
        name: :max_tip_amount,
        optional: true,
        type: :integer
      },
      %{
        description:
          "Optional. A JSON-serialized array of suggested amounts of tip in the smallest units of the currency (integer, not float/double). At most 4 suggested tip amounts can be specified. The suggested tip amounts must be positive, passed in a strictly increased order and must not exceed max_tip_amount.",
        name: :suggested_tip_amounts,
        optional: true,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: :integer}
      },
      %{
        description:
          "Optional. A JSON-serialized object for data about the invoice, which will be shared with the payment provider. A detailed description of the required fields should be provided by the payment provider.",
        name: :provider_data,
        optional: true,
        type: :string
      },
      %{
        description:
          "Optional. URL of the product photo for the invoice. Can be a photo of the goods or a marketing image for a service.",
        name: :photo_url,
        optional: true,
        type: :string
      },
      %{
        description: "Optional. Photo size in bytes",
        name: :photo_size,
        optional: true,
        type: :integer
      },
      %{description: "Optional. Photo width", name: :photo_width, optional: true, type: :integer},
      %{
        description: "Optional. Photo height",
        name: :photo_height,
        optional: true,
        type: :integer
      },
      %{
        description:
          "Optional. Pass True if you require the user's full name to complete the order. Ignored for payments in Telegram Stars.",
        name: :need_name,
        optional: true,
        type: :boolean
      },
      %{
        description:
          "Optional. Pass True if you require the user's phone number to complete the order. Ignored for payments in Telegram Stars.",
        name: :need_phone_number,
        optional: true,
        type: :boolean
      },
      %{
        description:
          "Optional. Pass True if you require the user's email address to complete the order. Ignored for payments in Telegram Stars.",
        name: :need_email,
        optional: true,
        type: :boolean
      },
      %{
        description:
          "Optional. Pass True if you require the user's shipping address to complete the order. Ignored for payments in Telegram Stars.",
        name: :need_shipping_address,
        optional: true,
        type: :boolean
      },
      %{
        description:
          "Optional. Pass True if the user's phone number should be sent to the provider. Ignored for payments in Telegram Stars.",
        name: :send_phone_number_to_provider,
        optional: true,
        type: :boolean
      },
      %{
        description:
          "Optional. Pass True if the user's email address should be sent to the provider. Ignored for payments in Telegram Stars.",
        name: :send_email_to_provider,
        optional: true,
        type: :boolean
      },
      %{
        description:
          "Optional. Pass True if the final price depends on the shipping method. Ignored for payments in Telegram Stars.",
        name: :is_flexible,
        optional: true,
        type: :boolean
      }
    ]
  )

  deftype(
    ChosenInlineResult,
    "Represents a result of an inline query that was chosen by the user and sent to their chat partner.",
    [
      %{
        description: "The unique identifier for the result that was chosen",
        name: :result_id,
        optional: false,
        type: :string
      },
      %{
        description: "The user that chose the result",
        name: :from,
        optional: false,
        type: Telegex.Type.User
      },
      %{
        description: "Optional. Sender location, only for bots that require user location",
        name: :location,
        optional: true,
        type: Telegex.Type.Location
      },
      %{
        description:
          "Optional. Identifier of the sent inline message. Available only if there is an inline keyboard attached to the message. Will be also received in callback queries and can be used to edit the message.",
        name: :inline_message_id,
        optional: true,
        type: :string
      },
      %{
        description: "The query that was used to obtain the result",
        name: :query,
        optional: false,
        type: :string
      }
    ]
  )

  deftype(
    SentWebAppMessage,
    "Describes an inline message sent by a Web App on behalf of a user.",
    [
      %{
        description:
          "Optional. Identifier of the sent inline message. Available only if there is an inline keyboard attached to the message.",
        name: :inline_message_id,
        optional: true,
        type: :string
      }
    ]
  )

  deftype(LabeledPrice, "This object represents a portion of the price for goods or services.", [
    %{description: "Portion label", name: :label, optional: false, type: :string},
    %{
      description:
        "Price of the product in the smallest units of the currency (integer, not float/double). For example, for a price of US$ 1.45 pass amount = 145. See the exp parameter in currencies.json, it shows the number of digits past the decimal point for each currency (2 for the majority of currencies).",
      name: :amount,
      optional: false,
      type: :integer
    }
  ])

  deftype(Invoice, "This object contains basic information about an invoice.", [
    %{description: "Product name", name: :title, optional: false, type: :string},
    %{description: "Product description", name: :description, optional: false, type: :string},
    %{
      description: "Unique bot deep-linking parameter that can be used to generate this invoice",
      name: :start_parameter,
      optional: false,
      type: :string
    },
    %{
      description: "Three-letter ISO 4217 currency code, or “XTR” for payments in Telegram Stars",
      name: :currency,
      optional: false,
      type: :string
    },
    %{
      description:
        "Total price in the smallest units of the currency (integer, not float/double). For example, for a price of US$ 1.45 pass amount = 145. See the exp parameter in currencies.json, it shows the number of digits past the decimal point for each currency (2 for the majority of currencies).",
      name: :total_amount,
      optional: false,
      type: :integer
    }
  ])

  deftype(ShippingAddress, "This object represents a shipping address.", [
    %{
      description: "Two-letter ISO 3166-1 alpha-2 country code",
      name: :country_code,
      optional: false,
      type: :string
    },
    %{description: "State, if applicable", name: :state, optional: false, type: :string},
    %{description: "City", name: :city, optional: false, type: :string},
    %{
      description: "First line for the address",
      name: :street_line1,
      optional: false,
      type: :string
    },
    %{
      description: "Second line for the address",
      name: :street_line2,
      optional: false,
      type: :string
    },
    %{description: "Address post code", name: :post_code, optional: false, type: :string}
  ])

  deftype(OrderInfo, "This object represents information about an order.", [
    %{description: "Optional. User name", name: :name, optional: true, type: :string},
    %{
      description: "Optional. User's phone number",
      name: :phone_number,
      optional: true,
      type: :string
    },
    %{description: "Optional. User email", name: :email, optional: true, type: :string},
    %{
      description: "Optional. User shipping address",
      name: :shipping_address,
      optional: true,
      type: Telegex.Type.ShippingAddress
    }
  ])

  deftype(ShippingOption, "This object represents one shipping option.", [
    %{description: "Shipping option identifier", name: :id, optional: false, type: :string},
    %{description: "Option title", name: :title, optional: false, type: :string},
    %{
      description: "List of price portions",
      name: :prices,
      optional: false,
      type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.LabeledPrice}
    }
  ])

  deftype(
    SuccessfulPayment,
    "This object contains basic information about a successful payment.",
    [
      %{
        description:
          "Three-letter ISO 4217 currency code, or “XTR” for payments in Telegram Stars",
        name: :currency,
        optional: false,
        type: :string
      },
      %{
        description:
          "Total price in the smallest units of the currency (integer, not float/double). For example, for a price of US$ 1.45 pass amount = 145. See the exp parameter in currencies.json, it shows the number of digits past the decimal point for each currency (2 for the majority of currencies).",
        name: :total_amount,
        optional: false,
        type: :integer
      },
      %{
        description: "Bot-specified invoice payload",
        name: :invoice_payload,
        optional: false,
        type: :string
      },
      %{
        description: "Optional. Identifier of the shipping option chosen by the user",
        name: :shipping_option_id,
        optional: true,
        type: :string
      },
      %{
        description: "Optional. Order information provided by the user",
        name: :order_info,
        optional: true,
        type: Telegex.Type.OrderInfo
      },
      %{
        description: "Telegram payment identifier",
        name: :telegram_payment_charge_id,
        optional: false,
        type: :string
      },
      %{
        description: "Provider payment identifier",
        name: :provider_payment_charge_id,
        optional: false,
        type: :string
      }
    ]
  )

  deftype(RefundedPayment, "This object contains basic information about a refunded payment.", [
    %{
      description:
        "Three-letter ISO 4217 currency code, or “XTR” for payments in Telegram Stars. Currently, always “XTR”",
      name: :currency,
      optional: false,
      type: :string
    },
    %{
      description:
        "Total refunded price in the smallest units of the currency (integer, not float/double). For example, for a price of US$ 1.45, total_amount = 145. See the exp parameter in currencies.json, it shows the number of digits past the decimal point for each currency (2 for the majority of currencies).",
      name: :total_amount,
      optional: false,
      type: :integer
    },
    %{
      description: "Bot-specified invoice payload",
      name: :invoice_payload,
      optional: false,
      type: :string
    },
    %{
      description: "Telegram payment identifier",
      name: :telegram_payment_charge_id,
      optional: false,
      type: :string
    },
    %{
      description: "Optional. Provider payment identifier",
      name: :provider_payment_charge_id,
      optional: true,
      type: :string
    }
  ])

  deftype(ShippingQuery, "This object contains information about an incoming shipping query.", [
    %{description: "Unique query identifier", name: :id, optional: false, type: :string},
    %{
      description: "User who sent the query",
      name: :from,
      optional: false,
      type: Telegex.Type.User
    },
    %{
      description: "Bot-specified invoice payload",
      name: :invoice_payload,
      optional: false,
      type: :string
    },
    %{
      description: "User specified shipping address",
      name: :shipping_address,
      optional: false,
      type: Telegex.Type.ShippingAddress
    }
  ])

  deftype(
    PreCheckoutQuery,
    "This object contains information about an incoming pre-checkout query.",
    [
      %{description: "Unique query identifier", name: :id, optional: false, type: :string},
      %{
        description: "User who sent the query",
        name: :from,
        optional: false,
        type: Telegex.Type.User
      },
      %{
        description:
          "Three-letter ISO 4217 currency code, or “XTR” for payments in Telegram Stars",
        name: :currency,
        optional: false,
        type: :string
      },
      %{
        description:
          "Total price in the smallest units of the currency (integer, not float/double). For example, for a price of US$ 1.45 pass amount = 145. See the exp parameter in currencies.json, it shows the number of digits past the decimal point for each currency (2 for the majority of currencies).",
        name: :total_amount,
        optional: false,
        type: :integer
      },
      %{
        description: "Bot-specified invoice payload",
        name: :invoice_payload,
        optional: false,
        type: :string
      },
      %{
        description: "Optional. Identifier of the shipping option chosen by the user",
        name: :shipping_option_id,
        optional: true,
        type: :string
      },
      %{
        description: "Optional. Order information provided by the user",
        name: :order_info,
        optional: true,
        type: Telegex.Type.OrderInfo
      }
    ]
  )

  deftype(PaidMediaPurchased, "This object contains information about a paid media purchase.", [
    %{
      description: "User who purchased the media",
      name: :from,
      optional: false,
      type: Telegex.Type.User
    },
    %{
      description: "Bot-specified paid media payload",
      name: :paid_media_payload,
      optional: false,
      type: :string
    }
  ])

  deftype(RevenueWithdrawalStatePending, "The withdrawal is in progress.", [
    %{
      description: "Type of the state, always “pending”",
      name: :type,
      optional: false,
      type: :string
    }
  ])

  deftype(RevenueWithdrawalStateSucceeded, "The withdrawal succeeded.", [
    %{
      description: "Type of the state, always “succeeded”",
      name: :type,
      optional: false,
      type: :string
    },
    %{
      description: "Date the withdrawal was completed in Unix time",
      name: :date,
      optional: false,
      type: :integer
    },
    %{
      description: "An HTTPS URL that can be used to see transaction details",
      name: :url,
      optional: false,
      type: :string
    }
  ])

  deftype(
    RevenueWithdrawalStateFailed,
    "The withdrawal failed and the transaction was refunded.",
    [
      %{
        description: "Type of the state, always “failed”",
        name: :type,
        optional: false,
        type: :string
      }
    ]
  )

  deftype(TransactionPartnerUser, "Describes a transaction with a user.", [
    %{
      description: "Type of the transaction partner, always “user”",
      name: :type,
      optional: false,
      type: :string
    },
    %{
      description: "Information about the user",
      name: :user,
      optional: false,
      type: Telegex.Type.User
    },
    %{
      description: "Optional. Bot-specified invoice payload",
      name: :invoice_payload,
      optional: true,
      type: :string
    },
    %{
      description: "Optional. Information about the paid media bought by the user",
      name: :paid_media,
      optional: true,
      type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.PaidMedia}
    },
    %{
      description: "Optional. Bot-specified paid media payload",
      name: :paid_media_payload,
      optional: true,
      type: :string
    }
  ])

  deftype(TransactionPartnerFragment, "Describes a withdrawal transaction with Fragment.", [
    %{
      description: "Type of the transaction partner, always “fragment”",
      name: :type,
      optional: false,
      type: :string
    },
    %{
      description: "Optional. State of the transaction if the transaction is outgoing",
      name: :withdrawal_state,
      optional: true,
      type: Telegex.Type.RevenueWithdrawalState
    }
  ])

  deftype(
    TransactionPartnerTelegramAds,
    "Describes a withdrawal transaction to the Telegram Ads platform.",
    [
      %{
        description: "Type of the transaction partner, always “telegram_ads”",
        name: :type,
        optional: false,
        type: :string
      }
    ]
  )

  deftype(
    TransactionPartnerTelegramApi,
    "Describes a transaction with payment for paid broadcasting.",
    [
      %{
        description: "Type of the transaction partner, always “telegram_api”",
        name: :type,
        optional: false,
        type: :string
      },
      %{
        description:
          "The number of successful requests that exceeded regular limits and were therefore billed",
        name: :request_count,
        optional: false,
        type: :integer
      }
    ]
  )

  deftype(
    TransactionPartnerOther,
    "Describes a transaction with an unknown source or recipient.",
    [
      %{
        description: "Type of the transaction partner, always “other”",
        name: :type,
        optional: false,
        type: :string
      }
    ]
  )

  deftype(StarTransaction, "Describes a Telegram Star transaction.", [
    %{
      description:
        "Unique identifier of the transaction. Coincides with the identifier of the original transaction for refund transactions. Coincides with SuccessfulPayment.telegram_payment_charge_id for successful incoming payments from users.",
      name: :id,
      optional: false,
      type: :string
    },
    %{
      description: "Number of Telegram Stars transferred by the transaction",
      name: :amount,
      optional: false,
      type: :integer
    },
    %{
      description: "Date the transaction was created in Unix time",
      name: :date,
      optional: false,
      type: :integer
    },
    %{
      description:
        "Optional. Source of an incoming transaction (e.g., a user purchasing goods or services, Fragment refunding a failed withdrawal). Only for incoming transactions",
      name: :source,
      optional: true,
      type: Telegex.Type.TransactionPartner
    },
    %{
      description:
        "Optional. Receiver of an outgoing transaction (e.g., a user for a purchase refund, Fragment for a withdrawal). Only for outgoing transactions",
      name: :receiver,
      optional: true,
      type: Telegex.Type.TransactionPartner
    }
  ])

  deftype(StarTransactions, "Contains a list of Telegram Star transactions.", [
    %{
      description: "The list of transactions",
      name: :transactions,
      optional: false,
      type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.StarTransaction}
    }
  ])

  deftype(PassportData, "Describes Telegram Passport data shared with the bot by the user.", [
    %{
      description:
        "Array with information about documents and other Telegram Passport elements that was shared with the bot",
      name: :data,
      optional: false,
      type: %{
        __struct__: Telegex.TypeDefiner.ArrayType,
        elem_type: Telegex.Type.EncryptedPassportElement
      }
    },
    %{
      description: "Encrypted credentials required to decrypt the data",
      name: :credentials,
      optional: false,
      type: Telegex.Type.EncryptedCredentials
    }
  ])

  deftype(
    PassportFile,
    "This object represents a file uploaded to Telegram Passport. Currently all Telegram Passport files are in JPEG format when decrypted and don't exceed 10MB.",
    [
      %{
        description: "Identifier for this file, which can be used to download or reuse the file",
        name: :file_id,
        optional: false,
        type: :string
      },
      %{
        description:
          "Unique identifier for this file, which is supposed to be the same over time and for different bots. Can't be used to download or reuse the file.",
        name: :file_unique_id,
        optional: false,
        type: :string
      },
      %{description: "File size in bytes", name: :file_size, optional: false, type: :integer},
      %{
        description: "Unix time when the file was uploaded",
        name: :file_date,
        optional: false,
        type: :integer
      }
    ]
  )

  deftype(
    EncryptedPassportElement,
    "Describes documents or other Telegram Passport elements shared with the bot by the user.",
    [
      %{
        description:
          "Element type. One of “personal_details”, “passport”, “driver_license”, “identity_card”, “internal_passport”, “address”, “utility_bill”, “bank_statement”, “rental_agreement”, “passport_registration”, “temporary_registration”, “phone_number”, “email”.",
        name: :type,
        optional: false,
        type: :string
      },
      %{
        description:
          "Optional. Base64-encoded encrypted Telegram Passport element data provided by the user; available only for “personal_details”, “passport”, “driver_license”, “identity_card”, “internal_passport” and “address” types. Can be decrypted and verified using the accompanying EncryptedCredentials.",
        name: :data,
        optional: true,
        type: :string
      },
      %{
        description:
          "Optional. User's verified phone number; available only for “phone_number” type",
        name: :phone_number,
        optional: true,
        type: :string
      },
      %{
        description: "Optional. User's verified email address; available only for “email” type",
        name: :email,
        optional: true,
        type: :string
      },
      %{
        description:
          "Optional. Array of encrypted files with documents provided by the user; available only for “utility_bill”, “bank_statement”, “rental_agreement”, “passport_registration” and “temporary_registration” types. Files can be decrypted and verified using the accompanying EncryptedCredentials.",
        name: :files,
        optional: true,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.PassportFile}
      },
      %{
        description:
          "Optional. Encrypted file with the front side of the document, provided by the user; available only for “passport”, “driver_license”, “identity_card” and “internal_passport”. The file can be decrypted and verified using the accompanying EncryptedCredentials.",
        name: :front_side,
        optional: true,
        type: Telegex.Type.PassportFile
      },
      %{
        description:
          "Optional. Encrypted file with the reverse side of the document, provided by the user; available only for “driver_license” and “identity_card”. The file can be decrypted and verified using the accompanying EncryptedCredentials.",
        name: :reverse_side,
        optional: true,
        type: Telegex.Type.PassportFile
      },
      %{
        description:
          "Optional. Encrypted file with the selfie of the user holding a document, provided by the user; available if requested for “passport”, “driver_license”, “identity_card” and “internal_passport”. The file can be decrypted and verified using the accompanying EncryptedCredentials.",
        name: :selfie,
        optional: true,
        type: Telegex.Type.PassportFile
      },
      %{
        description:
          "Optional. Array of encrypted files with translated versions of documents provided by the user; available if requested for “passport”, “driver_license”, “identity_card”, “internal_passport”, “utility_bill”, “bank_statement”, “rental_agreement”, “passport_registration” and “temporary_registration” types. Files can be decrypted and verified using the accompanying EncryptedCredentials.",
        name: :translation,
        optional: true,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.PassportFile}
      },
      %{
        description: "Base64-encoded element hash for using in PassportElementErrorUnspecified",
        name: :hash,
        optional: false,
        type: :string
      }
    ]
  )

  deftype(
    EncryptedCredentials,
    "Describes data required for decrypting and authenticating EncryptedPassportElement. See the Telegram Passport Documentation for a complete description of the data decryption and authentication processes.",
    [
      %{
        description:
          "Base64-encoded encrypted JSON-serialized data with unique user's payload, data hashes and secrets required for EncryptedPassportElement decryption and authentication",
        name: :data,
        optional: false,
        type: :string
      },
      %{
        description: "Base64-encoded data hash for data authentication",
        name: :hash,
        optional: false,
        type: :string
      },
      %{
        description:
          "Base64-encoded secret, encrypted with the bot's public RSA key, required for data decryption",
        name: :secret,
        optional: false,
        type: :string
      }
    ]
  )

  deftype(
    PassportElementErrorDataField,
    "Represents an issue in one of the data fields that was provided by the user. The error is considered resolved when the field's value changes.",
    [
      %{description: "Error source, must be data", name: :source, optional: false, type: :string},
      %{
        description:
          "The section of the user's Telegram Passport which has the error, one of “personal_details”, “passport”, “driver_license”, “identity_card”, “internal_passport”, “address”",
        name: :type,
        optional: false,
        type: :string
      },
      %{
        description: "Name of the data field which has the error",
        name: :field_name,
        optional: false,
        type: :string
      },
      %{
        description: "Base64-encoded data hash",
        name: :data_hash,
        optional: false,
        type: :string
      },
      %{description: "Error message", name: :message, optional: false, type: :string}
    ]
  )

  deftype(
    PassportElementErrorFrontSide,
    "Represents an issue with the front side of a document. The error is considered resolved when the file with the front side of the document changes.",
    [
      %{
        description: "Error source, must be front_side",
        name: :source,
        optional: false,
        type: :string
      },
      %{
        description:
          "The section of the user's Telegram Passport which has the issue, one of “passport”, “driver_license”, “identity_card”, “internal_passport”",
        name: :type,
        optional: false,
        type: :string
      },
      %{
        description: "Base64-encoded hash of the file with the front side of the document",
        name: :file_hash,
        optional: false,
        type: :string
      },
      %{description: "Error message", name: :message, optional: false, type: :string}
    ]
  )

  deftype(
    PassportElementErrorReverseSide,
    "Represents an issue with the reverse side of a document. The error is considered resolved when the file with reverse side of the document changes.",
    [
      %{
        description: "Error source, must be reverse_side",
        name: :source,
        optional: false,
        type: :string
      },
      %{
        description:
          "The section of the user's Telegram Passport which has the issue, one of “driver_license”, “identity_card”",
        name: :type,
        optional: false,
        type: :string
      },
      %{
        description: "Base64-encoded hash of the file with the reverse side of the document",
        name: :file_hash,
        optional: false,
        type: :string
      },
      %{description: "Error message", name: :message, optional: false, type: :string}
    ]
  )

  deftype(
    PassportElementErrorSelfie,
    "Represents an issue with the selfie with a document. The error is considered resolved when the file with the selfie changes.",
    [
      %{
        description: "Error source, must be selfie",
        name: :source,
        optional: false,
        type: :string
      },
      %{
        description:
          "The section of the user's Telegram Passport which has the issue, one of “passport”, “driver_license”, “identity_card”, “internal_passport”",
        name: :type,
        optional: false,
        type: :string
      },
      %{
        description: "Base64-encoded hash of the file with the selfie",
        name: :file_hash,
        optional: false,
        type: :string
      },
      %{description: "Error message", name: :message, optional: false, type: :string}
    ]
  )

  deftype(
    PassportElementErrorFile,
    "Represents an issue with a document scan. The error is considered resolved when the file with the document scan changes.",
    [
      %{description: "Error source, must be file", name: :source, optional: false, type: :string},
      %{
        description:
          "The section of the user's Telegram Passport which has the issue, one of “utility_bill”, “bank_statement”, “rental_agreement”, “passport_registration”, “temporary_registration”",
        name: :type,
        optional: false,
        type: :string
      },
      %{
        description: "Base64-encoded file hash",
        name: :file_hash,
        optional: false,
        type: :string
      },
      %{description: "Error message", name: :message, optional: false, type: :string}
    ]
  )

  deftype(
    PassportElementErrorFiles,
    "Represents an issue with a list of scans. The error is considered resolved when the list of files containing the scans changes.",
    [
      %{
        description: "Error source, must be files",
        name: :source,
        optional: false,
        type: :string
      },
      %{
        description:
          "The section of the user's Telegram Passport which has the issue, one of “utility_bill”, “bank_statement”, “rental_agreement”, “passport_registration”, “temporary_registration”",
        name: :type,
        optional: false,
        type: :string
      },
      %{
        description: "List of base64-encoded file hashes",
        name: :file_hashes,
        optional: false,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: :string}
      },
      %{description: "Error message", name: :message, optional: false, type: :string}
    ]
  )

  deftype(
    PassportElementErrorTranslationFile,
    "Represents an issue with one of the files that constitute the translation of a document. The error is considered resolved when the file changes.",
    [
      %{
        description: "Error source, must be translation_file",
        name: :source,
        optional: false,
        type: :string
      },
      %{
        description:
          "Type of element of the user's Telegram Passport which has the issue, one of “passport”, “driver_license”, “identity_card”, “internal_passport”, “utility_bill”, “bank_statement”, “rental_agreement”, “passport_registration”, “temporary_registration”",
        name: :type,
        optional: false,
        type: :string
      },
      %{
        description: "Base64-encoded file hash",
        name: :file_hash,
        optional: false,
        type: :string
      },
      %{description: "Error message", name: :message, optional: false, type: :string}
    ]
  )

  deftype(
    PassportElementErrorTranslationFiles,
    "Represents an issue with the translated version of a document. The error is considered resolved when a file with the document translation change.",
    [
      %{
        description: "Error source, must be translation_files",
        name: :source,
        optional: false,
        type: :string
      },
      %{
        description:
          "Type of element of the user's Telegram Passport which has the issue, one of “passport”, “driver_license”, “identity_card”, “internal_passport”, “utility_bill”, “bank_statement”, “rental_agreement”, “passport_registration”, “temporary_registration”",
        name: :type,
        optional: false,
        type: :string
      },
      %{
        description: "List of base64-encoded file hashes",
        name: :file_hashes,
        optional: false,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: :string}
      },
      %{description: "Error message", name: :message, optional: false, type: :string}
    ]
  )

  deftype(
    PassportElementErrorUnspecified,
    "Represents an issue in an unspecified place. The error is considered resolved when new data is added.",
    [
      %{
        description: "Error source, must be unspecified",
        name: :source,
        optional: false,
        type: :string
      },
      %{
        description: "Type of element of the user's Telegram Passport which has the issue",
        name: :type,
        optional: false,
        type: :string
      },
      %{
        description: "Base64-encoded element hash",
        name: :element_hash,
        optional: false,
        type: :string
      },
      %{description: "Error message", name: :message, optional: false, type: :string}
    ]
  )

  deftype(
    Game,
    "This object represents a game. Use BotFather to create and edit games, their short names will act as unique identifiers.",
    [
      %{description: "Title of the game", name: :title, optional: false, type: :string},
      %{
        description: "Description of the game",
        name: :description,
        optional: false,
        type: :string
      },
      %{
        description: "Photo that will be displayed in the game message in chats.",
        name: :photo,
        optional: false,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.PhotoSize}
      },
      %{
        description:
          "Optional. Brief description of the game or high scores included in the game message. Can be automatically edited to include current high scores for the game when the bot calls setGameScore, or manually edited using editMessageText. 0-4096 characters.",
        name: :text,
        optional: true,
        type: :string
      },
      %{
        description:
          "Optional. Special entities that appear in text, such as usernames, URLs, bot commands, etc.",
        name: :text_entities,
        optional: true,
        type: %{__struct__: Telegex.TypeDefiner.ArrayType, elem_type: Telegex.Type.MessageEntity}
      },
      %{
        description:
          "Optional. Animation that will be displayed in the game message in chats. Upload via BotFather",
        name: :animation,
        optional: true,
        type: Telegex.Type.Animation
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
      description: "Position in high score table for the game",
      name: :position,
      optional: false,
      type: :integer
    },
    %{description: "User", name: :user, optional: false, type: Telegex.Type.User},
    %{description: "Score", name: :score, optional: false, type: :integer}
  ])
end
