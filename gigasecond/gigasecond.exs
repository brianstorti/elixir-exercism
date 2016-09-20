defmodule Gigasecond do
  def from(datetime) do
    datetime
      |> :calendar.datetime_to_gregorian_seconds
      |> +(1_000_000_000)
      |> :calendar.gregorian_seconds_to_datetime
  end
end
