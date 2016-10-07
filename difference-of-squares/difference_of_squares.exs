defmodule Squares do
  def sum_of_squares(number) do
    Enum.reduce(1..number, & &2 + (&1 * &1))
  end

  def square_of_sums(number) do
    sum = Enum.sum(1..number)
    sum * sum
  end

  def difference(number) do
    square_of_sums(number) - sum_of_squares(number)
  end
end
