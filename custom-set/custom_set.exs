defmodule CustomSet do
  defstruct elements: []

  def new(enumerable) do
    %CustomSet{elements: Enum.uniq(enumerable)}
  end

  def empty?(%CustomSet{elements: []}), do: true
  def empty?(%CustomSet{elements: [_h|_t]}), do: false

  def contains?(custom_set, element) do
    Enum.member?(custom_set.elements, element)
  end

  def subset?(custom_set_1, custom_set_2) do
    Enum.all?(custom_set_1.elements, fn elm -> contains?(custom_set_2, elm) end)
  end

  def disjoint?(custom_set_1, custom_set_2) do
    !Enum.any?(custom_set_1.elements, fn elm -> contains?(custom_set_2, elm) end)
  end

  def equal?(custom_set_1, custom_set_2) do
    Enum.sort(custom_set_1.elements) == Enum.sort(custom_set_2.elements)
  end

  def add(custom_set, element) do
    new([element|custom_set.elements])
  end

  def intersection(custom_set_1, custom_set_2) do
    Enum.filter(custom_set_1.elements, fn elm -> contains?(custom_set_2, elm) end)
      |> new
  end

  def difference(custom_set_1, custom_set_2) do
    Enum.filter(custom_set_1.elements, fn elm -> !contains?(custom_set_2, elm) end)
      |> new
  end

  def union(custom_set_1, custom_set_2) do
    new(custom_set_1.elements ++ custom_set_2.elements)
  end
end
