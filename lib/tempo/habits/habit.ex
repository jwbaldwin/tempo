defmodule Tempo.Habits.Habit do
  use Ecto.Schema
  import Ecto.Changeset

  schema "habits" do
    field :iterations, :integer
    field :name, :string

    belongs_to :user, Tempo.Accounts.User
    has_many :logs, Tempo.Logs.Log

    timestamps()
  end

  @doc false
  def changeset(habit, attrs) do
    habit
    |> cast(attrs, [:name, :iterations])
    |> validate_required([:name, :iterations])
    |> validate_number(:iterations, greater_than: 0)
  end
end
