if !System.get_env("EXERCISM_TEST_EXAMPLES") do
  Code.load_file("luhn.exs", __DIR__)
end

ExUnit.start
ExUnit.configure exclude: :pending, trace: true

defmodule LuhnTest do
  use ExUnit.Case

  test "checksum" do
    assert Luhn.checksum("4913") == 22
  end

  test "checksum again" do
    assert Luhn.checksum("201773") == 21
  end

  test "invalid number" do
    assert Luhn.valid?("738") == false
  end

  test "valid number" do
    assert Luhn.valid?("8739567") == true
  end

  test "create valid number" do
    assert Luhn.create("123") == "1230"
  end

  test "create other valid number" do
    assert Luhn.create("873956") == "8739567"
  end

  test "create yet another valid number" do
    assert Luhn.create("837263756") == "8372637564"
  end
end
