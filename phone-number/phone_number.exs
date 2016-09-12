defmodule Phone do

  @invalid "0000000000"
  @invalid_area_code "000"

  @doc """
  Remove formatting from a phone number.

  Returns "0000000000" if phone number is not valid
  (10 digits or "1" followed by 10 digits)

  ## Examples

  iex> Phone.number("123-456-7890")
  "1234567890"

  iex> Phone.number("+1 (303) 555-1212")
  "3035551212"

  iex> Phone.number("867.5309")
  "0000000000"
  """
  @spec number(String.t) :: String.t
  def number(raw) do
    raw
      |> sanitize
      |> check
  end

  defp sanitize(number) do
    number
      |> String.codepoints
      |> Enum.reject(fn digit -> Regex.match?(~r/\(|\)|\.|-|\s/, digit) end)
      |> Enum.join
  end

  defp check(number) when byte_size(number) < 10, do: @invalid
  defp check(number) when byte_size(number) == 10, do: number
  defp check("1" <> rest) when byte_size(rest) == 10, do: rest
  defp check(number), do: @invalid


  @doc """
  Extract the area code from a phone number

  Returns the first three digits from a phone number,
  ignoring long distance indicator

  ## Examples

  iex> Phone.area_code("123-456-7890")
  "123"

  iex> Phone.area_code("+1 (303) 555-1212")
  "303"

  iex> Phone.area_code("867.5309")
  "000"
  """
  @spec area_code(String.t) :: String.t
  def area_code(raw) do
    raw
      |> sanitize
      |> check_area_code
  end

  defp check_area_code(number) when byte_size(number) == 10, do: String.slice(number, 0..2)
  defp check_area_code("1" <> rest) when byte_size(rest) == 10, do: String.slice(rest, 0..2)
  defp check_area_code(number), do: @invalid_area_code

  @doc """
  Pretty print a phone number

  Wraps the area code in parentheses and separates
  exchange and subscriber number with a dash.

  ## Examples

  iex> Phone.pretty("123-456-7890")
  "(123) 456-7890"

  iex> Phone.pretty("+1 (303) 555-1212")
  "(303) 555-1212"

  iex> Phone.pretty("867.5309")
  "(000) 000-0000"
  """
  @spec pretty(String.t) :: String.t
  def pretty(raw) do
    raw |> number |> format
  end

  def format(number) do
    area = String.slice(number, 0, 3)
    exchange = String.slice(number, 3, 3)
    subscriber = String.slice(number, 6, 4)

    "(#{area}) #{exchange}-#{subscriber}"
  end
end
