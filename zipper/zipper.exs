defmodule BinTree do
  defstruct value: nil, left: nil, right: nil
end

defmodule Zipper do
  def from_tree(bt) do
    {[], bt}
  end

  def to_tree({[], bt}), do: bt
  def to_tree({[{:left, value, right}|trail], left}) do
    {trail, %BinTree{value: value, left: left, right: right}} |> to_tree
  end

  def to_tree({[{:right, value, left}|trail], right}) do
    {trail, %BinTree{value: value, left: left, right: right}} |> to_tree
  end

  def value({_trail, %BinTree{value: value}}) do
    value
  end

  def left({_trail, %{left: nil}}), do: nil
  def left({trail, %{value: value, left: left, right: right}}) do
    new_trail = [{:left, value, right} | trail]
    {new_trail, left}
  end

  def right({_trail, %{right: nil}}), do: nil
  def right({trail, %{value: value, left: left, right: right}}) do
    new_trail = [{:right, value, left} | trail]
    {new_trail, right}
  end

  def up({[], _}), do: nil

  def up({[{:left, value, right}|trail], left}) do
    {trail, %BinTree{value: value, left: left, right: right}}
  end

  def up({[{:right, value, left}|trail], right}) do
    {trail, %BinTree{value: value, left: left, right: right}}
  end

  def set_value({trail, bt}, v) do
    {trail, %{bt | value: v}}
  end

  def set_left({trail, bt}, l) do
    {trail, %{bt | left: l}}
  end

  def set_right({trail, bt}, r) do
    {trail, %{bt | right: r}}
  end
end
