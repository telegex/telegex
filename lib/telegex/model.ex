defmodule Telegex.Model do
  @moduledoc """
  All types used in Bot API response.
  """

  import Telegex.DSL, only: [model: 2]

  defmodule InputMedia do
    @moduledoc """
    This object represents the content of a media message to be sent.
    """
    @type t ::
            Telegex.Model.InputMediaAnimation.t()
            | Telegex.Model.InputMediaDocument.t()
            | Telegex.Model.InputMediaAudio.t()
            | Telegex.Model.InputMediaPhoto.t()
            | Telegex.Model.InputMediaVideo.t()
  end

  defmodule InputFile do
    @moduledoc """
    This object represents the contents of a file to be uploaded.
    Must be posted using multipart/form-data in the usual way that files are uploaded via the browser.
    """
    @type t :: Path.t()
  end

  defmodule InputMessageContent do
    @moduledoc """
    This object represents the content of a message to be sent as a result of an inline query.
    """
    @type t ::
            Telegex.Model.InputTextMessageContent.t()
            | Telegex.Model.InputLocationMessageContent.t()
            | Telegex.Model.InputVenueMessageContent.t()
            | Telegex.Model.InputContactMessageContent.t()
  end

  defmodule PassportElementError do
    @moduledoc """
    This object represents an error in the Telegram Passport element which was submitted
    that should be resolved by the user.
    """
    @type t ::
            Telegex.Model.PassportElementErrorDataField.t()
            | Telegex.Model.PassportElementErrorFrontSide.t()
            | Telegex.Model.PassportElementErrorReverseSide.t()
            | Telegex.Model.PassportElementErrorSelfie.t()
            | Telegex.Model.PassportElementErrorFile.t()
            | Telegex.Model.PassportElementErrorFiles.t()
            | Telegex.Model.PassportElementErrorTranslationFile.t()
            | Telegex.Model.PassportElementErrorTranslationFiles.t()
            | Telegex.Model.PassportElementErrorUnspecified.t()
  end

  @type errors :: Telegex.Model.Error.t() | Telegex.Model.RequestError.t()

  model WebhookInfo, [
    {:url, String},
    {:has_custom_certificate, :boolean},
    {:pending_update_count, :integer},
    {:ip_address, String, :optional},
    {:last_error_date, :integer, :optional},
    {:last_error_message, String, :optional},
    {:max_connections, :integer, :optional},
    {:allowed_updates, [String], :optional}
  ]

  model User, [
    {:id, :integer},
    {:is_bot, :boolean},
    {:first_name, String},
    {:last_name, String, :optional},
    {:username, String, :optional},
    {:language_code, String, :optional},
    {:can_join_groups, :boolean, :optional},
    {:can_read_all_group_messages, :boolean, :optional},
    {:supports_inline_queries, :boolean, :optional}
  ]

  model Chat, [
    {:id, :integer},
    {:type, String},
    {:title, String, :optional},
    {:username, String, :optional},
    {:first_name, String, :optional},
    {:last_name, String, :optional},
    {:photo, ChatPhoto, :optional},
    {:description, String, :optional},
    {:invite_link, String, :optional},
    {:pinned_message, Message, :optional},
    {:permissions, ChatPermissions, :optional},
    {:slow_mode_delay, :integer, :optional},
    {:sticker_set_name, String, :optional},
    {:can_set_sticker_set, :boolean, :optional},
    {:location, ChatLocation, :optional}
  ]

  model Message, [
    {:message_id, :integer},
    {:from, User},
    {:sender_chat, Chat, :optional},
    {:date, :integer},
    {:chat, Chat},
    {:forward_from, User, :optional},
    {:forward_from_chat, Chat, :optional},
    {:forward_from_message_id, :integer, :optional},
    {:forward_signature, String, :optional},
    {:forward_sender_name, String, :optional},
    {:forward_date, :integer, :optional},
    {:reply_to_message, Message, :optional},
    {:via_bot, User, :optional},
    {:edit_date, :integer, :optional},
    {:media_group_id, String, :optional},
    {:author_signature, String, :optional},
    {:text, String, :optional},
    {:entities, [MessageEntity], :optional},
    {:animation, Animation, :optional},
    {:audio, Audio, :optional},
    {:document, Document, :optional},
    {:photo, [PhotoSize], :optional},
    {:sticker, Sticker, :optional},
    {:video, Video, :optional},
    {:video_note, VideoNote, :optional},
    {:voice, Voice, :optional},
    {:caption, String, :optional},
    {:caption_entities, [MessageEntity], :optional},
    {:contact, Contact, :optional},
    {:dice, Dice, :optional},
    {:game, Game, :optional},
    {:poll, Poll, :optional},
    {:venue, Venue, :optional},
    {:location, Location, :optional},
    {:new_chat_members, [User], :optional},
    {:left_chat_member, User, :optional},
    {:new_chat_title, String, :optional},
    {:new_chat_photo, [PhotoSize], :optional},
    {:delete_chat_photo, :boolean, :optional},
    {:group_chat_created, :boolean, :optional},
    {:supergroup_chat_created, :boolean, :optional},
    {:channel_chat_created, :boolean, :optional},
    {:message_auto_delete_timer_changed, MessageAutoDeleteTimerChanged, :optional},
    {:migrate_to_chat_id, :integer, :optional},
    {:migrate_from_chat_id, :integer, :optional},
    {:pinned_message, Message, :optional},
    {:invoice, Invoice, :optional},
    {:successful_payment, SuccessfulPayment, :optional},
    {:connected_website, String, :optional},
    {:passport_data, PassportData, :optional},
    {:proximity_alert_triggered, ProximityAlertTriggered, :optional},
    {:voice_chat_started, VoiceChatStarted, :optional},
    {:voice_chat_ended, VoiceChatEnded, :optional},
    {:voice_chat_participants_invited, VoiceChatParticipantsInvited, :optional},
    {:reply_markup, InlineKeyboardMarkup, :optional}
  ]

  model MessageId, [
    {:message_id, :integer}
  ]

  model MessageEntity, [
    {:type, String},
    {:offset, :integer},
    {:length, :integer},
    {:url, String, :optional},
    {:user, User, :optional},
    {:language, String, :optional}
  ]

  model PhotoSize, [
    {:file_id, String},
    {:file_unique_id, String},
    {:width, :integer},
    {:height, :integer},
    {:file_size, :integer, :optional}
  ]

  model Animation, [
    {:file_id, String},
    {:file_unique_id, String},
    {:width, :integer},
    {:height, :integer},
    {:duration, :integer},
    {:thumb, PhotoSize, :optional},
    {:file_name, String, :optional},
    {:mime_type, String, :optional},
    {:file_size, :integer, :optional}
  ]

  model Audio, [
    {:file_id, String},
    {:file_unique_id, String},
    {:duration, :integer},
    {:performer, String, :optional},
    {:title, String, :optional},
    {:file_name, String, :optional},
    {:mime_type, String, :optional},
    {:file_size, :integer, :optional},
    {:thumb, PhotoSize, :optional}
  ]

  model Document, [
    {:file_id, String},
    {:file_unique_id, String},
    {:thumb, PhotoSize, :optional},
    {:file_name, String, :optional},
    {:mime_type, String, :optional},
    {:file_size, :integer, :optional}
  ]

  model Video, [
    {:file_id, String},
    {:file_unique_id, String},
    {:width, :integer},
    {:height, :integer},
    {:duration, :integer},
    {:thumb, PhotoSize, :optional},
    {:file_name, String, :optional},
    {:mime_type, String, :optional},
    {:file_size, :integer, :optional}
  ]

  model VideoNote, [
    {:file_id, String},
    {:file_unique_id, String},
    {:length, :integer},
    {:duration, :integer},
    {:thumb, PhotoSize, :optional},
    {:file_size, :integer, :optional}
  ]

  model Voice, [
    {:file_id, String},
    {:file_unique_id, String},
    {:duration, :integer},
    {:mime_type, String, :optional},
    {:file_size, :integer, :optional}
  ]

  model Contact, [
    {:phone_number, String},
    {:first_name, String},
    {:last_name, String},
    {:user_id, :integer},
    {:vcard, String}
  ]

  model Dice, [
    {:emoji, String},
    {:value, :integer}
  ]

  model PollOption, [
    {:text, String},
    {:voter_count, :integer}
  ]

  model PollAnswer, [
    {:poll_id, String},
    {:user, User},
    {:option_ids, [:integer]}
  ]

  model Poll, [
    {:id, String},
    {:question, String},
    {:options, [PollOption]},
    {:total_voter_count, :integer},
    {:is_closed, :boolean},
    {:is_anonymous, :boolean},
    {:type, String},
    {:allows_multiple_answers, :boolean},
    {:correct_option_id, :integer, :optional},
    {:explanation, String, :optional},
    {:explanation_entities, [MessageEntity], :optional},
    {:open_period, :integer, :optional},
    {:close_date, :integer, :optional}
  ]

  model Location, [
    {:longitude, :float},
    {:latitude, :float},
    {:horizontal_accuracy, :float, :optional},
    {:live_period, :integer, :optional},
    {:heading, :integer, :optional},
    {:proximity_alert_radius, :integer, :optional}
  ]

  model Venue, [
    {:location, Location},
    {:title, String},
    {:address, String},
    {:foursquare_id, String, :optional},
    {:foursquare_type, String, :optional},
    {:google_place_id, String, :optional},
    {:google_place_type, String, :optional}
  ]

  model ProximityAlertTriggered, [
    {:traveler, User},
    {:watcher, User},
    {:distance, :integer}
  ]

  model MessageAutoDeleteTimerChanged, [
    {:message_auto_delete_time, :integer}
  ]

  model VoiceChatStarted, []

  model VoiceChatEnded, [
    {:duration, :integer}
  ]

  model VoiceChatParticipantsInvited, [
    {:users, [User], :optional}
  ]

  model UserProfilePhotos, [
    {:total_count, :integer},
    {:photos, [PhotoSize]}
  ]

  model File, [
    {:file_id, String},
    {:file_unique_id, String},
    {:file_size, :integer, :optional},
    {:file_path, String, :optional}
  ]

  model ReplyKeyboardMarkup, [
    {:keyboard, [[KeyboardButton]]},
    {:resize_keyboard, :boolean, :optional},
    {:one_time_keyboard, :boolean, :optional},
    {:selective, :boolean, :optional}
  ]

  model KeyboardButton, [
    {:text, String},
    {:request_contact, :boolean, :optional},
    {:request_location, :boolean, :optional},
    {:request_poll, KeyboardButtonPollType, :optional}
  ]

  model KeyboardButtonPollType, [
    {:type, String, :optional}
  ]

  model ReplyKeyboardRemove, [
    {:remove_keyboard, :boolean},
    {:selective, :boolean, :optional}
  ]

  model InlineKeyboardMarkup, [
    {:inline_keyboard, [[InlineKeyboardButton]]}
  ]

  model InlineKeyboardButton, [
    {:text, String},
    {:url, String, :optional},
    {:login_url, LoginUrl, :optional},
    {:callback_data, String, :optional},
    {:switch_inline_query, String, :optional},
    {:switch_inline_query_current_chat, String, :optional},
    {:callback_game, CallbackGame, :optional},
    {:pay, :boolean, :optional}
  ]

  model LoginUrl, [
    {:url, String},
    {:forward_text, String, :optional},
    {:bot_username, String, :optional},
    {:request_write_access, :boolean, :optional}
  ]

  model CallbackQuery, [
    {:id, String},
    {:from, User},
    {:message, Message, :optional},
    {:inline_message_id, String, :optional},
    {:chat_instance, String},
    {:data, String, :optional},
    {:game_short_name, String, :optional}
  ]

  model ForceReply, [
    {:force_reply, :boolean},
    {:selective, :boolean, :optional}
  ]

  model ChatPhoto, [
    {:small_file_id, String},
    {:small_file_unique_id, String},
    {:big_file_id, String},
    {:big_file_unique_id, String}
  ]

  model ChatInviteLink, [
    {:invite_link, String},
    {:creator, User},
    {:is_primary, :boolean},
    {:is_revoked, :boolean},
    {:expire_date, :integer, :optional},
    {:member_limit, :integer, :optional}
  ]

  model ChatMember, [
    {:user, User},
    {:status, String},
    {:custom_title, String, :optional},
    {:is_anonymous, :boolean, :optional},
    {:until_date, :integer, :optional},
    {:can_be_edited, :boolean, :optional},
    {:can_manage_chat, :boolean, :optional},
    {:can_post_messages, :boolean, :optional},
    {:can_edit_messages, :boolean, :optional},
    {:can_delete_messages, :boolean, :optional},
    {:can_manage_voice_chats, :boolean, :optional},
    {:can_restrict_members, :boolean, :optional},
    {:can_promote_members, :boolean, :optional},
    {:can_change_info, :boolean, :optional},
    {:can_invite_users, :boolean, :optional},
    {:can_pin_messages, :boolean, :optional},
    {:is_member, :boolean, :optional},
    {:can_send_messages, :boolean, :optional},
    {:can_send_media_messages, :boolean, :optional},
    {:can_send_polls, :boolean, :optional},
    {:can_send_other_messages, :boolean, :optional},
    {:can_add_web_page_previews, :boolean, :optional}
  ]

  model ChatMemberUpdated, [
    {:chat, Chat},
    {:from, User},
    {:data, :integer},
    {:old_chat_member, ChatMember},
    {:new_chat_member, ChatMember},
    {:invite_link, ChatInviteLink}
  ]

  model ChatPermissions, [
    {:can_send_messages, :boolean, :optional},
    {:can_send_media_messages, :boolean, :optional},
    {:can_send_polls, :boolean, :optional},
    {:can_send_other_messages, :boolean, :optional},
    {:can_add_web_page_previews, :boolean, :optional},
    {:can_change_info, :boolean, :optional},
    {:can_invite_users, :boolean, :optional},
    {:can_pin_messages, :boolean, :optional}
  ]

  model ChatLocation, [
    {:location, Location},
    {:address, String}
  ]

  model BotCommand, [
    {:command, String},
    {:description, String}
  ]

  model ResponseParameters, [
    {:migrate_to_chat_id, :integer, :optional},
    {:retry_after, :integer, :optional}
  ]

  model InputMediaPhoto, [
    {:type, String},
    {:media, String},
    {:caption, String, :optional},
    {:parse_mode, String, :optional},
    {:caption_entities, [MessageEntity], :optional}
  ]

  model InputMediaVideo, [
    {:type, String},
    {:media, String},
    {:thumb, InputFile | String, :optional},
    {:caption, String, :optional},
    {:parse_mode, String, :optional},
    {:caption_entities, [MessageEntity], :optional},
    {:width, :integer, :optional},
    {:height, :integer, :optional},
    {:duration, :integer, :optional},
    {:supports_streaming, :boolean, :optional}
  ]

  model InputMediaAnimation, [
    {:type, String},
    {:media, String},
    {:thumb, InputFile | String, :optional},
    {:caption, String, :optional},
    {:parse_mode, String, :optional},
    {:caption_entities, [MessageEntity], :optional},
    {:width, :integer, :optional},
    {:height, :integer, :optional},
    {:duration, :integer, :optional}
  ]

  model InputMediaAudio, [
    {:type, String},
    {:media, String},
    {:thumb, InputFile | String, :optional},
    {:caption, String, :optional},
    {:parse_mode, String, :optional},
    {:caption_entities, [MessageEntity], :optional},
    {:duration, :integer, :optional},
    {:performer, String, :optional},
    {:title, String, :optional}
  ]

  model InputMediaDocument, [
    {:type, String},
    {:media, String},
    {:thumb, InputFile | String, :optional},
    {:caption, String, :optional},
    {:parse_mode, String, :optional},
    {:caption_entities, [MessageEntity], :optional},
    {:disable_content_type_detection, :boolean, :optional}
  ]

  model LabeledPrice, [
    {:label, String},
    {:amount, :integer}
  ]

  model Invoice, [
    {:title, String},
    {:description, String},
    {:start_parameter, String},
    {:currency, String},
    {:total_amount, :integer}
  ]

  model ShippingAddress, [
    {:country_code, String},
    {:state, String},
    {:city, String},
    {:street_line1, String},
    {:street_line2, String},
    {:post_code, String}
  ]

  model OrderInfo, [
    {:name, String, :optional},
    {:phone_number, String, :optional},
    {:email, String, :optional},
    {:shipping_address, ShippingAddress, :optional}
  ]

  model ShippingOption, [
    {:id, String},
    {:title, String},
    {:prices, [LabeledPrice]}
  ]

  model SuccessfulPayment, [
    {:currency, String},
    {:total_amount, :integer},
    {:invoice_payload, String},
    {:shipping_option_id, String, :optional},
    {:order_info, OrderInfo, :optional},
    {:telegram_payment_charge_id, String},
    {:provider_payment_charge_id, String}
  ]

  model ShippingQuery, [
    {:id, String},
    {:from, User},
    {:invoice_payload, String},
    {:shipping_address, ShippingAddress}
  ]

  model PreCheckoutQuery, [
    {:id, String},
    {:from, User},
    {:currency, String},
    {:total_amount, :integer},
    {:invoice_payload, String},
    {:shipping_option_id, String, :optional},
    {:order_info, String, :optional}
  ]

  model Sticker, [
    {:file_id, String},
    {:file_unique_id, String},
    {:width, :integer},
    {:height, :integer},
    {:is_animated, :boolean},
    {:thumb, PhotoSize, :optional},
    {:emoji, String, :optional},
    {:set_name, String, :optional},
    {:mask_position, MaskPosition, :optional},
    {:file_size, :integer, :optional}
  ]

  model StickerSet, [
    {:name, String},
    {:title, String},
    {:is_animated, :boolean},
    {:contains_masks, :boolean},
    {:stickers, [Sticker]},
    {:thumb, PhotoSize, :optional}
  ]

  model MaskPosition, [
    {:point, String},
    {:x_shift, :float},
    {:y_shift, :float},
    {:scale, :float}
  ]

  model PassportData, [
    {:data, [EncryptedPassportElement]},
    {:credentials, EncryptedCredentials}
  ]

  model PassportFile, [
    {:file_id, String},
    {:file_unique_id, String},
    {:file_size, :integer},
    {:file_date, :integer}
  ]

  model EncryptedPassportElement, [
    {:type, String},
    {:data, String, :optional},
    {:phone_number, String, :optional},
    {:email, String, :optional},
    {:files, [PassportFile], :optional},
    {:front_side, PassportFile, :optional},
    {:reverse_side, PassportFile, :optional},
    {:selfie, PassportFile, :optional},
    {:translation, [PassportFile], :optional},
    {:hash, String}
  ]

  model EncryptedCredentials, [
    {:data, String},
    {:hash, String},
    {:secret, String}
  ]

  model PassportElementErrorDataField, [
    {:source, String},
    {:type, String},
    {:field_name, String},
    {:data_hash, String},
    {:message, String}
  ]

  model PassportElementErrorFrontSide, [
    {:source, String},
    {:type, String},
    {:file_hash, String},
    {:message, String}
  ]

  model PassportElementErrorReverseSide, [
    {:source, String},
    {:type, String},
    {:file_hash, String},
    {:message, String}
  ]

  model PassportElementErrorSelfie, [
    {:source, String},
    {:type, String},
    {:file_hash, String},
    {:message, String}
  ]

  model PassportElementErrorFile, [
    {:source, String},
    {:type, String},
    {:file_hash, String},
    {:message, String}
  ]

  model PassportElementErrorFiles, [
    {:source, String},
    {:type, String},
    {:file_hashes, [String]},
    {:message, String}
  ]

  model PassportElementErrorTranslationFile, [
    {:source, String},
    {:type, String},
    {:file_hash, String},
    {:message, String}
  ]

  model PassportElementErrorTranslationFiles, [
    {:source, String},
    {:type, String},
    {:file_hashes, [String]},
    {:message, String}
  ]

  model PassportElementErrorUnspecified, [
    {:source, String},
    {:type, String},
    {:element_hash, String},
    {:message, String}
  ]

  model Game, [
    {:title, String},
    {:description, String},
    {:photo, [PhotoSize]},
    {:text, String, :optional},
    {:text_entities, [MessageEntity], :optional},
    {:animation, Animation, :optional}
  ]

  model CallbackGame, []

  model GameHighScore, [
    {:position, :integer},
    {:user, User},
    {:score, :integer}
  ]

  model InlineQuery, [
    {:id, String},
    {:from, User},
    {:location, Location, :optional},
    {:query, String},
    {:offset, String}
  ]

  model InlineQueryResultArticle, [
    {:type, String},
    {:id, String},
    {:title, String},
    {:input_message_content, InputMessageContent},
    {:reply_markup, InlineKeyboardMarkup, :optional},
    {:url, String, :optional},
    {:hide_url, :boolean, :optional},
    {:description, String, :optional},
    {:thumb_url, String, :optional},
    {:thumb_width, :integer, :optional},
    {:thumb_height, :integer, :optional}
  ]

  model InlineQueryResultPhoto, [
    {:type, String},
    {:id, String},
    {:photo_url, String},
    {:thumb_url, String},
    {:photo_width, :integer, :optional},
    {:photo_height, :integer, :optional},
    {:title, String, :optional},
    {:description, String, :optional},
    {:caption, String, :optional},
    {:parse_mode, String, :optional},
    {:caption_entities, [MessageEntity], :optional},
    {:reply_markup, InlineKeyboardMarkup, :optional},
    {:input_message_content, InputMessageContent, :optional}
  ]

  model InlineQueryResultGif, [
    {:type, String},
    {:id, String},
    {:gif_url, String},
    {:gif_width, :integer, :optional},
    {:gif_height, :integer, :optional},
    {:gif_duration, :integer, :optional},
    {:thumb_url, String},
    {:thumb_mime_type, String, :optional},
    {:title, String, :optional},
    {:caption, String, :optional},
    {:caption_entities, [MessageEntity], :optional},
    {:parse_mode, String, :optional},
    {:reply_markup, InlineKeyboardMarkup, :optional},
    {:input_message_content, InputMessageContent, :optional}
  ]

  model InlineQueryResultMpeg4Gif, [
    {:type, String},
    {:id, String},
    {:mpeg4_url, String},
    {:mpeg4_width, :integer, :optional},
    {:mpeg4_height, :integer, :optional},
    {:mpeg4_duration, :integer, :optional},
    {:thumb_url, String},
    {:thumb_mime_type, String, :optional},
    {:title, String, :optional},
    {:caption, String, :optional},
    {:caption_entities, [MessageEntity], :optional},
    {:parse_mode, String, :optional},
    {:reply_markup, InlineKeyboardMarkup, :optional},
    {:input_message_content, InputMessageContent, :optional}
  ]

  model InlineQueryResultVideo, [
    {:type, String},
    {:id, String},
    {:video_url, String},
    {:mime_type, String},
    {:thumb_url, String},
    {:title, String},
    {:caption, String, :optional},
    {:parse_mode, String, :optional},
    {:caption_entities, [MessageEntity], :optional},
    {:video_width, :integer, :optional},
    {:video_height, :integer, :optional},
    {:video_duration, :integer, :optional},
    {:description, :integer, :optional},
    {:reply_markup, InlineKeyboardMarkup, :optional},
    {:input_message_content, InputMessageContent, :optional}
  ]

  model InlineQueryResultAudio, [
    {:type, String},
    {:id, String},
    {:audio_url, String},
    {:title, String},
    {:caption, String, :optional},
    {:parse_mode, String, :optional},
    {:caption_entities, [MessageEntity], :optional},
    {:performer, String, :optional},
    {:audio_duration, :integer, :optional},
    {:reply_markup, InlineKeyboardMarkup, :optional},
    {:input_message_content, InputMessageContent, :optional}
  ]

  model InlineQueryResultVoice, [
    {:type, String},
    {:id, String},
    {:voice_url, String},
    {:title, String},
    {:caption, String, :optional},
    {:parse_mode, String, :optional},
    {:caption_entities, [MessageEntity], :optional},
    {:voice_duration, :integer, :optional},
    {:reply_markup, InlineKeyboardMarkup, :optional},
    {:input_message_content, InputMessageContent, :optional}
  ]

  model InlineQueryResultDocument, [
    {:type, String},
    {:id, String},
    {:title, String},
    {:caption, String, :optional},
    {:parse_mode, String, :optional},
    {:caption_entities, [MessageEntity], :optional},
    {:document_url, String},
    {:mime_type, String},
    {:description, String, :optional},
    {:reply_markup, InlineKeyboardMarkup, :optional},
    {:input_message_content, InputMessageContent, :optional},
    {:thumb_url, String, :optional},
    {:thumb_width, :integer, :optional},
    {:thumb_height, :integer, :optional}
  ]

  model InlineQueryResultLocation, [
    {:type, String},
    {:id, String},
    {:latitude, :float},
    {:longitude, :float},
    {:title, String},
    {:horizontal_accuracy, :float, :optional},
    {:live_period, :integer, :optional},
    {:heading, :integer, :optional},
    {:proximity_alert_radius, :integer, :optional},
    {:reply_markup, InlineKeyboardMarkup, :optional},
    {:input_message_content, InputMessageContent, :optional},
    {:thumb_url, String, :optional},
    {:thumb_width, :integer, :optional},
    {:thumb_height, :integer, :optional}
  ]

  model InlineQueryResultVenue, [
    {:type, String},
    {:id, String},
    {:latitude, :float},
    {:longitude, :float},
    {:title, String},
    {:address, String},
    {:foursquare_id, String, :optional},
    {:foursquare_type, String, :optional},
    {:google_place_id, String, :optional},
    {:google_place_type, String, :optional},
    {:reply_markup, InlineKeyboardMarkup, :optional},
    {:input_message_content, InputMessageContent, :optional},
    {:thumb_url, String, :optional},
    {:thumb_width, :integer, :optional},
    {:thumb_height, :integer, :optional}
  ]

  model InlineQueryResultContact, [
    {:type, String},
    {:id, String},
    {:phone_number, String},
    {:first_name, String},
    {:last_name, String, :optional},
    {:vcard, String, :optional},
    {:reply_markup, InlineKeyboardMarkup, :optional},
    {:input_message_content, InputMessageContent, :optional},
    {:thumb_url, String, :optional},
    {:thumb_width, :integer, :optional},
    {:thumb_height, :integer, :optional}
  ]

  model InlineQueryResultGame, [
    {:type, String},
    {:id, String},
    {:game_short_name, String},
    {:reply_markup, InlineKeyboardMarkup, :optional}
  ]

  model InlineQueryResultCachedPhoto, [
    {:type, String},
    {:id, String},
    {:photo_file_id, String},
    {:title, String, :optional},
    {:description, String, :optional},
    {:caption, String, :optional},
    {:parse_mode, String, :optional},
    {:caption_entities, [MessageEntity], :optional},
    {:reply_markup, InlineKeyboardMarkup, :optional},
    {:input_message_content, InputMessageContent, :optional}
  ]

  model InlineQueryResultCachedGif, [
    {:type, String},
    {:id, String},
    {:gif_file_id, String},
    {:title, String, :optional},
    {:caption, String, :optional},
    {:parse_mode, String, :optional},
    {:caption_entities, [MessageEntity], :optional},
    {:reply_markup, InlineKeyboardMarkup, :optional},
    {:input_message_content, InputMessageContent, :optional}
  ]

  model InlineQueryResultCachedMpeg4Gif, [
    {:type, String},
    {:id, String},
    {:mpeg4_file_id, String},
    {:title, String, :optional},
    {:caption, String, :optional},
    {:parse_mode, String, :optional},
    {:caption_entities, [MessageEntity], :optional},
    {:reply_markup, InlineKeyboardMarkup, :optional},
    {:input_message_content, InputMessageContent, :optional}
  ]

  model InlineQueryResultCachedSticker, [
    {:type, String},
    {:id, String},
    {:sticker_file_id, String},
    {:reply_markup, InlineKeyboardMarkup, :optional},
    {:input_message_content, InputMessageContent, :optional}
  ]

  model InlineQueryResultCachedDocument, [
    {:type, String},
    {:id, String},
    {:title, String},
    {:document_file_id, String},
    {:description, String, :optional},
    {:caption, String, :optional},
    {:parse_mode, String, :optional},
    {:caption_entities, [MessageEntity], :optional},
    {:reply_markup, InlineKeyboardMarkup, :optional},
    {:input_message_content, InputMessageContent, :optional}
  ]

  model InlineQueryResultCachedVideo, [
    {:type, String},
    {:id, String},
    {:video_file_id, String},
    {:title, String},
    {:description, String, :optional},
    {:caption, String, :optional},
    {:parse_mode, String, :optional},
    {:caption_entities, [MessageEntity], :optional},
    {:reply_markup, InlineKeyboardMarkup, :optional},
    {:input_message_content, InputMessageContent, :optional}
  ]

  model InlineQueryResultCachedVoice, [
    {:type, String},
    {:id, String},
    {:voice_file_id, String},
    {:title, String},
    {:caption, String, :optional},
    {:parse_mode, String, :optional},
    {:caption_entities, [MessageEntity], :optional},
    {:reply_markup, InlineKeyboardMarkup, :optional},
    {:input_message_content, InputMessageContent, :optional}
  ]

  model InlineQueryResultCachedAudio, [
    {:type, String},
    {:id, String},
    {:audio_file_id, String},
    {:caption, String, :optional},
    {:parse_mode, String, :optional},
    {:caption_entities, [MessageEntity], :optional},
    {:reply_markup, InlineKeyboardMarkup, :optional},
    {:input_message_content, InputMessageContent, :optional}
  ]

  model InputTextMessageContent, [
    {:message_text, String},
    {:parse_mode, String, :optional},
    {:caption_entities, [MessageEntity], :optional},
    {:disable_web_page_preview, :boolean, :optional}
  ]

  model InputLocationMessageContent, [
    {:latitude, :float},
    {:longitude, :float},
    {:horizontal_accuracy, :float, :optional},
    {:live_period, :integer, :optional},
    {:heading, :integer, :optional},
    {:proximity_alert_radius, :integer, :optional}
  ]

  model InputVenueMessageContent, [
    {:latitude, :float},
    {:longitude, :float},
    {:title, String},
    {:address, String},
    {:foursquare_id, String, :optional},
    {:foursquare_type, String, :optional},
    {:google_place_id, String, :optional},
    {:google_place_type, String, :optional}
  ]

  model InputContactMessageContent, [
    {:phone_number, String},
    {:first_name, String},
    {:last_name, String, :optional},
    {:vcard, String, :optional}
  ]

  model ChosenInlineResult, [
    {:result_id, String},
    {:from, User},
    {:location, Location, :optional},
    {:inline_message_id, String, :optional},
    {:query, String}
  ]

  model Update, [
    {:update_id, :integer},
    {:message, Message, :optional},
    {:edited_message, Message, :optional},
    {:channel_post, Message, :optional},
    {:edited_channel_post, Message, :optional},
    {:inline_query, InlineQuery, :optional},
    {:chosen_inline_result, ChosenInlineResult, :optional},
    {:callback_query, CallbackQuery, :optional},
    {:shipping_query, ShippingQuery, :optional},
    {:pre_checkout_query, PreCheckoutQuery, :optional},
    {:poll, Poll, :optional},
    {:poll_answer, PollAnswer, :optional},
    {:my_chat_member, ChatMemberUpdated, :optional},
    {:chat_member, ChatMemberUpdated, :optional}
  ]

  model Response, [
    {:ok, :boolean},
    {:result, :any, :optional},
    {:error_code, :integer, :optional},
    {:description, String, :optional}
  ]

  model Error, [
    {:error_code, :integer},
    {:description, String}
  ]

  model RequestError, [
    {:reason, :atom}
  ]
end
