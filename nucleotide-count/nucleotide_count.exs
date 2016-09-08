defmodule NucleotideCount do
  @nucleotides [?A, ?C, ?G, ?T]

  def count(_strand, nucleotide) when not nucleotide in @nucleotides do
    raise ArgumentError
  end

  def count(strand, nucleotide) do
    filter_fn = fn char ->
      unless char in @nucleotides, do: raise ArgumentError
      char == nucleotide
    end

    Enum.count(strand, filter_fn)
  end

  def histogram(strand) do
    Enum.reduce(@nucleotides, %{}, fn nucleotide, acc ->
      Map.put(acc, nucleotide, count(strand, nucleotide))
    end)
  end
end
