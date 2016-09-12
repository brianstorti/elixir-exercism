defmodule Prime do

  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(count) when count > 0 do
    Stream.iterate(1, &(&1+1))
      |> Stream.filter(&prime?/1)
      |> Enum.fetch!(count - 1)
  end

  defp prime?(number) when number <= 1, do: false
  defp prime?(2), do: true
  defp prime?(number) do
    upper_bound = :math.sqrt(number) |> round

    Enum.filter(2..upper_bound, &(rem(number, &1) == 0))
      |> Enum.empty?
  end
end
