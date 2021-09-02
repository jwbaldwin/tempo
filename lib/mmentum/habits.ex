defmodule Mmentum.Habits do
  @moduledoc """
  The Habits context.
  """

  import Ecto.Query, warn: false
  alias Mmentum.Accounts.User
  alias Mmentum.Habits.Habit
  alias Mmentum.Logs
  alias Mmentum.Repo

  @allowed_ranges [:year, :month, :week, :day]

  @doc """
  Retrieve the user's list of habits
  """
  def list_habits(%User{id: user_id} = _user) do
    Habit
    |> where(user_id: ^user_id)
    |> preload(:logs)
    |> Repo.all()
  end

  @doc """
  Retrieve the user's list of habits with all logs in the current week
  """
  def list_habits_with_range(%User{id: user_id} = _user, range \\ :week)
      when range in @allowed_ranges do
    Habit
    |> where(user_id: ^user_id)
    |> preload(logs: ^Logs.base_logs_range_query(range))
    |> Repo.all()
  end

  @doc """
  Gets a single habit.
  """
  def get_habit!(id), do: Repo.get!(Habit, id)

  @doc """
  Creates a habit.
  """
  def create_habit(params, %User{} = user) do
    Ecto.build_assoc(user, :habits)
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
