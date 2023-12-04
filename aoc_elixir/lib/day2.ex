defmodule Day2 do
  @color_limits %{"red" => 12, "green" => 13, "blue" => 14}

  @spec part1(list()) :: integer()
  def part1(input) do
    input
    |> Enum.reduce(0, fn line, acc ->
      case Regex.run(~r"Game (\d+): (.+)", line) do
        nil ->
          acc

        [_, game_id, games] ->
          if game_exceeds_limit?(games) do
            acc
          else
            acc + (game_id |> String.to_integer())
          end
      end
    end)
  end

  defp game_exceeds_limit?(games) do
    games
    |> String.split(";", trim: true)
    |> Enum.any?(&ball_exceeds_limit?/1)
  end

  defp ball_exceeds_limit?(game) do
    game
    |> String.split(",", trim: true)
    |> Enum.any?(&color_exceeds_limit?/1)
  end

  defp color_exceeds_limit?(ball) do
    with [_, count, color] <- Regex.run(~r/(\d+) (\w+)/, ball),
         limit when is_integer(limit) <- Map.fetch!(@color_limits, color),
         count = String.to_integer(count) do
      count > limit
    else
      _ -> false
    end
  end

  def part2(input) do
    input
    |> Enum.reduce(0, fn line, acc ->
      case Regex.run(~r"Game (\d+): (.+)", line) do
        nil ->
          acc

        [_, _game_id, games] ->
          ball_counter = fewest_balls(games)

          ball_counter
          |> Map.keys()
          |> Enum.reduce(1, fn color, acc ->
            acc * ball_counter[color]
          end)
          |> Kernel.+(acc)
      end
    end)
  end

  defp fewest_balls(games) do
    counter = %{red: 0, green: 0, blue: 0}

    games
    |> String.split(";", trim: true)
    |> Enum.reduce(counter, fn balls, acc ->
      ball_counts = ball_count(balls)

      Map.keys(ball_counts)
      |> Enum.reduce(acc, fn color, acc ->
        Map.update!(acc, color, fn existing ->
          if ball_counts[color] > acc[color] do
            ball_counts[color]
          else
            existing
          end
        end)
      end)
    end)
  end

  defp ball_count(game) do
    counter = %{red: 0, green: 0, blue: 0}

    game
    |> String.split(",", trim: true)
    |> Enum.reduce(counter, fn ball, acc ->
      [_, count, color] = Regex.run(~r/(\d+) (\w+)/, ball)

      Map.update!(acc, String.to_atom(color), &(&1 + String.to_integer(count)))
    end)
  end
end
