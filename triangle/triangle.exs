defmodule Triangle do
  @triangle_inequality_error {:error, "side lengths violate triangle inequality"}

  @doc """
  Return the kind of triangle of a triangle with 'a', 'b' and 'c' as lengths.
  """

  def kind(a, b, c) when a <= 0 or b <= 0 or c <= 0, do: { :error, "all side lengths must be positive" }

  def kind(a, b, c) when a + b <= c, do: @triangle_inequality_error
  def kind(a, b, c) when a + c <= b, do: @triangle_inequality_error
  def kind(a, b, c) when b + c <= a, do: @triangle_inequality_error

  def kind(a, a, a), do: { :ok, :equilateral }

  def kind(a, a, b), do: { :ok, :isosceles }
  def kind(a, b, b), do: { :ok, :isosceles }
  def kind(a, b, a), do: { :ok, :isosceles }

  def kind(a, b, c), do: {:ok, :scalene}
end
