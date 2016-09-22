defmodule Matrix do
  def rows(str) do
    str
      |> String.split("\n")
      |> Enum.map(fn row_as_string ->
        row_as_string |> String.split |> Enum.map(&String.to_integer/1)
      end)
  end

  def columns(str) do
    rows = rows(str)
    number_of_columns = rows |> Enum.at(0) |> length

    0..number_of_columns
      |> Enum.map(fn column_number ->
          Enum.map(rows, fn row -> Enum.at(row, column_number) end)
      end)
  end

  def saddle_points(str) do
    rows = rows(str)
    columns = columns(str)

    for {row, row_index} <- Enum.with_index(rows),
        {column, column_index} <- Enum.with_index(columns),
        Enum.max(row) == Enum.min(column),
        do: {row_index, column_index}
  end
end
