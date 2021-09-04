defmodule MmentumWeb.ModalComponent do
  @moduledoc """
  Base modal component with tailwindcss styling
  """
  use MmentumWeb, :live_component

  @impl true
  def render(assigns) do
    ~L"""
    <div class="fixed inset-0 z-30 overflow-y-auto" aria-labelledby="modal-title" role="dialog" aria-modal="true">
      <div class="flex items-end justify-center min-h-screen px-4 pt-4 pb-20 text-center sm:block sm:p-0">
        <div class="fixed absolute inset-0 z-20 transition-opacity ~bg-slate-500 bg-opacity-75" aria-hidden="true"></div>
        <span class="hidden sm:inline-block sm:align-middle sm:h-screen" aria-hidden="true">&#8203;</span>

        <div id="<%= @id %>" class="relative z-30 inline-block px-4 pt-5 pb-4 overflow-hidden text-left align-bottom transition-all transform ~bg-white rounded shadow-xl phx-modal sm:my-8 sm:align-middle sm:max-w-sm sm:w-full sm:p-6"
          phx-capture-click="close"
          phx-window-keydown="close"
          phx-key="escape"
          phx-target="#<%= @id %>"
          phx-page-loading>

          <div class="phx-modal-content">
          <div class="absolute top-0 right-0 hidden pt-4 pr-4 sm:block">
            <span class="sr-only">Close</span>
            <%= live_patch raw("&times;"), to: @return_to, class: "phx-modal-close text-3xl rounded ~text-slate-500 hover:text-gray-400 focus:outline-none focus:ring-2 focus:ring-gray-400" %>
          </div>
            <%= live_component @socket, @component, @opts %>
          </div>
        </div>
      </div>
    </div>
    """
  end

  @impl true
  def handle_event("close", _, socket) do
    {:noreply, push_patch(socket, to: socket.assigns.return_to)}
  end
end
