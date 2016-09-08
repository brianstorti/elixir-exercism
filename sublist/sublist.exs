defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, a), do: :equal
  def compare(a, b) when length(a) == length(b), do: :unequal
  def compare([], _a), do: :sublist
  def compare(_a, []), do: :superlist

  def compare(superlist, sublist) when length(superlist) > length(sublist) do
    if contained(superlist, sublist) do
      :superlist
    else
      :unequal
    end
  end

  def compare(sublist, superlist) when length(sublist) < length(superlist) do
    if contained(superlist, sublist) do
      :sublist
    else
      :unequal
    end
  end

  defp contained(superlist, [head | _tail] = sublist) do
    find_indexes_with_value = fn { value, _index } -> value == head end
    extract_index = fn { _value, index } -> index end

    Enum.with_index(superlist)
    |> Enum.filter_map(find_indexes_with_value, extract_index)
    |> find_in_order(superlist, sublist)
  end

  defp find_in_order([], _superlist, _sublist), do: false

  defp find_in_order([index| tail], superlist, sublist) do
    if Enum.slice(superlist, index, length(sublist)) === sublist do
      true
    else
      find_in_order(tail, superlist, sublist)
    end
  end
end
