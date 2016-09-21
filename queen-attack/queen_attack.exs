defmodule Queens do
  @type t :: %Queens{ black: {integer, integer}, white: {integer, integer} }
  defstruct black: nil, white: nil

  def new do
    new({0, 3}, {7, 3})
  end

  def new(position, position), do: raise ArgumentError

  def new(white, black) do
    struct(Queens, %{ white: white, black: black })
  end

  def to_string(queens) do
    board_size = 0..7

    board = for x <- board_size, y <- board_size do
      cond do
        {x, y} == queens.black -> "B"
        {x, y} == queens.white -> "W"
        true -> "_"
      end
    end

    board
      |> Enum.chunk(8)
      |> Enum.map(&Enum.join(&1, " "))
      |> Enum.join("\n")
  end

  def can_attack?(%Queens{ black: {row, _}, white: {row, _} }), do: true
  def can_attack?(%Queens{ black: {_, column}, white: {_, column} }), do: true
  def can_attack?(%Queens{ black: {black_row, black_column}, white: {white_row, white_column} }) do
    abs(black_row - white_row) == abs(black_column - white_column)
  end
end
