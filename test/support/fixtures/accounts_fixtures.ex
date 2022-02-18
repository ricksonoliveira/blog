defmodule Blog.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Blog.Accounts` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "some email",
        first_name: "some first_name",
        image: "some image",
        last_name: "some last_name",
        provider: "some provider",
        token: "some token"
      })
      |> Blog.Accounts.create_user()

    user
  end
end
