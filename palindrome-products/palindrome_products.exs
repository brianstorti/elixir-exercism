defmodule Palindromes do
  def generate(max_factor, min_factor \\ 1) do
    find_palindromes(max_factor, min_factor)
    |> Enum.reduce(%{}, fn {n, result}, acc ->
      Map.update(acc, n, [result], &([result|&1]))
    end)
  end

  defp find_palindromes(max_factor, min_factor) do
    for a <- min_factor..max_factor,
        b <- a..max_factor,
        number = a * b,
        palindrome?(number),
        do: {number, [a, b]}
  end

  defp palindrome?(number) do
    list_of_number = number |> to_string |> String.codepoints
    list_of_number == Enum.reverse(list_of_number)
  end
end
