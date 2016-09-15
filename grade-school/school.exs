defmodule School do
  def add(db, name, grade) do
    Map.update(db, grade, [name], &([name|&1]))
  end

  def grade(db, grade) do
    Map.get(db, grade, [])
  end

  def sort(db) do
    Enum.map(db, fn {grade, names} -> {grade, Enum.sort(names)} end)
  end
end
