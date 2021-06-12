defmodule Habit.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Habit.Repo,
      # Start the Telemetry supervisor
      HabitWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Habit.PubSub},
      # Start the Endpoint (http/https)
      HabitWeb.Endpoint
      # Start a worker by calling: Habit.Worker.start_link(arg)
      # {Habit.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Habit.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    HabitWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
