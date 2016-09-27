defmodule Series do
  def largest_product(_number_string, number) when number < 0, do: raise ArgumentError
  def largest_product(_number_string, 0), do: 1
  def largest_product(number_string, size) do
    number_string
      |> String.codepoints
      |> Enum.map(&String.to_integer/1)
      |> validate(size)
      |> find(size, 0)
  end

  defp validate(list, size) when length(list) < size, do: raise ArgumentError
  defp validate(list, _size), do: list

  defp find(list, size, largest) when length(list) < size, do: largest

  defp find(list, size, largest) do
    result = Enum.slice(list, 0..(size - 1)) |> Enum.reduce(1, &(&1 * &2))
    largest = if result > largest, do: result, else: largest

    list |> Enum.drop(1) |> find(size, largest)
  end
end
