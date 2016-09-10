defmodule RNATranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RNATranscription.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    to_rna(dna, [])
  end

  defp to_rna([], result), do: Enum.reverse(result)

  defp to_rna([h|t], result)  do
    to_rna(t, [complement(h) | result])
  end

  defp complement(?G), do: ?C
  defp complement(?C), do: ?G
  defp complement(?T), do: ?A
  defp complement(?A), do: ?U
end
