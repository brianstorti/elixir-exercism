defmodule ETL do
  def transform(input) do
    Enum.reduce(input, %{}, &convert/2)
  end

  defp convert({value, words}, acc) do
    words
      |> Enum.map(&({String.downcase(&1), value}))
      |> Enum.into(%{})
      |> Map.merge(acc)
  end
end
