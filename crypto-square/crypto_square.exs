defmodule CryptoSquare do
  def encode(""), do: ""
  def encode(str) do
    normalized = Regex.scan(~r/\w/u, String.downcase(str)) |> List.flatten
    columns = normalized |> length |> :math.sqrt |> Float.ceil |> trunc

    normalized
      |> Enum.chunk(columns, columns, Stream.cycle([""]))
      |> List.zip
      |> Enum.map(&Tuple.to_list/1)
      |> Enum.join(" ")
  end
end
