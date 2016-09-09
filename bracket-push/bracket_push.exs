defmodule BracketPush do
  @open_brackets   ["[", "{", "("]
  @close_brackets  ["]", "}", ")"]

  @bracket_pairs ["]": "[",
                  "}": "{",
                  ")": "("]

  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t) :: boolean
  def check_brackets(str) do
    str |> String.graphemes |> check([])
  end

  defp check([], stack), do: Enum.empty?(stack)

  defp check([h|t], stack) when h in @open_brackets do
    check(t, [h|stack])
  end

  defp check([h|t], [stack_head|stack_tail]) when h in @close_brackets do
    open_pair = @bracket_pairs |> Keyword.fetch!(String.to_existing_atom(h))

    if stack_head == open_pair do
      check(t, stack_tail)
    else
      false
    end
  end

  defp check([h|t], stack) do
    check(t, stack)
  end
end
