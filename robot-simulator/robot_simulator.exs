defmodule RobotSimulator do
  @valid_direction [:north, :east, :south, :west]

  @left_movements  %{ north: :west, west: :south, south: :east, east: :north }
  @right_movements %{ north: :east, east: :south, south: :west, west: :north }

  def create do
    create(:north, {0, 0})
  end

  def create(direction, _position) when not direction in @valid_direction do
    { :error, "invalid direction" }
  end

  def create(direction, {x, y} = position) when is_integer(x) and is_integer(y) do
    %{direction: direction, position: position}
  end

  def create(_direction, _position) do
    { :error, "invalid position" }
  end

  def direction(robot) do
    Map.fetch!(robot, :direction)
  end

  def position(robot) do
    Map.fetch!(robot, :position)
  end

  def simulate(robot, ""), do: robot

  def simulate(robot, "L" <> instructions) do
    new_direction = Map.fetch!(@left_movements, robot.direction)
    %{robot | direction: new_direction} |> simulate(instructions)
  end

  def simulate(robot, "R" <> instructions) do
    new_direction = Map.fetch!(@right_movements, robot.direction)
    %{robot | direction: new_direction} |> simulate(instructions)
  end

  def simulate(robot, "A" <> instructions) do
    robot |> advance |> simulate(instructions)
  end

  def simulate(_invalid, _robot) do
    { :error, "invalid instruction" }
  end

  defp advance(%{direction: direction, position: {x, y}} = robot) do
    case direction do
      :north -> %{robot | position: {x, y + 1}}
      :south -> %{robot | position: {x, y - 1}}
      :east  -> %{robot | position: {x + 1, y}}
      :west  -> %{robot | position: {x - 1, y}}
    end
  end
end
