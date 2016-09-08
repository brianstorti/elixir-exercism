if !System.get_env("EXERCISM_TEST_EXAMPLES") do
  Code.load_file("nucleotide_count.exs", __DIR__)
end

ExUnit.start
ExUnit.configure exclude: :pending, trace: true

defmodule NucleotideCountTest do
  use ExUnit.Case

  test "empty dna string has no adenosine" do
    assert NucleotideCount.count('', ?A) == 0
  end

  test "repetitive cytidine gets counted" do
    assert NucleotideCount.count('CCCCC', ?C) == 5
  end

  test "counts only thymidine" do
    assert NucleotideCount.count('GGGGGTAACCCGG', ?T) == 1
  end

  test "empty dna string has no nucleotides" do
    expected = %{?A => 0, ?T => 0, ?C => 0, ?G => 0}
    assert NucleotideCount.histogram('') == expected
  end

  test "repetitive sequence has only guanosine" do
    expected = %{?A => 0, ?T => 0, ?C => 0, ?G => 8}
    assert NucleotideCount.histogram('GGGGGGGG') == expected
  end

  test "counts all nucleotides" do
    s = 'AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC'
    expected = %{?A => 20, ?T => 21, ?C => 12, ?G => 17}
    assert NucleotideCount.histogram(s) == expected
  end

  test "histogram validates the strand" do
    assert_raise ArgumentError, fn ->
      NucleotideCount.histogram('JOHNNYAPPLESEED')
    end
  end

  test "count validates the nucleotide" do
    assert_raise ArgumentError, fn ->
      NucleotideCount.count('', ?U)
    end
  end

  test "count validates the strand" do
    assert_raise ArgumentError, fn ->
      NucleotideCount.count('JOHNNYAPPLESEED', ?A)
    end
  end
end
