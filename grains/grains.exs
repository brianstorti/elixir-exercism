defmodule Grains do
  def square(number), do: Enum.reduce(1..number, fn _n, acc -> acc * 2 end)
  def total, do: Enum.reduce(1..64, &(square(&1) + &2))
end
