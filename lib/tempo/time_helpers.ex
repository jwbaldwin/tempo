defmodule Tempo.TimeHelpers do
  @moduledoc """
  A set of helpers for working with dates and providing human readable output.
  Operates in local time.
  """

  @greetings %{
    early: "Good morning",
    middle: "Good afternoon",
    late: "Good evening"
  }

  @doc """
  Returns the day of the week as an atom
  > current_day()
  >> Monday
  """
  def current_day() do
    Timex.local() |> Timex.weekday() |> Timex.day_name()
  end

  @doc """
  Returns the current time with timezone information
  """
  def current_time() do
    Timex.local()
  end

  @doc """
  Returns a pre-written greeting for the time of day
  """
  def greeting_for_time_of_day(%DateTime{} = time) do
    hours_left = Timex.diff(Timex.end_of_day(time), time, :hours)

    cond do
      is_morning(hours_left) -> @greetings[:early]
      is_afternoon(hours_left) -> @greetings[:middle]
      true -> @greetings[:late]
    end
  end

  def greeting_for_time_of_day() do
    current_time()
    |> greeting_for_time_of_day()
  end

  # Checks if hours left is between 4am (24 - 4 = 20) and 11am (24 - 11 = 13)
  defp is_morning(hours_left) do
    hours_left < 20 && hours_left >= 13
  end

  # Checks if hours left is between 11am (24 - 11 = 13) and 6pm (24 - 18 = 6)
  defp is_afternoon(hours_left) do
    hours_left < 13 && hours_left >= 6
  end
end
