defmodule PrimeFactors do
  def factors_for(number) do
    factors(number, 2, [])
  end

  defp factors(number, divisor, result) when (divisor * divisor) > number do
    final_result = if number > 1, do: [number|result], else: result
    Enum.reverse(final_result)
  end

  defp factors(number, divisor, result) when rem(number, divisor) == 0 do
    factors(div(number, divisor), divisor, [divisor|result])
  end

  defp factors(number, divisor, result) do
    factors(number, divisor + 1, result)
  end
end
