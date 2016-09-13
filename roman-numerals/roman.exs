defmodule Roman do

  @romans [{1000, "M"},
           {900, "CM"},
           {500, "D"},
           {400, "CD"},
           {100, "C"},
           {90, "XC"},
           {50, "L"},
           {40, "XL"},
           {10, "X"},
           {9, "IX"},
           {5, "V"},
           {4, "IV"},
           {1, "I"}]

  @doc """
  Convert the number to a roman number.
  """
  @spec numerals(pos_integer) :: String.t
  def numerals(number) do
    numerals(number, "")
  end

  defp numerals(0, result), do: result

  defp numerals(to_convert, result) do
    {num, letter} = Enum.find(@romans, fn {numeral, roman} -> (to_convert / numeral) >= 1 end)
    times = (to_convert / num) |> Float.floor |> round
    remaining = rem(to_convert, num)

    numerals(remaining, result <> String.duplicate(letter, times))
  end
end
