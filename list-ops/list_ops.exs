defmodule ListOps do
  # Please don't use any external modules (especially List) in your
  # implementation. The point of this exercise is to create these basic functions
  # yourself.
  #
  # Note that `++` is a function from an external module (Kernel, which is
  # automatically imported) and so shouldn't be used either.

  @spec count(list) :: non_neg_integer
  def count(l) do
    count(l, 0)
  end

  defp count([], counter), do: counter

  defp count([_h|t], counter) do
    count(t, counter + 1 )
  end

  @spec reverse(list) :: list
  def reverse(l) do
    reverse(l, [])
  end

  defp reverse([], result), do: result

  defp reverse([h|t], result) do
    reverse(t, [h|result])
  end

  @spec map(list, (any -> any)) :: list
  def map(l, f) do
    map(l, f, [])
  end

  defp map([], _fun, result), do: reverse(result)

  defp map([h|t], fun, result) do
    map(t, fun, [fun.(h)|result])
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f) do
    filter(l, f, [])
  end

  defp filter([], _fun, result), do: reverse(result)

  defp filter([h|t], fun, result) do
    if fun.(h) do
      filter(t, fun, [h|result])
    else
      filter(t, fun, result)
    end
  end

  @type acc :: any
  @spec reduce(list, acc, ((any, acc) -> acc)) :: acc
  def reduce(l, acc, f) do
    reduce(l, acc, f, acc)
  end

  defp reduce([], _acc, _f, result), do: result

  defp reduce([h|t], acc, f, result) do
    reduce(t, acc, f, f.(h, result))
  end

  def append(a, b) do
    reduce(reverse(a), b, &[&1|&2])
  end

  def concat([]), do: []
  def concat([h|t]) do
    append(h, concat(t))
  end
end
