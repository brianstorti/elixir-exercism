defmodule FlattenArray do
  def flatten(list) do
    flatten(list, [])
  end

  defp flatten([], result), do: result

  defp flatten([h|t], result) when is_list(h) do
    flatten(h, flatten(t, result))
  end

  defp flatten([nil|t], result) do
    flatten(t, result)
  end

  defp flatten([h|t], result) do
    [h|flatten(t, result)]
  end
end
