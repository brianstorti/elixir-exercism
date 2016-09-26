defmodule Sieve do
  def primes_to(limit) do
    marked_numbers = 2..limit
                       |> Enum.map(&{&1, true})
                       |> find_primes(limit, 2, 0)

    for {number, true} <- marked_numbers, do: number
  end

  defp find_primes(marked_numbers, limit, number, _index) when (number * number) > limit do
    marked_numbers
  end

  defp find_primes(marked_numbers, limit, number, index) do
    to_take = div(limit, number)
    positions_to_mark = Stream.iterate(index + number, &(&1 + number)) |> Enum.take(to_take)

    marked_numbers
      |> mark(positions_to_mark)
      |> find_primes(limit, number + 1, index + 1)
  end

  defp mark(tuples, []), do: tuples

  defp mark(tuples, [position|rest]) do
    new_tuples = List.update_at(tuples, position, fn {number, _} -> { number, false } end)
    mark(new_tuples, rest)
  end
end
