defmodule Meetup do
  @starting_days %{ teenth: 13,
                    first: 1,
                    second: 8,
                    third: 15,
                    fourth: 22 }

  def meetup(year, month, weekday, :last) do
    last_day = :calendar.last_day_of_the_month(year, month)
    day = find_day(year, month, weekday, last_day - 6)

    {year, month, day}
  end

  def meetup(year, month, weekday, schedule) do
    starting_day = @starting_days[schedule]
    day = find_day(year, month, weekday, starting_day)

    {year, month, day}
  end

  defp find_day(year, month, weekday, starting_day) do
    day_of_the_week = :calendar.day_of_the_week({year, month, starting_day})
    if day_of_the_week == weekday_to_integer(weekday) do
      starting_day
    else
      find_day(year, month, weekday, starting_day + 1)
    end
  end

  defp weekday_to_integer(:monday), do: 1
  defp weekday_to_integer(:tuesday), do: 2
  defp weekday_to_integer(:wednesday), do: 3
  defp weekday_to_integer(:thursday), do: 4
  defp weekday_to_integer(:friday), do: 5
  defp weekday_to_integer(:saturday), do: 6
  defp weekday_to_integer(:sunday), do: 7
end
