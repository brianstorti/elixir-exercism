defmodule Atbash do
  def encode(plaintext) do
    plaintext
      |> sanitize
      |> convert(conversion_table, [])
  end

  defp convert([], _table, result) do
    result
      |> Enum.reverse
      |> Enum.chunk(5, 5, [])
      |> Enum.join(" ")
  end

  defp convert([letter|rest], table, converted) do
    convert(rest, table, [Map.fetch!(table, letter)|converted])
  end

  defp sanitize(text) do
    Regex.scan(~r/[a-z0-9]/u, String.downcase(text)) |> List.flatten
  end

  defp conversion_table do
    numbers = Map.new(0..9, &{to_string(&1), to_string(&1)})

    letters(?a..?z)
      |> Enum.zip(letters(?z..?a))
      |> Enum.into(%{})
      |> Map.merge(numbers)
  end

  defp letters(range) do
    range
      |> Enum.to_list
      |> to_string
      |> String.codepoints
  end
end
