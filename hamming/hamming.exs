defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance('AAGTCATA', 'TAGCGATC')
  {:ok, 4}
  """
  @spec hamming_distance([char], [char]) :: non_neg_integer
  def hamming_distance(strand1, strand2) when length(strand1) != length(strand2) do
    {:error, "Lists must be the same length"}
  end

  def hamming_distance(strand1, strand2) do
    hamming_distance(strand1, strand2, 0)
  end

  defp hamming_distance([], [], difference), do: {:ok, difference}

  defp hamming_distance([h | t1], [h | t2], difference) do
    hamming_distance(t1, t2, difference)
  end

  defp hamming_distance([_h1 | t1], [_h2 | t2], difference) do
    hamming_distance(t1, t2, difference + 1)
  end
end
