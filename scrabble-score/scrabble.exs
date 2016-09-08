defmodule Scrabble do
  def score(word) do
    word |> String.upcase |> String.graphemes |> score(0)
  end

  defp score([], result), do: result

  defp score([h|t], result) do
    score(t, result + value_of(h))
  end

  def value_of(letter) when letter in ~w(A E I O U L N R S T), do: 1
  def value_of(letter) when letter in ~w(D G), do: 2
  def value_of(letter) when letter in ~w(B C M P), do: 3
  def value_of(letter) when letter in ~w(F H V W Y), do: 4
  def value_of(letter) when letter in ~w(K), do: 5
  def value_of(letter) when letter in ~w(J X), do: 8
  def value_of(letter) when letter in ~w(Q Z), do: 10
  def value_of(_letter), do: 0
end
