defmodule Bob do
  def hey(input) do
    sanitized_input = sanitize(input)

    cond do
      empty?(sanitized_input) -> "Fine. Be that way!"
      question?(sanitized_input) -> "Sure."
      shouting?(sanitized_input) -> "Whoa, chill out!"
      true -> "Whatever."
    end
  end

  defp empty?(input) do
    String.length(input) == 0
  end

  defp question?(input) do
    String.ends_with?(input, "?")
  end

  defp shouting?(input) do
    # uh?
    input = String.replace(input, ~r/(\d|,)/, "") |> sanitize
    String.upcase(input) == input && !empty?(input)
  end

  defp sanitize(input) do
    input |> String.strip
  end
end
