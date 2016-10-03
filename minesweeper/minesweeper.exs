defmodule Minesweeper do
  def annotate(board) do
    board
     |> Enum.map(&String.codepoints/1)
     |> build([], [])
  end

  def build([], _, result), do: Enum.reverse(result)

  def build([current_row, next_row | rest], previous_row, result) do
    new_row = build_row(current_row, next_row, previous_row)
    build([next_row|rest], current_row, [new_row|result])
  end

  def build([last_row | []], previous_row, result) do
    new_row = build_row(last_row, [], previous_row)
    build([], last_row, [new_row|result])
  end

  def build_row(current, previous, next) do
    current
      |> Enum.with_index
      |> Enum.map(fn
        {"*", _} -> "*"
        {_, index} ->
        case count_bombs(current, previous, next, index) do
          0 -> " "
          num -> num |> to_string
        end
      end)
      |> Enum.join
  end

  defp count_bombs(current, previous, next, index) do
    range  = Enum.max([1, index]) - 1 .. index + 1
    above  = Enum.slice(previous, range)
    bellow = Enum.slice(next, range)
    this   = Enum.slice(current, range)

    [above, bellow, this]
      |> List.flatten
      |> Enum.filter(&(&1 == "*"))
      |> length
  end
end
