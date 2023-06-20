defmodule PhoenixChat.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PhoenixChat.Accounts` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "some email",
        encrypted_password: "some encrypted_password",
        username: "some username"
      })
      |> PhoenixChat.Accounts.create_user()

    user
  end
end
