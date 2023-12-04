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
      """
      1abc2
      pqr3stu8vwx
      a1b2c3d4e5f
      treb7uchet
      """
      |> String.split("\n", trim: true)
      |> Day1.part1()

    assert(result == 142)
  end

  @tag :day1part2
  test "day1 part2 sample" do
    result =
      """
      two1nine
      eightwothree
      abcone2threexyz
      xtwone3four
      4nineeightseven2
      zoneight234
      7pqrstsixteen
      """
      |> String.split("\n", trim: true)
      |> Day1.part2()

    assert result == 281
  end

  @tag :day2part1
  test "day2 part1 sample" do
    result =
      """
      Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
      Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
      Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
      Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
      Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
      """
      |> String.split("\n")
      |> Day2.part1()

    assert result == 8
  end

  @tag :day2part2
  test "day2 part2 sample" do
    result =
      """
      Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
      Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
      Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
      Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
      Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
      """
      |> String.split("\n")
      |> Day2.part2()

    assert result == 2286
  end

  @tag :day3part1
  test "day3 part1 sample" do
    result =
      """
      467..114..
      ...*......
      ..35..633.
      ......#...
      617*......
      .....+.58.
      ..592.....
      ......755.
      ...$.*....
      .664.598..
      """
  end

  @tag :print
  test "print" do
    read_input(2)
    |> Day2.part2()
    |> IO.puts()

    assert false
  end
end
