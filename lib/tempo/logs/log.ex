defmodule Tempo.Logs.Log do
  use Ecto.Schema
  import Ecto.Changeset

  schema "logs" do
    belongs_to :user, Tempo.Accounts.User
    belongs_to :habit, Tempo.Habits.Habit

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(log, attrs) do
    log
    |> cast(attrs, [:user_id, :habit_id])
    |> validate_required([:user_id, :habit_id])
  end
end
