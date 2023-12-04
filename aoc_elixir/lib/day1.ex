defmodule Day1 do
  defp integer?(x) do
    case x |> Integer.parse() do
      :error -> false
      _ -> true
    end
  end

  def part1(input) do
    input
    |> Stream.map(&String.trim/1)
    |> Stream.map(fn line ->
      list = line |> String.graphemes()

      first_int =
        list
        |> Enum.find(fn x -> integer?(x) end)
        |> String.to_integer()

      last_int =
        list
        |> Enum.reverse()
        |> Enum.find(fn x -> integer?(x) end)
        |> String.to_integer()

      first_int * 10 + last_int
    end)
    |> Enum.reduce(0, &(&1 + &2))
  end

  defp part2_find_number(_trie, ""), do: nil

  defp part2_find_number(trie, string) do
    case Trie.get_word?(trie, string) do
      nil ->
        <<_, rest::binary>> = string
        part2_find_number(trie, rest)

      number ->
        number
    end
  end

  def part2(input) do
    trie = forward_trie()

    input
    |> Enum.map(fn line ->
      first_num = part2_find_number(trie, line)
      last_num = part2_find_number(backward_trie(), line |> String.reverse())

      first_num * 10 + last_num
    end)
    |> Enum.reduce(0, &(&1 + &2))
  end

  @numbersSpelledOut %{
    1 => "one",
    2 => "two",
    3 => "three",
    4 => "four",
    5 => "five",
    6 => "six",
    7 => "seven",
    8 => "eight",
    9 => "nine"
  }

  @numbers %{
    1 => "1",
    2 => "2",
    3 => "3",
    4 => "4",
    5 => "5",
    6 => "6",
    7 => "7",
    8 => "8",
    9 => "9"
  }

  defp forward_trie() do
    trie =
      @numbersSpelledOut
      |> Enum.reduce(Trie.create_root(), fn number, acc ->
        acc |> Trie.add_word(number |> elem(0), number |> elem(1))
      end)

    trie =
      @numbers
      |> Enum.reduce(trie, fn number, acc ->
        acc |> Trie.add_word(number |> elem(0), number |> elem(1))
      end)

    trie
  end

  defp backward_trie() do
    trie =
      @numbersSpelledOut
      |> Enum.reduce(Trie.create_root(), fn number, acc ->
        acc |> Trie.add_word(number |> elem(0), number |> elem(1) |> String.reverse())
      end)

    trie =
      @numbers
      |> Enum.reduce(trie, fn number, acc ->
        acc |> Trie.add_word(number |> elem(0), number |> elem(1))
      end)

    trie
  end
end
