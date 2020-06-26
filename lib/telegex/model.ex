defmodule Telegex.Model do
  @moduledoc """
  All types used in Bot API response.
  """

  use Telegex.DSL

  @type inputfile :: String.t()

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
    {:can_set_sticker_set, :boolean, :optional}
  ]

  model Message, [
    {:message_id, :integer},
    {:from, User},
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
    {:migrate_to_chat_id, :integer, :optional},
    {:migrate_from_chat_id, :integer, :optional},
    {:pinned_message, Message, :optional},
    {:invoice, Invoice, :optional},
    {:successful_payment, SuccessfulPayment, :optional},
    {:connected_website, String, :optional},
    {:passport_data, PassportData, :optional},
    {:reply_markup, InlineKeyboardMarkup, :optional}
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
    {:latitude, :float}
  ]

  model Venue, [
    {:location, Location},
    {:title, String},
    {:address, String},
    {:foursquare_id, String, :optional},
    {:foursquare_type, String, :optional}
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
    {:file_id, String},
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

  model ChatMember, [
    {:user, User},
    {:status, String},
    {:custom_title, String, :optional},
    {:until_date, :integer, :optional},
    {:can_be_edited, :boolean, :optional},
    {:can_post_messages, :boolean, :optional},
    {:can_edit_messages, :boolean, :optional},
    {:can_delete_messages, :boolean, :optional},
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
    {:parse_mode, String, :optional}
  ]

  model InputMediaVideo, [
    {:type, String},
    {:media, String},
    {:thumb, :inputfile | String, :optional},
    {:caption, String, :optional},
    {:parse_mode, String, :optional},
    {:width, :integer, :optional},
    {:height, :integer, :optional},
    {:duration, :integer, :optional},
    {:supports_streaming, :boolean, :optional}
  ]

  model InputMediaAnimation, [
    {:type, String},
    {:media, String},
    {:thumb, :inputfile | String, :optional},
    {:caption, String, :optional},
    {:parse_mode, String, :optional},
    {:width, :integer, :optional},
    {:height, :integer, :optional},
    {:duration, :integer, :optional}
  ]

  model InputMediaAudio, [
    {:type, String},
    {:media, String},
    {:thumb, :inputfile | String, :optional},
    {:caption, String, :optional},
    {:parse_mode, String, :optional},
    {:duration, :integer, :optional},
    {:performer, String, :optional},
    {:title, String, :optional}
  ]

  model InputMediaDocument, [
    {:type, String},
    {:media, String},
    {:thumb, :inputfile | String, :optional},
    {:caption, String, :optional},
    {:parse_mode, String, :optional}
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
end
