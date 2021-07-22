defmodule Tempo.TempoHelpersTest do
  use Tempo.DataCase

  alias Tempo.TimeHelpers

  describe "greeting_for_time_of_day/0" do
    test "returns an early greeting for 4am" do
      four_am = Timex.DateTime.new!(~D[2021-01-01], ~T[04:00:00.000], "America/New_York")

      assert TimeHelpers.greeting_for_time_of_day(four_am) == "Good morning"
    end

    test "returns an early greeting for 10am" do
      ten_am = Timex.DateTime.new!(~D[2021-01-01], ~T[10:00:00.000], "America/New_York")

      assert TimeHelpers.greeting_for_time_of_day(ten_am) == "Good morning"
    end

    test "returns an middle greeting for 11am" do
      eleven_am = Timex.DateTime.new!(~D[2021-01-01], ~T[11:00:00.000], "America/New_York")

      assert TimeHelpers.greeting_for_time_of_day(eleven_am) == "Good afternoon"
    end

    test "returns an middle greeting for 5pm" do
      five_pm = Timex.DateTime.new!(~D[2021-01-01], ~T[17:00:00.000], "America/New_York")

      assert TimeHelpers.greeting_for_time_of_day(five_pm) == "Good afternoon"
    end

    test "returns an late greeting for 6pm" do
      six_pm = Timex.DateTime.new!(~D[2021-01-01], ~T[18:00:00.000], "America/New_York")

      assert TimeHelpers.greeting_for_time_of_day(six_pm) == "Good evening"
    end

    test "returns an late greeting for 3am" do
      three_am = Timex.DateTime.new!(~D[2021-01-01], ~T[03:00:00.000], "America/New_York")

      assert TimeHelpers.greeting_for_time_of_day(three_am) == "Good evening"
    end
  end
end
