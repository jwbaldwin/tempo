defmodule Mmentum.HabitsTest do
  use Mmentum.DataCase

  import Mmentum.HabitsFixtures
  import Mmentum.AccountsFixtures

  alias Mmentum.Habits

  describe "habits" do
    alias Mmentum.Habits.Habit

    @valid_attrs %{iterations: 42, name: "some name"}
    @update_attrs %{iterations: 43, name: "some updated name"}
    @invalid_attrs %{iterations: nil, name: nil}

    def create_habit(attrs \\ %{}) do
      %{user: user, habit: habit} =
        attrs
        |> Enum.into(@valid_attrs)
        |> habit_fixture()

      %{user: user, habit: habit}
    end

    test "list_habits/1 returns all habits for a user" do
      %{user: user, habit: habit} = create_habit()
      assert unload(Habits.list_habits(user), :logs) == [habit]
    end

    test "get_habit!/1 returns the habit with given id" do
      %{habit: habit} = create_habit()
      assert Habits.get_habit!(habit.id) == habit
    end

    test "create_habit/1 with valid data creates a habit" do
      user = user_fixture()
      assert {:ok, %Habit{} = habit} = Habits.create_habit(@valid_attrs, user)
      assert habit.iterations == 42
      assert habit.name == "some name"
    end

    test "create_habit/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Habits.create_habit(@invalid_attrs, user)
    end

    test "update_habit/2 with valid data updates the habit" do
      %{habit: habit} = create_habit()
      assert {:ok, %Habit{} = habit} = Habits.update_habit(habit, @update_attrs)
      assert habit.iterations == 43
      assert habit.name == "some updated name"
    end

    test "update_habit/2 with invalid data returns error changeset" do
      %{habit: habit} = create_habit()
      assert {:error, %Ecto.Changeset{}} = Habits.update_habit(habit, @invalid_attrs)
      assert habit == Habits.get_habit!(habit.id)
    end

    test "delete_habit/1 deletes the habit" do
      %{habit: habit} = create_habit()
      assert {:ok, %Habit{}} = Habits.delete_habit(habit)
      assert_raise Ecto.NoResultsError, fn -> Habits.get_habit!(habit.id) end
    end

    test "change_habit/1 returns a habit changeset" do
      %{habit: habit} = create_habit()
      assert %Ecto.Changeset{} = Habits.change_habit(habit)
    end
  end
end
