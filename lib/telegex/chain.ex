defmodule Telegex.Chain do
  @moduledoc false

  alias Telegex.Type.Update

  @type state :: :ok | :stop | :done
  @type payload :: %{method: String.t()}
  # TODO: 恢复此处更具体的上下文规范，并解决 dialyzer 中的错误
  # @type context :: %{payload: payload | nil, reason: any}
  @type context :: map
  @type result :: {state, context}

  @callback call(update :: Update.t(), context :: context) :: result
  @callback match?(data :: any, context :: context) :: boolean
  @callback handle(data :: any, context :: context) :: result

  defmacro __using__(update_field)
           when update_field in [
                  :callback_query,
                  :channel_post,
                  :chat_join_request,
                  :chat_member,
                  :chosen_inline_result,
                  :edited_channel_post,
                  :edited_message,
                  :inline_query,
                  :message,
                  :my_chat_member,
                  :poll,
                  :poll_answer,
                  :pre_checkout_query,
                  :shipping_query
                ] do
    quote do
      @behaviour unquote(__MODULE__)

      @impl true
      def call(%{unquote(update_field) => data} = update, context) when data != nil do
        if apply(__MODULE__, :match?, [data, context]) do
          handle(data, context)
        else
          {:ok, context}
        end
      end

      @impl true
      def call(_update, context) do
        {:ok, context}
      end

      @impl true
      def match?(_value, _context) do
        require Logger

        Logger.warning(
          "The `#{__MODULE__}.match/2` function is not implemented, always returns true"
        )

        true
      end

      defoverridable call: 2, match?: 2
    end
  end

  defmacro __using__({:command, command_name}) do
    quote do
      use unquote(__MODULE__), :message

      @command "/#{to_string(unquote(command_name))}"

      @impl true
      def match?(%{text: @command, chat: %{type: "private"}} = message, context) do
        true
      end

      @impl true
      def match?(%{text: text, chat: %{type: chat_type}} = message, %{bot: bot} = context)
          when bot != nil and text != nil and chat_type in ["group", "supergroup"] do
        text == "#{@command}@#{bot.username}"
      end

      @impl true
      def match?(_message, _context), do: false

      defoverridable match?: 2
    end
  end

  defmacro __using__({:callback_query, prefix: prefix}) do
    quote do
      use unquote(__MODULE__), :callback_query

      @prefix to_string(unquote(prefix))

      @impl true
      def match?(%{data: <<@prefix <> _rest::binary>>} = _callback_query, _context) do
        true
      end

      @impl true
      def match?(_callback_query, _context), do: false

      defoverridable match?: 2
    end
  end

  defmacro __using__(_) do
    quote do
      @behaviour unquote(__MODULE__)

      @impl true
      def call(update, context) do
        if apply(__MODULE__, :match?, [update, context]) do
          handle(update, context)
        else
          {:ok, context}
        end
      end

      @impl true
      def match?(_update, _context), do: true

      defoverridable call: 2, match?: 2
    end
  end
end
