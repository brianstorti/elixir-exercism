defmodule Change do
  def generate(_amount, []), do: :error
  def generate(amount, available_coins) do
    available_coins = Enum.sort(available_coins, &(&1 > &2))
    coins_to_give = Map.new(available_coins, &{&1, 0})

    find_coins(amount, available_coins, coins_to_give)
  end

  defp find_coins(0, _available_coins, coins_to_give), do: {:ok, coins_to_give}
  defp find_coins(_remaining, [], _coins_to_give), do: :error
  defp find_coins(amount, [coin | rest], coins_to_give) when coin > amount do
    find_coins(amount, rest, coins_to_give)
  end

  defp find_coins(amount, [coin | rest] = available_coins, coins_to_give) do
    remaining = amount - coin

    divisable? = &(rem(remaining, &1) == 0)
    if Enum.any?(available_coins, divisable?) do
      new_coins_to_give = Map.update!(coins_to_give, coin, &(&1 + 1))
      find_coins(remaining, available_coins, new_coins_to_give)
    else
      find_coins(amount, rest, coins_to_give)
    end
  end
end
