defmodule Mmentum.Habits.Habit do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  schema "habits" do
    field :iterations, :integer
    field :name, :string

    belongs_to :user, Mmentum.Accounts.User
    has_many :logs, Mmentum.Logs.Log, on_delete: :delete_all

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(habit, attrs) do
    habit
    |> cast(attrs, [:name, :iterations])
    |> validate_required([:name, :iterations])
    |> validate_number(:iterations, greater_than: 0)
  end
end
