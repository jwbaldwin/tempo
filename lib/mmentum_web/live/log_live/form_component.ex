defmodule MmentumWeb.LogLive.FormComponent do
  @moduledoc """
  Logs form for edit/create
  """
  use MmentumWeb, :live_component

  alias Mmentum.Logs

  @impl true
  def update(%{log: log} = assigns, socket) do
    changeset = Logs.change_log(log)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"log" => log_params}, socket) do
    changeset =
      socket.assigns.log
      |> Logs.change_log(log_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"log" => log_params}, socket) do
    save_log(socket, socket.assigns.action, log_params)
  end

  defp save_log(socket, :edit, log_params) do
    case Logs.update_log(socket.assigns.log, log_params) do
      {:ok, _log} ->
        {:noreply,
         socket
         |> put_flash(:info, "Log updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_log(socket, :new, log_params) do
    case Logs.create_log(log_params) do
      {:ok, _log} ->
        {:noreply,
         socket
         |> put_flash(:info, "Log created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
