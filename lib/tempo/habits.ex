defmodule Tempo.Habits do
  @moduledoc """
  The Habits context.
  """

  import Ecto.Query, warn: false
  alias Tempo.Repo
  alias Tempo.Accounts.User
  alias Tempo.Habits.Habit

  @doc """
  Retrievs the user's list of habits
  """
  def list_habits(%User{} = user) do
    Habit
    |> where(user_id: ^user.id)
    |> Repo.all()
  end

  def list_habits, do: Repo.all(Habit)

  @doc """
  Gets a single habit.
  """
  def get_habit!(id), do: Repo.get!(Habit, id)

  @doc """
  Creates a habit.
  """
  def create_habit(%User{} = user, params) do
    Ecto.build_assoc(user, :habits)
    |> IO.inspect()
    |> Habit.changeset(params)
    |> Repo.insert()
  end

  @doc """
  Updates a habit.
  """
  def update_habit(%Habit{} = habit, params) do
    habit
    |> Habit.changeset(params)
    |> Repo.update()
  end

  @doc """
  Deletes a habit.
  """
  def delete_habit(%Habit{} = habit) do
    Repo.delete(habit)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking habit changes.
  """
  def change_habit(%Habit{} = habit, params \\ %{}) do
    Habit.changeset(habit, params)
  end
end
