defmodule AocElixirTest do
  use ExUnit.Case
  doctest AocElixir

  defp read_input(day) do
    File.stream!("../inputs/day#{day}.txt")
    |> Stream.map(&String.trim/1)
    |> Enum.to_list()
  end

  @tag :day1part1
  test "day1 part1 sample" do
    result =
      "1abc2
pqr3stu8vwx
a1b2c3d4e5f
treb7uchet"
      |> String.split("\n", trim: true)
      |> Day1.part1()

    assert(result == 142)
  end

  @tag :day1part1
  test "day1 part1 final" do
    result =
      read_input(1)
      |> Day1.part1()
      |> IO.puts()
  end

  @tag :day1part2
  test "day1 part2 sample" do
    result =
      "two1nine
eightwothree
abcone2threexyz
xtwone3four
4nineeightseven2
zoneight234
7pqrstsixteen"
      |> String.split("\n", trim: true)
      |> Day1.part2()

    assert result == 281
  end

  @tag :day1part2
  test "day1 part2 final" do
    result =
      read_input(1)
      |> Day1.part2()
      |> IO.puts()
  end
end
