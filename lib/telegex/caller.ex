defmodule Telegex.Caller do
  @moduledoc false

  @type error :: Telegex.Type.error()

  @callback call(String.t(), keyword, keyword) :: {:ok, any} | {:error, error}

  @spec call(String.t(), keyword, keyword) :: {:ok, any} | {:error, error}
  def call(method, params \\ [], opts \\ []) do
    __MODULE__.Adapter.impl().call(method, params, opts)
  end
end
