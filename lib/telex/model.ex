defmodule Telex.Model do
  @moduledoc """
  All types used in Bot API response.
  """

  use Telex.DSL

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
end
