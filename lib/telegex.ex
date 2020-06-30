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
  Use this method to send a group of photos or videos as an album. On success, an array of the sent `Telegex.Model.Message` is returned.
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

  @doc """
  Use this method to promote or demote a user in a supergroup or a channel.
  The bot must be an administrator in the chat for this to work and must have the appropriate admin rights.
  Pass False for all boolean parameters to demote a user. Returns True on success.
  """
  method(
    "promoteChatMember",
    [
      {:chat_id, :integer | String},
      {:user_id, :integer},
      {:can_change_info, :boolean, :optional},
      {:can_post_messages, :boolean, :optional},
      {:can_edit_messages, :boolean, :optional},
      {:can_delete_messages, :boolean, :optional},
      {:can_invite_users, :boolean, :optional},
      {:can_restrict_members, :boolean, :optional},
      {:can_pin_messages, :boolean, :optional},
      {:can_promote_members, :boolean, :optional}
    ],
    :boolean
  )

  @doc """
  Use this method to set a custom title for an administrator in a supergroup promoted by the bot.
  Returns True on success.
  """
  method(
    "setChatAdministratorCustomTitle",
    [
      {:chat_id, :integer | String},
      {:user_id, :integer},
      {:custom_title, String}
    ],
    :boolean
  )

  @doc """
  Use this method to set default chat permissions for all members.
  The bot must be an administrator in the group or a supergroup for this to work
  and must have the can_restrict_members admin rights. Returns True on success.
  """
  method(
    "setChatPermissions",
    [
      {:chat_id, :integer | String},
      {:permissions, ChatPermissions}
    ],
    :boolean
  )

  @doc """
  Use this method to generate a new invite link for a chat; any previously generated link is revoked.
  The bot must be an administrator in the chat for this to work and must have the appropriate admin rights.
  Returns the new invite link as `String` on success.
  """
  method(
    "exportChatInviteLink",
    [
      {:chat_id, :integer | String}
    ],
    String
  )

  @doc """
  Use this method to set a new profile photo for the chat. Photos can't be changed for private chats.
  The bot must be an administratorin the chat for this to work and must have the appropriate admin rights.
  Returns True on success.
  """
  method(
    "setChatPhoto",
    [
      {:chat_id, :integer | String},
      {:photo, InputFile}
    ],
    :boolean
  )

  @doc """
  Use this method to delete a chat photo. Photos can't be changed for private chats.
  The bot must be an administrator in the chat for this to work and must have the appropriate admin rights.
  Returns True on success.
  """
  method(
    "deleteChatPhoto",
    [
      {:chat_id, :integer | String}
    ],
    :boolean
  )

  @doc """
  Use this method to change the title of a chat. Titles can't be changed for private chats.
  The bot must be an administrator in the chat for this to work and must have the appropriate admin rights.
  Returns True on success.
  """
  method(
    "setChatTitle",
    [
      {:chat_id, :integer | String},
      {:title, String}
    ],
    :boolean
  )

  @doc """
  Use this method to change the description of a group, a supergroup or a channel.
  The bot must be an administrator in the chat for this to work and must have the appropriate admin rights.
  Returns True on success.
  """
  method(
    "setChatDescription",
    [
      {:chat_id, :integer | String},
      {:description, String, :optional}
    ],
    :boolean
  )

  @doc """
  Use this method to pin a message in a group, a supergroup, or a channel. The bot must be an administrator
  in the chat for this to work and must have the 'can_pin_messages' admin right in the supergroup
  or 'can_edit_messages' admin right in the channel. Returns True on success.
  """
  method(
    "pinChatMessage",
    [
      {:chat_id, :integer | String},
      {:message_id, :integer},
      {:disable_notification, :boolean, :optional}
    ],
    :boolean
  )

  @doc """
  Use this method to unpin a message in a group, a supergroup, or a channel. The bot must be an administrator
  in the chat for this to work and must have the 'can_pin_messages' admin right in the supergroup
  or 'can_edit_messages' admin right in the channel. Returns True on success.
  """
  method(
    "unpinChatMessage",
    [
      {:chat_id, :integer | String}
    ],
    :boolean
  )

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

  @doc """
  Use this method to get the number of members in a chat. Returns Int on success.
  """
  method(
    "getChatMembersCount",
    [
      {:chat_id, :integer | String}
    ],
    :integer
  )

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

  @doc """
  Use this method to set a new group sticker set for a supergroup. The bot must be an administrator
  in the chat for this to work and must have the appropriate admin rights.
  Use the field can_set_sticker_set optionally returned in getChat requests to check if the bot can use this method.
  Returns True on success.
  """
  method(
    "setChatStickerSet",
    [
      {:chat_id, :integer | String},
      {:sticker_set_name, String}
    ],
    :boolean
  )

  @doc """
  Use this method to delete a group sticker set from a supergroup. The bot must be an administrator
  in the chat for this to work and must have the appropriate admin rights.
  Use the field can_set_sticker_set optionally returned in getChat requests to check if the bot can use this method.
  Returns True on success.
  """
  method(
    "deleteChatStickerSet",
    [
      {:chat_id, :integer | String}
    ],
    :boolean
  )

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

  @doc """
  Use this method to change the list of the bot's commands. Returns True on success.
  """
  method(
    "setMyCommands",
    [
      {:commands, [BotCommand]}
    ],
    :boolean
  )

  @doc """
  Use this method to get the current list of the bot's commands.
  Requires no parameters. Returns Array of `Telegex.Model.BotCommand` on success.
  """
  method("getMyCommands", [], [BotCommand])

  @doc """
  Use this method to edit text and [game](https://core.telegram.org/bots/api#games) messages.
  On success, if edited message is sent by the bot,
  the edited `Telegex.Model.Message` is returned, otherwise True is returned.
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
  Use this method to edit captions of messages. On success,
  if edited message is sent by the bot, the edited `Telegex.Model.Message` is returned, otherwise True is returned.
  """
  method(
    "editMessageCaption",
    [
      {:chat_id, :integer | String, :optional},
      {:message_id, :integer, :optional},
      {:inline_message_id, String, :optional},
      {:caption, String, :optional},
      {:parse_mode, String, :optional},
      {:reply_markup, InlineKeyboardMarkup, :optional}
    ],
    Message
  )

  @doc """
  Use this method to edit animation, audio, document, photo, or video messages.
  If a message is a part of a message album, then it can be edited only to a photo or a video.
  Otherwise, message type can be changed arbitrarily. When inline message is edited, new file can't be uploaded.
  Use previously uploaded file via its file_id or specify a URL.
  On success, if the edited message was sent by the bot, the edited `Telegex.Model.Message` is returned, otherwise True is returned.
  """
  method(
    "editMessageMedia",
    [
      {:chat_id, :integer | String, :optional},
      {:message_id, :integer, :optional},
      {:inline_message_id, String, :optional},
      {:media, InputMedia},
      {:reply_markup, InlineKeyboardMarkup, :optional}
    ],
    Message
  )

  @doc """
  Use this method to edit only the reply markup of messages. On success, if edited message is sent by the bot,
  the edited `Telegex.Model.Message` is returned, otherwise True is returned.
  """
  method(
    "editMessageReplyMarkup",
    [
      {:chat_id, :integer | String, :optional},
      {:message_id, :integer, :optional},
      {:inline_message_id, String, :optional},
      {:reply_markup, InlineKeyboardMarkup, :optional}
    ],
    Message
  )

  @doc """
  Use this method to stop a poll which was sent by the bot.
  On success, the stopped `Telegex.Model.Poll` with the final results is returned.
  """
  method(
    "stopPoll",
    [
      {:chat_id, :integer | String},
      {:message_id, :integer},
      {:reply_markup, InlineKeyboardMarkup, :optional}
    ],
    Poll
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

  @doc """
  Use this method to send static .WEBP or [animated](https://telegram.org/blog/animated-stickers) .TGS stickers.
  On success, the sent `Telegex.Model.Message` is returned.
  """
  method(
    "sendSticker",
    [
      {:chat_id, :integer | String},
      {:sticker, InputFile | String},
      {:disable_notification, :boolean, :optional},
      {:reply_to_message_id, :integer, :optional},
      {:reply_markup,
       InlineKeyboardMarkup | ReplyKeyboardMarkup | ReplyKeyboardRemove | ForceReply, :optional}
    ],
    Message
  )

  @doc """
  Use this method to get a sticker set. On success, a `Telegex.Model.StickerSet` object is returned.
  """
  method(
    "getStickerSet",
    [
      {:name, String}
    ],
    StickerSet
  )

  @doc """
  Use this method to upload a .PNG file with a sticker for later use in createNewStickerSet
  and addStickerToSet methods (can be used multiple times). Returns the uploaded `Telegex.Model.File` on success.
  """
  method(
    "uploadStickerFile",
    [
      {:user_id, :integer},
      {:png_sticker, InputFile}
    ],
    File
  )

  @doc """
  Use this method to create a new sticker set owned by a user. The bot will be able to edit the sticker set thus created.
  You must use exactly one of the fields png_sticker or tgs_sticker. Returns True on success.
  """
  method(
    "createNewStickerSet",
    [
      {:user_id, :integer},
      {:name, String},
      {:title, String},
      {:png_sticker, InputFile | String, :optional},
      {:tgs_sticker, InputFile, :optional},
      {:emojis, String},
      {:contains_masks, :boolean, :optional},
      {:mask_position, MaskPosition, :optional}
    ],
    :boolean
  )

  @doc """
  Use this method to add a new sticker to a set created by the bot. You must use exactly one of the fields png_sticker
  or tgs_sticker. Animated stickers can be added to animated sticker sets and only to them.
  Animated sticker sets can have up to 50 stickers. Static sticker sets can have up to 120 stickers.
  Returns True on success.
  """
  method(
    "addStickerToSet",
    [
      {:user_id, :integer},
      {:name, String},
      {:png_sticker, InputFile | String, :optional},
      {:tgs_sticker, InputFile, :optional},
      {:emojis, String},
      {:mask_position, MaskPosition, :optional}
    ],
    :boolean
  )

  @doc """
  Use this method to move a sticker in a set created by the bot to a specific position. Returns True on success.
  """
  method(
    "setStickerPositionInSet",
    [
      {:sticker, String},
      {:position, :integer}
    ],
    :boolean
  )

  @doc """
  Use this method to delete a sticker from a set created by the bot. Returns True on success.
  """
  method(
    "deleteStickerFromSet",
    [
      {:sticker, String}
    ],
    :boolean
  )

  @doc """
  Use this method to set the thumbnail of a sticker set. Animated thumbnails can be set for animated sticker sets only.
  Returns True on success.
  """
  method(
    "setStickerSetThumb",
    [
      {:sticker, String},
      {:user_id, :integer},
      {:thumb, InputFile | String, :optional}
    ],
    :boolean
  )

  @doc """
  Use this method to send invoices. On success, the sent `Telegex.Model.Message` is returned.
  """
  method(
    "sendInvoice",
    [
      {:chat_id, :integer},
      {:title, String},
      {:description, String},
      {:payload, String},
      {:provider_token, String},
      {:start_parameter, String},
      {:currency, String},
      {:prices, [LabeledPrice]},
      {:provider_data, String, :optional},
      {:photo_url, String, :optional},
      {:photo_size, :integer, :optional},
      {:photo_width, :integer, :optional},
      {:photo_height, :integer, :optional},
      {:need_name, :boolean, :optional},
      {:need_phone_number, :boolean, :optional},
      {:need_email, :boolean, :optional},
      {:need_shipping_address, :boolean, :optional},
      {:send_phone_number_to_provider, :boolean, :optional},
      {:send_email_to_provider, :boolean, :optional},
      {:is_flexible, :boolean, :optional},
      {:disable_notification, :boolean, :optional},
      {:reply_to_message_id, :integer, :optional},
      {:reply_markup, InlineKeyboardMarkup, :optional}
    ],
    Message
  )

  @doc """
  f you sent an invoice requesting a shipping address and the parameter is_flexible was specified,
  the Bot API will send an `Telegex.Model.Update` with a `shipping_query` field to the bot.
  Use this method to reply to shipping queries. On success, True is returned.
  """
  method(
    "answerShippingQuery",
    [
      {:shipping_query_id, String},
      {:ok, :boolean},
      {:shipping_options, [ShippingOption], :optional},
      {:error_message, String, :optional}
    ],
    :boolean
  )

  @doc """
  Once the user has confirmed their payment and shipping details, the Bot API sends the final confirmation
  in the form of an `Telegex.Model.Update` with the field pre_checkout_query.
  Use this method to respond to such pre-checkout queries. On success, True is returned.
  **Note**: The Bot API must receive an answer within 10 seconds after the pre-checkout query was sent.
  """
  method(
    "answerPreCheckoutQuery",
    [
      {:pre_checkout_query_id, String},
      {:ok, :boolean},
      {:error_message, String, :optional}
    ],
    :boolean
  )

  # Convert the accumulated attribute value to `map`.
  # **Note**: This attribute needs to be defined after all `Telex.DSL.method/3` calls.
  @include_attachment_methods_mapping @include_attachment_methods_meta
                                      |> Enum.into(%{})
                                      |> Attachment.supplement_attach_syntax_support()

  # Access attachment fields by method name.
  # **Note**: This function needs to be defined after all `Telex.DSL.method/3` calls.
  @doc false
  def __attachments__(method) when is_binary(method) do
    @include_attachment_methods_mapping[method]
  end

  # Get all methods and fields containing attachments.
  # **Note**: This function needs to be defined after all `Telex.DSL.method/3` calls.
  @doc false
  def __attachments__, do: @include_attachment_methods_mapping
end
