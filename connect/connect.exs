defmodule Connect do
  def result_for(board) do
    board = Enum.map(board, &String.graphemes/1)
    inverted_board = board |> List.zip |> Enum.map(&Tuple.to_list/1)

    cond do
      find_path(board, "O")   -> :white
      find_path(inverted_board, "X") -> :black
      true -> :none
    end
  end

  def find_path(board, player) do
    board
      |> Enum.map(&Enum.with_index/1)
      |> Enum.map(fn row -> for {^player, index} <- row, do: index end)
      |> find
  end

  def find(rows) when length(rows) == 1, do: true

  def find([current_row|next_rows]) do
    next_row = hd(next_rows)

    {direct, not_direct} = Enum.partition(next_row, fn(index) ->
      Enum.any?(current_row, &(index in (&1 - 1 .. &1)))
    end)

    {indirect, not_indirect} = Enum.partition(not_direct, fn(index) ->
      Enum.any?(direct, &(index in (&1 - 1 .. &1 + 1)))
    end)

    related_to_indirect = Enum.filter(not_indirect, fn(index) ->
      Enum.any?(indirect, &(index in (&1 - 1 .. &1 + 1)))
    end)

    result = direct ++ indirect ++ related_to_indirect
    if length(result) == 0 do
      false
    else
      find(next_rows)
    end
  end
end
