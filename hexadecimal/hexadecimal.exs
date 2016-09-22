defmodule Hexadecimal do
  @hex_table %{
    "0" => 0, "1" => 1, "2" => 2, "3" => 3, "4" => 4, "5" => 5, "6" => 6,
    "7" => 7, "8" => 8, "9" => 9, "A" => 10, "B" => 11, "C" => 12, "D" => 13,
    "E" => 14, "F" => 15,
  }

  def to_decimal(hex) do
    letters = hex |> String.upcase |> String.codepoints

    if Enum.all?(letters, &(Map.has_key?(@hex_table, &1))) do
      letters
        |> Enum.map(&(Map.fetch!(@hex_table, &1)))
        |> Enum.reverse
        |> Enum.with_index
        |> Enum.reduce(0, fn {hex, index}, acc ->
          acc + (hex * (:math.pow(16, index)))
        end)
    else
      0
    end
  end
end
