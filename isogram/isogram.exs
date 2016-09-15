defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t) :: boolean
  def isogram?(sentence) do
    sentence
      |> sanitize
      |> same_letters?
  end

  defp same_letters?(letters) do
    length(letters) == length(Enum.uniq(letters))
  end

  defp sanitize(string) do
    Regex.scan(~r/\w/u, string) |> List.flatten
  end
end
