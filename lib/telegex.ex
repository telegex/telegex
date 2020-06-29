defmodule Telegex do
  @moduledoc """
  All methods in the Bot API.
  """

  import Telegex.DSL, only: [method: 3]

  alias Telegex.Attachment

  # Store methods containing attachments and all attachment fields.
  # This attribute is accumulated in the `Telegex.DSL.method/3` macro.
  Module.register_attribute(__MODULE__, :include_attachment_methods_meta, accumulate: true)

  @doc """
  Use this method to receive incoming updates using long polling ([wiki](https://en.wikipedia.org/wiki/Push_technology#Long_polling)).
  An Array of `Telegex.Model.Update` objects is returned.
  """
  method(
    "getUpdates",
    [
      {:offset, :integer, :optional},
      {:limit, :integer, :optional},
      {:timeout, :integer, :optional},
      {:allowed_updates, [String], :optional}
    ],
    [Update]
  )

  @doc """
  A simple method for testing your bot's auth token. Requires no parameters.
  Returns basic information about the bot in form of a `Telegex.Model.User` object.
  """
  method("getMe", [], User)

  @doc """
  Use this method to send text messages. On success, the sent `Telegex.Model.Message` is returned.
  """
  method(
    "sendMessage",
    [
      {:chat_id, :integer | String},
      {:text, String},
      {:parse_mode, String, :optional},
      {:disable_web_page_preview, :boolean, :optional},
      {:disable_notification, :boolean, :optional},
      {:reply_to_message_id, :integer, :optional},
      {:reply_markup,
       InlineKeyboardMarkup | ReplyKeyboardMarkup | ReplyKeyboardRemove | ForceReply, :optional}
    ],
    Message
  )

  @doc """
  Use this method to forward messages of any kind. On success, the sent `Telegex.Model.Message` is returned.
  """
  method(
    "forwardMessage",
    [
      {:chat_id, :integer | String},
      {:from_chat_id, :integer | String},
      {:disable_notification, :boolean, :optional},
      {:message_id, :integer}
    ],
    Message
  )

  @doc """
  Use this method to send photos. On success, the sent `Telegex.Model.Message` is returned.
  """
  method(
    "sendPhoto",
    [
      {:chat_id, :integer | String},
      {:photo, InputFile | String},
      {:caption, String, :optional},
      {:parse_mode, String, :optional},
      {:disable_notification, :boolean, :optional},
      {:reply_to_message_id, :integer, :optional},
      {:reply_markup,
       InlineKeyboardMarkup | ReplyKeyboardMarkup | ReplyKeyboardRemove | ForceReply, :optional}
    ],
    Message
  )

  @doc """
  Use this method to send audio files, if you want Telegram clients to display them in the music player.
  Your audio must be in the .MP3 or .M4A format.
  On success, the sent `Telegex.Model.Message` is returned. Bots can currently send audio files of up to 50 MB in size,
  this limit may be changed in the future.

  For sending voice messages, use the [sendVoice](https://core.telegram.org/bots/api#sendvoice) method instead.
  """
  method(
    "sendAudio",
    [
      {:chat_id, :integer | String},
      {:audio, InputFile | String},
      {:caption, String, :optional},
      {:parse_mode, String, :optional},
      {:performer, String, :optional},
      {:title, String, :optional},
      {:thumb, InputFile | String, :optional},
      {:disable_notification, :boolean, :optional},
      {:reply_to_message_id, :integer, :optional},
      {:reply_markup,
       InlineKeyboardMarkup | ReplyKeyboardMarkup | ReplyKeyboardRemove | ForceReply, :optional}
    ],
    Message
  )

  @doc """
  Use this method to send general files. On success, the sent `Telegex.Model.Message` is returned.
  Bots can currently send files of any type of up to 50 MB in size, this limit may be changed in the future.
  """
  method(
    "sendDocument",
    [
      {:chat_id, :integer | String},
      {:document, InputFile | String},
      {:thumb, InputFile | String, :optional},
      {:caption, String, :optional},
      {:parse_mode, String, :optional},
      {:disable_notification, :boolean, :optional},
      {:reply_to_message_id, :integer, :optional},
      {:reply_markup,
       InlineKeyboardMarkup | ReplyKeyboardMarkup | ReplyKeyboardRemove | ForceReply, :optional}
    ],
    Message
  )

  @doc """
  Use this method to send video files, Telegram clients support mp4 videos (other formats may be sent as `Telegex.Model.Document`).
  On success, the sent `Telegex.Model.Message` is returned.
  Bots can currently send video files of up to 50 MB in size, this limit may be changed in the future.
  """
  method(
    "sendVideo",
    [
      {:chat_id, :integer | String},
      {:video, InputFile | String},
      {:duration, :integer, :optional},
      {:width, :integer, :optional},
      {:height, :integer, :optional},
      {:thumb, InputFile | String, :optional},
      {:caption, String, :optional},
      {:parse_mode, String, :optional},
      {:supports_streaming, :boolean, :optional},
      {:disable_notification, :boolean, :optional},
      {:reply_to_message_id, :integer, :optional},
      {:reply_markup,
       InlineKeyboardMarkup | ReplyKeyboardMarkup | ReplyKeyboardRemove | ForceReply, :optional}
    ],
    Message
  )

  @doc """
  Use this method to send animation files (GIF or H.264/MPEG-4 AVC video without sound).
  On success, the sent `Telegex.Model.Message` is returned.
  Bots can currently send animation files of up to 50 MB in size, this limit may be changed in the future.
  """
  method(
    "sendAnimation",
    [
      {:chat_id, :integer | String},
      {:animation, InputFile | String},
      {:duration, :integer, :optional},
      {:width, :integer, :optional},
      {:height, :integer, :optional},
      {:thumb, InputFile | String},
      {:caption, String, :optional},
      {:parse_mode, String, :optional},
      {:disable_notification, :boolean, :optional},
      {:reply_to_message_id, :integer, :optional},
      {:reply_markup,
       InlineKeyboardMarkup | ReplyKeyboardMarkup | ReplyKeyboardRemove | ForceReply, :optional}
    ],
    Message
  )

  @doc """
  Use this method to send audio files, if you want Telegram clients to display the file as a playable voice message.
  For this to work, your audio must be in an .OGG file encoded with OPUS (other formats may be sent as `Telegex.Model.Audio` or `Telegex.Model.Document`).
  On success, the sent `Telegex.Model.Message` is returned.
  Bots can currently send voice messages of up to 50 MB in size, this limit may be changed in the future.
  """
  method(
    "sendVoice",
    [
      {:chat_id, :integer | String},
      {:voice, InputFile | String},
      {:caption, String, :optional},
      {:parse_mode, String, :optional},
      {:duration, :integer, :optional},
      {:disable_notification, :boolean, :optional},
      {:reply_to_message_id, :integer, :optional},
      {:reply_markup,
       InlineKeyboardMarkup | ReplyKeyboardMarkup | ReplyKeyboardRemove | ForceReply, :optional}
    ],
    Message
  )

  @doc """
  As of [v.4.0](https://telegram.org/blog/video-messages-and-telescope),
  Telegram clients support rounded square mp4 videos of up to 1 minute long.
  Use this method to send video messages. On success, the sent `Telegex.Model.Message` is returned.
  """
  method(
    "sendVideoNote",
    [
      {:chat_id, :integer | String},
      {:video_note, InputFile | String},
      {:duration, :integer, :optional},
      {:length, :integer, :optional},
      {:thumb, InputFile | String, :optional},
      {:disable_notification, :boolean, :optional},
      {:reply_to_message_id, :integer, :optional},
      {:reply_markup,
       InlineKeyboardMarkup | ReplyKeyboardMarkup | ReplyKeyboardRemove | ForceReply, :optional}
    ],
    Message
  )

  @doc """
  Use this method to send a group of photos or videos as an album. On success, an array of the sent `[Telegex.Model.Message]` is returned.
  """
  method(
    "sendMediaGroup",
    [
      {:chat_id, :integer | String},
      {:media, [InputMediaPhoto | InputMediaVideo]},
      {:disable_notification, :boolean, :optional},
      {:reply_to_message_id, :integer, :optional}
    ],
    [Message]
  )

  @doc """
  Use this method to send point on the map. On success, the sent `Telegex.Model.Message` is returned.
  """
  method(
    "sendLocation",
    [
      {:chat_id, :integer | String},
      {:latitude, :float},
      {:longitude, :float},
      {:live_period, :integer, :optional},
      {:disable_notification, :boolean, :optional},
      {:reply_to_message_id, :integer, :optional},
      {:reply_markup,
       InlineKeyboardMarkup | ReplyKeyboardMarkup | ReplyKeyboardRemove | ForceReply, :optional}
    ],
    Message
  )

  @doc """
  Use this method to edit live location messages.
  A location can be edited until its live_period expires or editing is explicitly disabled by a call to [stopMessageLiveLocation](https://core.telegram.org/bots/api#stopmessagelivelocation).
  On success, if the edited message was sent by the bot, the edited `Telegex.Model.Message` is returned, otherwise True is returned.
  """
  method(
    "editMessageLiveLocation",
    [
      {:chat_id, :integer | String, :optional},
      {:message_id, :integer, :optional},
      {:inline_message_id, String, :optional},
      {:latitude, :float},
      {:longitude, :float},
      {:reply_markup, InlineKeyboardMarkup, :optional}
    ],
    Message | :boolean
  )

  @doc """
  Use this method to stop updating a live location message before live_period expires.
  On success, if the message was sent by the bot, the sent `Telegex.Model.Message` is returned, otherwise True is returned.
  """
  method(
    "stopMessageLiveLocation",
    [
      {:chat_id, :integer | String, :optional},
      {:message_id, :integer, :optional},
      {:inline_message_id, String, :optional},
      {:reply_markup, InlineKeyboardMarkup, :optional}
    ],
    Message | :boolean
  )

  @doc """
  Use this method to send information about a venue. On success, the sent `Telegex.Model.Message` is returned.
  """
  method(
    "sendVenue",
    [
      {:chat_id, :integer | String},
      {:latitude, :float},
      {:longitude, :float},
      {:title, String},
      {:address, String},
      {:foursquare_id, String, :optional},
      {:foursquare_type, String, :optional},
      {:disable_notification, :boolean, :optional},
      {:reply_to_message_id, :integer, :optional},
      {:reply_markup,
       InlineKeyboardMarkup | ReplyKeyboardMarkup | ReplyKeyboardRemove | ForceReply, :optional}
    ],
    Message
  )

  @doc """
  Use this method to send phone contacts. On success, the sent `Telegex.Model.Message` is returned.
  """
  method(
    "sendContact",
    [
      {:chat_id, :integer | String},
      {:phone_number, String},
      {:first_name, String},
      {:last_name, String, :optional},
      {:vcard, String, :optional},
      {:disable_notification, :boolean, :optional},
      {:reply_to_message_id, :integer, :optional},
      {:reply_markup,
       InlineKeyboardMarkup | ReplyKeyboardMarkup | ReplyKeyboardRemove | ForceReply, :optional}
    ],
    Message
  )

  @doc """
  Use this method to send a native poll. On success, the sent `Telegex.Model.Message` is returned.
  """
  method(
    "sendPoll",
    [
      {:chat_id, :integer | String},
      {:question, String},
      {:options, [String]},
      {:is_anonymous, :boolean, :optional},
      {:type, String, :optional},
      {:allows_multiple_answers, :boolean, :optional},
      {:correct_option_id, :integer, :optional},
      {:explanation, String, :optional},
      {:explanation_parse_mode, String, :optional},
      {:open_period, :integer, :optional},
      {:close_date, :integer, :optional},
      {:is_closed, :boolean, :optional},
      {:disable_notification, :boolean, :optional},
      {:reply_to_message_id, :integer, :optional},
      {:reply_markup,
       InlineKeyboardMarkup | ReplyKeyboardMarkup | ReplyKeyboardRemove | ForceReply, :optional}
    ],
    Message
  )

  @doc """
  Use this method to send an animated emoji that will display a random value.On success, the sent `Telegex.Model.Message` is returned.
  """
  method(
    "sendDice",
    [
      {:chat_id, :integer | String},
      {:emoji, String, :optional},
      {:disable_notification, :boolean, :optional},
      {:reply_to_message_id, :integer, :optional},
      {:reply_markup,
       InlineKeyboardMarkup | ReplyKeyboardMarkup | ReplyKeyboardRemove | ForceReply, :optional}
    ],
    Message
  )

  @doc """
  Use this method when you need to tell the user that something is happening on the bot's side.
  The status is set for 5 seconds or less (when a message arrives from your bot,
  Telegram clients clear its typing status). Returns True on success.
  """
  method(
    "sendChatAction",
    [
      {:chat_id, :integer | String},
      {:action, String}
    ],
    :boolean
  )

  @doc """
  Use this method to get a list of profile pictures for a user. Returns a `Telegex.Model.UserProfilePhotos` object.
  """
  method(
    "getUserProfilePhotos",
    [
      {:user_id, :integer},
      {:offset, :integer, :optional},
      {:limit, :integer, :optional}
    ],
    UserProfilePhotos
  )

  @doc """
  Use this method to get basic info about a file and prepare it for downloading.
  For the moment, bots can download files of up to 20MB in size. On success, a `Telegex.Model.File` object is returned.
  The file can then be downloaded via the link https://api.telegram.org/file/bot<token>/<file_path>,
  where <file_path> is taken from the response. It is guaranteed that the link will be valid for at least 1 hour.
  When the link expires, a new one can be requested by calling getFile again.
  """
  method(
    "getFile",
    [
      {:file_id, String}
    ],
    File
  )

  @doc """
  Use this method to kick a user from a group, a supergroup or a channel. In the case of supergroups and channels,
  the user will not be able to return to the group on their own using invite links, etc., unless [unbanned](https://core.telegram.org/bots/api#unbanchatmember) first.
  The bot must be an administrator in the chat for this to work and must have the appropriate admin rights.
  Returns True on success.
  """
  method(
    "kickChatMember",
    [
      {:chat_id, :integer | String},
      {:user_id, :integer},
      {:until_date, :integer, :optional}
    ],
    :boolean
  )

  @doc """
  Use this method to unban a previously kicked user in a supergroup or channel.
  The user will not return to the group or channel automatically,
  but will be able to join via link, etc. The bot must be an administrator for this to work. Returns True on success.
  """
  method(
    "unbanChatMember",
    [
      {:chat_id, :integer | String},
      {:user_id, :integer}
    ],
    :boolean
  )

  @doc """
  Use this method to restrict a user in a supergroup.
  The bot must be an administrator in the supergroup for this to work and must have the appropriate admin rights.
  Pass True for all permissions to lift restrictions from a user. Returns True on success.
  """
  method(
    "restrictChatMember",
    [
      {:chat_id, :integer | String},
      {:user_id, :integer},
      {:permissions, ChatPermissions},
      {:until_date, :integer, :optional}
    ],
    :boolean
  )

  method("promoteChatMember", [], :boolean)
  method("setChatAdministratorCustomTitle", [], :boolean)
  method("setChatPermissions", [], :boolean)
  method("exportChatInviteLink", [], :boolean)
  method("setChatPhoto", [], :boolean)
  method("deleteChatPhoto", [], :boolean)
  method("setChatTitle", [], :boolean)
  method("setChatDescription", [], :boolean)
  method("pinChatMessage", [], :boolean)
  method("unpinChatMessage", [], :boolean)

  @doc """
  Use this method for your bot to leave a group, supergroup or channel. Returns True on success.
  """
  method(
    "leaveChat",
    [
      {:chat_id, :integer | String}
    ],
    :boolean
  )

  @doc """
  Use this method to get up to date information about the chat (current name of the user for one-on-one conversations,
  current username of a user, group or channel, etc.). Returns a `Telegex.Model.Chat` object on success.
  """
  method(
    "getChat",
    [
      {:chat_id, :integer | String}
    ],
    Chat
  )

  @doc """
  Use this method to get a list of administrators in a chat. On success,
  returns an Array of `Telegex.Model.ChatMember` objects that contains information about all chat administrators except other bots.
  If the chat is a group or a supergroup and no administrators were appointed, only the creator will be returned.
  """
  method(
    "getChatAdministrators",
    [
      {:chat_id, :integer | String}
    ],
    [ChatMember]
  )

  method("getChatMembersCount", [], :integer)

  @doc """
  Use this method to get information about a member of a chat.
  Returns a `Telegex.Model.ChatMember` object on success.
  """
  method(
    "getChatMember",
    [
      {:chat_id, :integer | String},
      {:user_id, :integer}
    ],
    ChatMember
  )

  method("setChatStickerSet", [], :boolean)
  method("deleteChatStickerSet", [], :boolean)

  @doc """
  Use this method to send answers to callback queries sent from [inline keyboards](https://core.telegram.org/bots#inline-keyboards-and-on-the-fly-updating).
  The answer will be displayed to the user as a notification at the top of the chat screen or as an alert.
  On success, True is returned.
  """
  method(
    "answerCallbackQuery",
    [
      {:callback_query_id, String},
      {:text, String, :optional},
      {:show_alert, :boolean, :optional},
      {:url, String, :optional},
      {:cache_time, :integer, :optional}
    ],
    :boolean
  )

  method("setMyCommands", [], :boolean)
  method("getMyCommands", [], [BotCommand])

  @doc """
  Use this method to edit text and [game](https://core.telegram.org/bots/api#games) messages.
  On success, if edited message is sent by the bot,
  the edited Message is returned, otherwise True is returned.
  """
  method(
    "editMessageText",
    [
      {:chat_id, :integer | String, :optional},
      {:message_id, :integer, :optional},
      {:inline_message_id, String, :optional},
      {:text, String},
      {:parse_mode, String, :optional},
      {:disable_web_page_preview, :boolean, :optional},
      {:reply_markup, InlineKeyboardMarkup, :optional}
    ],
    Message | :boolean
  )

  @doc """
  Use this method to delete a message, including service messages, with the following limitations:
  - A message can only be deleted if it was sent less than 48 hours ago.
  - A dice message in a private chat can only be deleted if it was sent more than 24 hours ago.
  - Bots can delete outgoing messages in private chats, groups, and supergroups.
  - Bots can delete incoming messages in private chats.
  - Bots granted can_post_messages permissions can delete outgoing messages in channels.
  - If the bot is an administrator of a group, it can delete any message there.
  - If the bot has can_delete_messages permission in a supergroup or a channel, it can delete any message there.
  Returns True on success.
  """
  method(
    "deleteMessage",
    [
      {:chat_id, :integer | String},
      {:message_id, :integer}
    ],
    :boolean
  )

  # Convert the accumulated attribute value to `map`.
  # Note: This attribute needs to be defined after all `Telex.DSL.method/3` calls.
  @include_attachment_methods_mapping @include_attachment_methods_meta
                                      |> Enum.into(%{})
                                      |> Attachment.supplement_attach_syntax_support()

  # Access attachment fields by method name.
  # Note: This function needs to be defined after all `Telex.DSL.method/3` calls.
  @doc false
  def __attachments__(method) when is_binary(method) do
    @include_attachment_methods_mapping[method]
  end

  # Get all methods and fields containing attachments.
  # Note: This function needs to be defined after all `Telex.DSL.method/3` calls.
  @doc false
  def __attachments__, do: @include_attachment_methods_mapping
end
