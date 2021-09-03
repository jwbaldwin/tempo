defmodule MmentumWeb.HabitLive.Index do
  @moduledoc """
  The main module to support the home view of habits and logs
  """
  use MmentumWeb, :live_view

  alias Phoenix.LiveView.Socket
  alias Mmentum.Habits
  alias Mmentum.Habits.Habit
  alias Mmentum.Logs
  alias Mmentum.TimeHelpers

  @impl true
  def mount(_params, session, socket) do
    socket = assign_defaults(session, socket)

    {:ok,
     socket
     |> assign(:habits, list_habits(socket))
     |> assign_day_info()}
  end

  defp assign_day_info(socket) do
    assign(socket, %{
      current_day: TimeHelpers.current_day(),
      current_time: TimeHelpers.current_time(),
      days_until_end_of_week: TimeHelpers.days_to_end(:week),
      greeting: TimeHelpers.greeting_for_time_of_day(),
      time_of_day: TimeHelpers.time_of_day()
    })
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Habit - Mmentum")
    |> assign(:habit, Habits.get_habit!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Habit - Mmentum")
    |> assign(:habit, %Habit{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:habit, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    habit = Habits.get_habit!(id)
    {:ok, _} = Habits.delete_habit(habit)

    {:noreply, assign(socket, :habits, list_habits(socket))}
  end

  def handle_event("add_log", %{"id" => habit_id}, socket) do
    save_log(socket, habit_id)
  end

  def handle_event("remove_log", %{"id" => habit_id}, socket) do
    delete_log(socket, habit_id)
  end

  defp save_log(socket, habit_id) do
    user = get_current_user(socket)

    case Logs.create_log(%{user_id: user.id, habit_id: habit_id}) do
      {:ok, _log} ->
        {:noreply, assign(socket, :habits, list_habits(socket))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  defp delete_log(socket, habit_id) do
    socket
    |> get_logs_from_habit(habit_id)
    |> Logs.delete_most_recent_log()
    |> case do
      {:ok, _} ->
        {:noreply, assign(socket, :habits, list_habits(socket))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  defp list_habits(socket) do
    get_current_user(socket)
    |> Habits.list_habits_with_range(:week)
  end

  defp get_logs_from_habit(%Socket{assigns: %{habits: habits}} = _socket, habit_id)
       when is_list(habits) do
    habit =
      habits
      |> Enum.find(&(&1.id == String.to_integer(habit_id)))

    habit.logs
  end
end
