defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, factors) do
    1..(limit-1)
      |> Enum.filter(&(multiple_of_any(&1, factors)))
      |> Enum.sum
  end

  defp multiple_of_any(_number, []), do: false
  defp multiple_of_any(number, [factor | rest]) do
    if rem(number, factor) == 0 do
      true
    else
      multiple_of_any(number, rest)
    end
  end
end
