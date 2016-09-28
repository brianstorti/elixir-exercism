defmodule Triplet do
  def sum(triplet) do
    sum(triplet, 0)
  end

  defp sum([], total), do: total
  defp sum([n|rest], total) do
    sum(rest, total + n)
  end

  def product(triplet) do
    product(triplet, 1)
  end

  def product([], total), do: total
  def product([n|rest], total) do
    product(rest, total * n)
  end

  def pythagorean?([a, b, c]) do
    (a * a) + (b * b) == (c * c)
  end

  def generate(min, max) do
    for a <- min..max, b <- a..max, c <- b..max,
        pythagorean?([a, b, c]),
        do: [a, b, c]
  end

  def generate(min, max, sum) do
    generate(min, max) |> Enum.filter(&(sum(&1) == sum))
  end
end
