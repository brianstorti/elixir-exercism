defmodule RunLengthEncoder do
  def encode(""), do: ""

  def encode(<<letter::utf8, rest::binary>>) do
    encode(rest, letter, 1, "")
  end

  defp encode(<<letter::utf8, rest::binary>>, letter, count, acc) do
    encode(rest, letter, count + 1, acc)
  end

  defp encode(<<letter::utf8, rest::binary>>, last_char, count, acc) do
    encode(rest, letter, 1, acc <> to_string(count) <> <<last_char::utf8>>)
  end

  defp encode("", last_char, count, acc) do
    acc <> to_string(count) <> <<last_char::utf8>>
  end

  def decode(string) do
    pairs = Regex.scan(~r/[0-9]*\w/, string) |> List.flatten
    decode(pairs, "")
  end

  def decode([], result), do: result

  def decode([head | tail], result) do
    {number, letter} = Integer.parse(head)
    decode(tail, result <> String.duplicate(letter, number))
  end
end
