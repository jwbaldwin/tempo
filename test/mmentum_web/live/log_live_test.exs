defmodule MmentumWeb.LogLiveTest do
  use MmentumWeb.ConnCase

  import Phoenix.LiveViewTest
  import Mmentum.HabitsFixtures

  alias Mmentum.Logs

  defp fixture(:log, attrs \\ %{}) do
    %{user: user, habit: habit} = habit_fixture()

    {:ok, log} =
      attrs
      |> Enum.into(%{user_id: user.id, habit_id: habit.id})
      |> Logs.create_log()

    %{log: log, user: user, habit: habit}
  end

  defp setup_user_and_log(%{conn: conn}) do
    res = fixture(:log)
    conn = log_in_user(conn, res.user)
    %{conn: conn, log: res.log, user: res.user, habit: res.habit}
  end

  describe "Index" do
    setup :setup_user_and_log

    test "lists all logs", %{conn: conn, log: _log} do
      {:ok, _index_live, html} = live(conn, Routes.log_index_path(conn, :index))

      assert html =~ "Listing Logs"
    end

    # test "saves new log", %{conn: conn} do
    #   {:ok, index_live, _html} = live(conn, Routes.log_index_path(conn, :index))

    #   assert index_live |> element("a", "New Log") |> render_click() =~
    #            "New Log"

    #   assert_patch(index_live, Routes.log_index_path(conn, :new))

    #   assert index_live
    #          |> form("#log-form", log: @invalid_attrs)
    #          |> render_change() =~ "can&#39;t be blank"

    #   {:ok, _, html} =
    #     index_live
    #     |> form("#log-form", log: @create_attrs)
    #     |> render_submit()
    #     |> follow_redirect(conn, Routes.log_index_path(conn, :index))

    #   assert html =~ "Log created successfully"
    # end

    # test "updates log in listing", %{conn: conn, log: log} do
    #   {:ok, index_live, _html} = live(conn, Routes.log_index_path(conn, :index))

    #   assert index_live |> element("#log-#{log.id} a", "Edit") |> render_click() =~
    #            "Edit Log"

    #   assert_patch(index_live, Routes.log_index_path(conn, :edit, log))

    #   assert index_live
    #          |> form("#log-form", log: @invalid_attrs)
    #          |> render_change() =~ "can&#39;t be blank"

    #   {:ok, _, html} =
    #     index_live
    #     |> form("#log-form", log: @update_attrs)
    #     |> render_submit()
    #     |> follow_redirect(conn, Routes.log_index_path(conn, :index))

    #   assert html =~ "Log updated successfully"
    # end

    test "deletes log in listing", %{conn: conn, log: log} do
      {:ok, index_live, _html} = live(conn, Routes.log_index_path(conn, :index))

      assert index_live |> element("#log-#{log.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#log-#{log.id}")
    end
  end

  describe "Show" do
    setup :setup_user_and_log

    test "displays log", %{conn: conn, log: log} do
      {:ok, _show_live, html} = live(conn, Routes.log_show_path(conn, :show, log))

      assert html =~ "Show Log"
    end
  end
end
