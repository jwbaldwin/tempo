defmodule TempoWeb.HabitLiveTest do
  use TempoWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Tempo.Habits

  @create_attrs %{iterations: 42, name: "some name"}
  @update_attrs %{iterations: 43, name: "some updated name"}
  @invalid_attrs %{iterations: nil, name: nil}

  defp fixture(:habit) do
    {:ok, habit} = Habits.create_habit(@create_attrs)
    habit
  end

  defp create_habit(_) do
    habit = fixture(:habit)
    %{habit: habit}
  end

  describe "Index" do
    setup [:create_habit]

    test "lists all habits", %{conn: conn, habit: habit} do
      {:ok, _index_live, html} = live(conn, Routes.habit_index_path(conn, :index))

      assert html =~ "Listing Habits"
      assert html =~ habit.name
    end

    test "saves new habit", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.habit_index_path(conn, :index))

      assert index_live |> element("a", "New Habit") |> render_click() =~
               "New Habit"

      assert_patch(index_live, Routes.habit_index_path(conn, :new))

      assert index_live
             |> form("#habit-form", habit: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#habit-form", habit: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.habit_index_path(conn, :index))

      assert html =~ "Habit created successfully"
      assert html =~ "some name"
    end

    test "updates habit in listing", %{conn: conn, habit: habit} do
      {:ok, index_live, _html} = live(conn, Routes.habit_index_path(conn, :index))

      assert index_live |> element("#habit-#{habit.id} a", "Edit") |> render_click() =~
               "Edit Habit"

      assert_patch(index_live, Routes.habit_index_path(conn, :edit, habit))

      assert index_live
             |> form("#habit-form", habit: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#habit-form", habit: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.habit_index_path(conn, :index))

      assert html =~ "Habit updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes habit in listing", %{conn: conn, habit: habit} do
      {:ok, index_live, _html} = live(conn, Routes.habit_index_path(conn, :index))

      assert index_live |> element("#habit-#{habit.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#habit-#{habit.id}")
    end
  end

  describe "Show" do
    setup [:create_habit]

    test "displays habit", %{conn: conn, habit: habit} do
      {:ok, _show_live, html} = live(conn, Routes.habit_show_path(conn, :show, habit))

      assert html =~ "Show Habit"
      assert html =~ habit.name
    end

    test "updates habit within modal", %{conn: conn, habit: habit} do
      {:ok, show_live, _html} = live(conn, Routes.habit_show_path(conn, :show, habit))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Habit"

      assert_patch(show_live, Routes.habit_show_path(conn, :edit, habit))

      assert show_live
             |> form("#habit-form", habit: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#habit-form", habit: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.habit_show_path(conn, :show, habit))

      assert html =~ "Habit updated successfully"
      assert html =~ "some updated name"
    end
  end
end
