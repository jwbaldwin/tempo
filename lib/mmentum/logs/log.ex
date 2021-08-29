defmodule Mmentum.Logs.Log do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  schema "logs" do
    belongs_to :user, Mmentum.Accounts.User
    belongs_to :habit, Mmentum.Habits.Habit

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(log, attrs) do
    log
    |> cast(attrs, [:user_id, :habit_id])
    |> validate_required([:user_id, :habit_id])
  end
end
