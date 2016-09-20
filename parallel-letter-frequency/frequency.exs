defmodule Frequency do
  def frequency([], _workers), do: %{}

  def frequency(texts, workers) do
    letters = texts |> Enum.join |> letters |> List.flatten

    chunks_size = case length(letters) / workers |> Float.floor |> round do
      0 -> 1
      value -> value
    end

    chunks = Enum.chunk(letters, chunks_size)
    tasks = Enum.map(chunks, &(Task.async(fn -> count(&1) end)))
    Enum.reduce(tasks, %{}, fn task, acc -> merge(acc, Task.await(task)) end)
  end

  defp merge(map1, map2) do
    Map.merge(map1, map2, fn _key, v1, v2 -> v1 + v2 end)
  end

  defp count(letters) do
    Enum.reduce(letters, %{}, fn letter, acc ->
      Map.update(acc, letter, 1, &(&1 + 1))
    end)
  end

  defp letters(text) do
    text = String.downcase(text)
    Regex.scan(~r/[^\d\W]/u, text)
  end
end
