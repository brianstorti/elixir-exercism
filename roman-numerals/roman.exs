defmodule Roman do
  @romans [
    {"M",  1000},
    {"CM", 900},
    {"D",  500},
    {"CD", 400},
    {"C",  100},
    {"XC", 90},
    {"L",  50},
    {"XL", 40},
    {"X",  10},
    {"IX", 9},
    {"V",  5},
    {"IV", 4},
    {"I",  1}
  ]

  @doc """
  Convert the number to a roman number.
  """
  @spec numerals(pos_integer) :: String.t
  def numerals(number) do
    numerals(@romans, number, "")
  end

  def numerals(_romans, 0, result), do: result

  def numerals([{_letter, number} | t], to_convert, result) when to_convert < number do
    numerals(t, to_convert, result)
  end

  def numerals([{letter, number} | _t] = list, to_convert, result) do
    numerals(list, to_convert - number, result <> letter)
  end
end
