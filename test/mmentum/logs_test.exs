defmodule Mmentum.LogsTest do
  use Mmentum.DataCase

  import Mmentum.HabitsFixtures

  alias Mmentum.Logs

  describe "logs" do
    alias Mmentum.Logs.Log

    @valid_attrs %{}
    @update_attrs %{}

    def log_fixture(attrs \\ %{}) do
      %{user: user, habit: habit} = habit_fixture()

      {:ok, log} =
        attrs
        |> Enum.into(%{user_id: user.id, habit_id: habit.id})
        |> Logs.create_log()

      %{log: log, user: user, habit: habit}
    end

    test "list_logs_by_user/1 returns all logs for user" do
      %{log: log, user: user} = log_fixture()
      assert Logs.list_logs_by_user(user) == [log]
    end

    test "list_logs_by_habit/2 returns all logs for a users habit" do
      %{log: log, user: user, habit: habit} = log_fixture()
      assert Logs.list_logs_by_habit(user, habit) == [log]
    end

    test "get_log!/1 returns the log with given id" do
      %{log: log} = log_fixture()
      assert Logs.get_log!(log.id) == log
    end

    test "create_log/1 with valid data creates a log" do
      %{user: user, habit: habit} = habit_fixture()

      assert {:ok, %Log{} = _log} =
               Logs.create_log(Enum.into(@valid_attrs, %{user_id: user.id, habit_id: habit.id}))
    end

    test "update_log/2 with valid data updates the log" do
      %{log: log} = log_fixture()
      assert {:ok, %Log{} = _log} = Logs.update_log(log, @update_attrs)
    end

    test "delete_log/1 deletes the log" do
      %{log: log} = log_fixture()
      assert {:ok, %Log{}} = Logs.delete_log(log)
      assert_raise Ecto.NoResultsError, fn -> Logs.get_log!(log.id) end
    end

    test "change_log/1 returns a log changeset" do
      %{log: log} = log_fixture()
      assert %Ecto.Changeset{} = Logs.change_log(log)
    end
  end
end
