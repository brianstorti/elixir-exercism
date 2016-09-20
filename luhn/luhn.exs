defmodule Luhn do
  def checksum(number) do
    number
      |> String.codepoints
      |> Enum.reverse
      |> Enum.with_index
      |> Enum.map(&multiply_digit/1)
      |> Enum.sum
  end

  defp multiply_digit({digit, index}) do
    n = String.to_integer(digit)
    if rem(index, 2) == 0, do: n, else: result(n * 2)
  end

  defp result(number) when number > 10, do: number - 9
  defp result(number), do: number

  def valid?(number) do
    rem(checksum(number), 10) == 0
  end

  def create(number) do
    case "#{number}0" |> checksum |> rem(10) do
      0      -> "#{number}0"
      result -> "#{number}#{10 - result}"
    end
  end
end
