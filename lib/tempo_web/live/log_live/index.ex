defmodule TempoWeb.LogLive.Index do
  use TempoWeb, :live_view

  alias Tempo.Logs
  alias Tempo.Logs.Log

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :logs, list_logs())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Log")
    |> assign(:log, Logs.get_log!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Log")
    |> assign(:log, %Log{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Logs")
    |> assign(:log, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    log = Logs.get_log!(id)
    {:ok, _} = Logs.delete_log(log)

    {:noreply, assign(socket, :logs, list_logs())}
  end

  defp list_logs do
    Logs.list_logs()
  end
end
