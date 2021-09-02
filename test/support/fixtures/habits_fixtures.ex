defmodule Mmentum.HabitsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Mmentum.Habits` context.
  """

  defp unique_name(), do: "habit#{System.unique_integer()}"

  def valid_habit_attributes(attrs \\ %{}) do
    Enum.into(attrs, %{
      name: unique_name(),
      iterations: :rand.uniform(7)
    })
  end

  def habit_fixture(attrs \\ %{}) do
    user = Mmentum.AccountsFixtures.user_fixture()

    {:ok, habit} =
      attrs
      |> valid_habit_attributes()
      |> Mmentum.Habits.create_habit(user)

    %{user: user, habit: habit}
  end
end
