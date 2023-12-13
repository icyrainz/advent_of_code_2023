defmodule Day3 do
  defp read_maps(input) do
    {number_map, symbol_map} =
      input
      |> Enum.with_index()
      |> Enum.reduce({%{}, %{}}, fn {line, row}, {number_map, symbol_map} ->
        read_schematic(line |> String.graphemes(), row, 0, "", 0, number_map, symbol_map)
      end)

    IO.puts("number_map: #{inspect(number_map)}")
    IO.puts("symbol_map: #{inspect(symbol_map)}")

    {number_map, symbol_map}
  end

  def part1(input) do
    {number_map, symbol_map} = read_maps(input)

    number_map
    |> Enum.reduce(0, fn item, acc ->
      case is_number_adjacent_to_symbol(item, symbol_map) do
        true ->
          acc + elem(item, 1)

        false ->
          acc
      end
    end)
  end

  defp is_number_adjacent_to_symbol({{row, start_idx, end_idx}, _}, symbol_map) do
    [
      {row - 1, start_idx - 1},
      {row - 1, end_idx + 1},
      {row, start_idx - 1},
      {row, end_idx + 1},
      {row + 1, start_idx - 1},
      {row + 1, end_idx + 1},
      start_idx..end_idx |> Enum.map(fn col_idx -> {row - 1, col_idx} end),
      start_idx..end_idx |> Enum.map(fn col_idx -> {row + 1, col_idx} end)
    ]
    |> List.flatten()
    |> Enum.any?(fn {row, col} ->
      Map.has_key?(symbol_map, {row, col})
    end)
  end

  defp read_schematic([], row, col, cur_number, num_start_idx, number_map, symbol_map) do
    new_number_map =
      if cur_number != "" do
        number_map
        |> Map.put(
          {
            row,
            num_start_idx,
            col - 1
          },
          String.to_integer(cur_number)
        )
      else
        number_map
      end

    {new_number_map, symbol_map}
  end

  defp read_schematic(
         [cur_char | rest],
         row,
         col,
         cur_number,
         num_start_idx,
         number_map,
         symbol_map
       ) do
    with {num, _} <- Integer.parse(cur_char) do
      read_schematic(
        rest,
        row,
        col + 1,
        "#{cur_number}#{num}",
        num_start_idx,
        number_map,
        symbol_map
      )
    else
      _ ->
        new_number_map =
          if cur_number != "" do
            number_map
            |> Map.put(
              {
                row,
                num_start_idx,
                col - 1
              },
              String.to_integer(cur_number)
            )
          else
            number_map
          end

        if cur_char =~ ~r/[^\w\s.]/ do
          read_schematic(
            rest,
            row,
            col + 1,
            "",
            col + 1,
            new_number_map,
            Map.put(symbol_map, {row, col}, cur_char)
          )
        else
          read_schematic(
            rest,
            row,
            col + 1,
            "",
            col + 1,
            new_number_map,
            symbol_map
          )
        end
    end
  end

  defp expand_number_map(number_map) do
    number_map
    |> Enum.reduce(%{}, fn {{row, start_idx, end_idx}, num}, acc ->
      start_idx..end_idx
      |> Enum.reduce(
        acc,
        fn col_idx, acc ->
          Map.put(
            acc,
            {row, col_idx},
            {{row, start_idx, end_idx}, num}
          )
        end
      )
    end)
  end

  def part2(input) do
    {number_map, symbol_map} = read_maps(input)

    expanded_number_map = expand_number_map(number_map)

    symbol_map
    |> Map.filter(fn {_, symbol} -> symbol == "*" end)
    |> Enum.reduce(0, fn {sym_pos, _}, acc ->
      get_numbers_adjacent_to_symbol(expanded_number_map, sym_pos) + acc
    end)
  end

  defp get_numbers_adjacent_to_symbol(number_map, {row, col}) do
    found_numbers =
      [
        {row - 1, col - 1},
        {row - 1, col},
        {row - 1, col + 1},
        {row, col - 1},
        {row, col + 1},
        {row + 1, col - 1},
        {row + 1, col},
        {row + 1, col + 1}
      ]
      |> Enum.map(fn {cur_row, cur_col} ->
        Map.get(number_map, {cur_row, cur_col})
      end)
      |> Enum.filter(&(&1 != nil))
      |> Enum.reduce(%MapSet{}, fn item, acc ->
        MapSet.put(acc, item)
      end)

    case MapSet.size(found_numbers) do
      x when x > 1 ->
        found_numbers
        |> MapSet.to_list()
        |> Enum.reduce(1, fn item, acc ->
          acc * elem(item, 1)
        end)

      _ ->
        0
    end
  end
end
