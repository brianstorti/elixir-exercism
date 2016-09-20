defmodule Binary do
  def to_decimal(string) do
    string
      |> String.codepoints
      |> to_decimal(0)
  end

  defp to_decimal([], result), do: result
  defp to_decimal(["0"|rest], result), do: to_decimal(rest, result * 2)
  defp to_decimal(["1"|rest], result), do: to_decimal(rest, (result * 2) + 1)
  defp to_decimal(_, _), do: 0
end
