defmodule RailFenceCipher do
  def encode(str, 1), do: str
  def encode(str, rails) do
    letters = String.codepoints(str)
    rows = List.duplicate([], rails)
    indexes = Enum.to_list(0..rails - 1) ++ Enum.to_list(rails - 2..1) |> Stream.cycle |> Enum.take(length(letters))

    encode(letters, rows, indexes)
  end

  def encode([], rows, _indexes), do: rows |> Enum.map(&Enum.reverse/1) |> Enum.join

  def encode([letter|letter_tail], rows, [index|index_tail]) do
    list = [letter|Enum.at(rows, index)]
    encode(letter_tail, List.replace_at(rows, index, list), index_tail)
  end

  def decode(str, rails) do
  end
end
