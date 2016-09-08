defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t) :: map
  def count(sentence) do
    sanitized_input = sanitize_input(sentence)
    count(String.split(sanitized_input), %{})
  end

  defp count([], result), do: result

  defp count([h|t], result) do
    new_result = Map.update(result, h, 1, &(&1 + 1))
    count(t, new_result)
  end

  defp sanitize_input(input) do
    input
      |> String.strip
      |> String.downcase
      |> String.replace(~r/[^\p{L}\d-]/u, " ")
  end
end
