defmodule TempoWeb.HabitLive.Index do
  use TempoWeb, :live_view

  alias Tempo.Logs
  alias Tempo.Habits
  alias Tempo.Habits.Habit

  @impl true
  def mount(_params, session, socket) do
    socket = assign_defaults(session, socket)
    {:ok, assign(socket, :habits, list_habits(socket))}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Habit")
    |> assign(:habit, Habits.get_habit!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Habit")
    |> assign(:habit, %Habit{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Habits")
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

  defp save_log(socket, habit_id) do
    user = get_current_user(socket)

    case Logs.create_log(%{user_id: user.id, habit_id: habit_id}) do
      # TODO: Do I need to refetch all of the habits? no, so how do I update just the logs of the habit I changed
      {:ok, _log} ->
        {:noreply, assign(socket, :habits, list_habits(socket))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  defp list_habits(socket) do
    get_current_user(socket)
    |> Habits.list_habits()
  end

  defp get_current_user(%Phoenix.LiveView.Socket{assigns: %{current_user: user}} = _socket) do
    user
  end
end
