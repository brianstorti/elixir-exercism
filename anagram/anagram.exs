defmodule Anagram do
  def match(base, candidates) do
    find_anagrams(base, candidates) |> filter_out_duplicates(base)
  end

  defp find_anagrams(base, candidates) do
    is_anagram = fn candidate ->
      sorted_letters(base) == sorted_letters(candidate)
    end

    Enum.filter(candidates, is_anagram)
  end

  defp filter_out_duplicates(anagrams, base) do
    Enum.filter(anagrams, fn a -> String.downcase(a) != String.downcase(base) end)
  end

  defp sorted_letters(string) do
    string |> String.downcase |> String.graphemes |> Enum.sort
  end
end
