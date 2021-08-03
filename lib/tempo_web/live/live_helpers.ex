defmodule TempoWeb.LiveHelpers do
  @moduledoc """
  A set of helpers, one is for displaying modals and the other is for supplying user info into an assigns
  """
  import Phoenix.LiveView
  import Phoenix.LiveView.Helpers
  alias TempoWeb.Router.Helpers, as: Routes

  @doc """
  Renders a component inside the `TempoWeb.ModalComponent` component.

  The rendered modal receives a `:return_to` option to properly update
  the URL when the modal is closed.

  ## Examples

      <%= live_modal @socket, TempoWeb.HabitLive.FormComponent,
        id: @habit.id || :new,
        action: @live_action,
        habit: @habit,
        return_to: Routes.habit_index_path(@socket, :index) %>
  """
  def live_modal(_socket, component, opts) do
    path = Keyword.fetch!(opts, :return_to)
    modal_opts = [id: :modal, return_to: path, component: component, opts: opts]
    live_component(TempoWeb.ModalComponent, modal_opts)
  end

  def assign_defaults(session, socket) do
    socket =
      assign_new(socket, :current_user, fn ->
        find_current_user(session)
      end)

    case socket.assigns.current_user do
      %Tempo.Accounts.User{} ->
        socket

      _other ->
        socket
        |> put_flash(:error, "You must log in to access this page.")
        |> redirect(to: Routes.user_session_path(socket, :new))
    end
  end

  defp find_current_user(session) do
    with user_token when not is_nil(user_token) <- session["user_token"],
         %Tempo.Accounts.User{} = user <- Tempo.Accounts.get_user_by_session_token(user_token),
         do: user
  end
end
