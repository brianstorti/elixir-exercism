defmodule PascalsTriangle do
  @spec rows(integer) :: [[integer]]
  def rows(num) do
    rows = num - 1

    0..rows |> Enum.map(fn row ->
      0..row |> Enum.map(fn column ->
        value_for(row, column)
      end)
    end)
  end

  # As defined here: http://www.mathsisfun.com/pascals-triangle.html
  defp value_for(row, column) do
    factorial(row) / (factorial(column) * factorial(row - column))
  end

  defp factorial(0), do: 1
  defp factorial(1), do: 1
  defp factorial(n) do
    n * factorial(n - 1)
  end
end
