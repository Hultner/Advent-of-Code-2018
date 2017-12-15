defmodule Day5 do
  def jump(list, pos, count, _) when pos < 0 or pos >= map_size(list) do
    count
  end

  def jump(list, pos, count, mutator) do
    Map.get_and_update(list, pos, &{&1, mutator.(&1)})
    |> (fn {old_value, new_map} ->
          jump(new_map, old_value + pos, count + 1, mutator)
        end).()
  end

  def new_value_1(val), do: val + 1

  def new_value_2(val) when val >= 3, do: val - 1
  def new_value_2(val), do: val + 1

  def read_input() do
    File.stream!("input")
    |> Stream.map(&(String.trim(&1) |> String.to_integer()))
    |> Stream.with_index()
    |> Map.new(fn {v, k} -> {k, v} end)
  end

  def solution_part_1(), do: jump(read_input(), 0, 0, &new_value_1/1)

  def solution_part_2(), do: jump(read_input(), 0, 0, &new_value_2/1)
end
