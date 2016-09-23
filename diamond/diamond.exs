defmodule Diamond do
  def build_shape(letter) do
    letters = (?A .. letter) |> Enum.to_list |> to_string |> String.codepoints
    position_to_start = length(letters) - 1

    bottom = build(letters, position_to_start, 0, [])
    top = bottom |> Enum.reverse

    (top ++ bottom)
      |> Enum.dedup
      |> Enum.join("\n")
      |> Kernel.<>("\n")
  end

  defp build([], _, _, result), do: result

  defp build([letter|rest], position_to_start, 0, result) do
    row = spaces(position_to_start) <> letter
    build(rest, position_to_start - 1, 1, [row|result])
  end

  defp build([letter|rest], position_to_start, spaces_between, result) do
    row =  spaces(position_to_start) <> letter <> spaces(spaces_between) <> letter
    build(rest, position_to_start - 1, spaces_between + 2, [row|result])
  end

  defp spaces(length) do
    String.duplicate(" ", length)
  end
end
