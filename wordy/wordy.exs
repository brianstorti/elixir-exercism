defmodule Wordy do
  @operations %{
    "plus" => &Kernel.+/2,
    "minus" => &Kernel.-/2,
    "multiplied" => &Kernel.*/2,
    "divided" => &Kernel.div/2,
    "raised" => &:math.pow/2
  }

  def answer(question) do
    ops = operations(question)
    if Enum.empty?(ops), do: raise ArgumentError

    question
      |> find_numbers
      |> apply_operations(ops)
  end

  def apply_operations([result|[]], _), do: result

  def apply_operations([n1, n2|rest_numbers], [operation|rest_operations]) do
    result = operation.(n1, n2)
    apply_operations([result|rest_numbers], rest_operations)
  end

  defp find_numbers(question) do
    Regex.scan(~r/-?\d+/, question)
      |> List.flatten
      |> Enum.map(&String.to_integer/1)
  end

  defp operations(question) do
    operation_names = Map.keys(@operations) |> Enum.join("|")
    Regex.scan(~r/#{operation_names}/, question)
      |> List.flatten
      |> Enum.map(&(Map.fetch!(@operations, &1)))
  end
end
