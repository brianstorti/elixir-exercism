defmodule Garden do
  @student_names  ~w(alice bob charlie david
                     eve fred ginny harriet
                     ileana joseph kincaid larry)a

  @plants %{ "V" => :violets,
             "G" => :grass,
             "C" => :clover,
             "R" => :radishes }

  def info(info_string, student_names \\ @student_names) do
    [first_row, second_row] = String.split(info_string, "\n") |> Enum.map(&to_plants/1)
    names = Enum.sort(student_names)

    %{}
      |> find_plants(names, first_row)
      |> find_plants(names, second_row)
  end

  def to_plants(letters) do
    letters
      |> String.codepoints
      |> Enum.map(&(Map.fetch!(@plants, &1)))
  end

  defp find_plants(result, [], _plants), do: result

  defp find_plants(result, [student|rest], []) do
    Map.put(result, student, {})
  end

  defp find_plants(result, [student|students_rest], plants) do
    {[plant_a, plant_b], plants_rest} = Enum.split(plants, 2)

    {_, new_result} = Map.get_and_update(result, student, fn current_plants ->
      new_plants = case current_plants do
        nil -> {plant_a, plant_b}
        _ -> current_plants |> Tuple.append(plant_a) |> Tuple.append(plant_b)
      end

      {current_plants, new_plants}
    end)

    find_plants(new_result, students_rest, plants_rest)
  end
end
