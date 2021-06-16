defmodule Tempo.Habits.Habit do
  use Ecto.Schema
  import Ecto.Changeset

  schema "habits" do
    field :iterations, :integer
    field :name, :string

    belongs_to :user, Tempo.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(habit, attrs) do
    habit
    |> cast(attrs, [:name, :iterations])
    |> validate_required([:name, :iterations])
  end
end
