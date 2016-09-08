defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  def abbreviate(string) do
    Regex.scan(~r/\b\w|[A-Z]/, string)
      |> List.flatten
      |> Enum.join
      |> String.upcase
  end
end
