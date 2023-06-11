defmodule EchoBot do
  @moduledoc false

  def work_mode, do: Application.get_env(:echo_bot, :work_mode)
end
