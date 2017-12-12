defmodule Day1 do
  def puzzle_sum([first | rest] = list) do
    Stream.zip(list, rest ++ [first])
    |> Stream.filter(fn {x, y} -> x == y end)
    |> Enum.reduce(0, fn {x, _}, acc -> acc + x end)
  end

  def puzzle_sum_half(list) do
    Enum.split(list, round(Enum.count(list) / 2))
    |> (fn {x, y} -> Enum.concat(y, x) end).()
    |> Enum.zip(list)
    |> Enum.filter(fn {x, y} -> x == y end)
    |> Enum.reduce(0, fn {x, _}, acc -> acc + x end)
  end

  def solution_part_1(number), do: Integer.digits(number) |> puzzle_sum
  def solution_part_2(number), do: Integer.digits(number) |> puzzle_sum_half
end
