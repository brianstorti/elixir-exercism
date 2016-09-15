defmodule Year do
  def leap_year?(year) when rem(year, 4) != 0, do: false
  def leap_year?(year) when rem(year, 100) == 0, do: rem(year, 400) == 0
  def leap_year?(_year), do: true
end
