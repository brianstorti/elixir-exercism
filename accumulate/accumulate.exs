defmodule Accumulate do
  def accumulate(list, fun) do
    accumulate(list, fun, [])
  end

  defp accumulate([h|t], fun, acc) do
    accumulate(t, fun, [fun.(h)|acc])
  end

  defp accumulate([], _fun, acc), do: Enum.reverse(acc)
end
