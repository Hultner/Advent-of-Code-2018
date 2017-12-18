defmodule Day6 do
  # Read the problem wrong and then kept hacking my solution until it fit 
  # the actual problem. It works and it's fast but it isn't pretty.

  defp max_mem(mem), do: mem |> Enum.max_by(fn {n, _} -> n end)

  # Out of blocks, exit memory  distrubution cycle
  def mem_map(mem, _pos, 0), do: mem
  def mem_map(mem, pos, blocks) do
    wrap_pos = rem(pos, length(mem))
    List.replace_at(mem, wrap_pos,
      Enum.at(mem, wrap_pos) |> (fn {v, k} -> {v + 1, k} end).()
    )
    |> mem_map(wrap_pos + 1, blocks - 1)
  end

  def reallocate(mem, alloc_set) do
    max_mem(mem)
    |> (fn {blocks, pos} ->
          mem_map(
            List.replace_at(mem, pos, {0, pos}),
            pos + 1,
            blocks
          )
        end).()
    |> (fn new_mem ->
          if Map.has_key?(alloc_set, new_mem) do
            # If the new set is a previous seen one we should return
            # {total_steps, steps_first_seen}
            Enum.count(alloc_set)
            |> (fn step -> {step, step - Map.get(alloc_set, new_mem)} end).()
          else
            # Since allocation set hasn't been seen we run another round
            reallocate(new_mem, Map.put(alloc_set, new_mem, Enum.count(alloc_set)))
          end
        end).()
  end

  defp solv(input, part) do
    read_input(input)
    |> (fn init_memory -> reallocate(init_memory, %{init_memory => 0}) end).()
    |> elem(part - 1)
  end

  def solution_part_1(input), do: input |> solv(1)
  def solution_part_2(input), do: input |> solv(2)

  def read_input(file) do
    File.stream!(file)
    |> CSV.decode!(separator: ?\t)
    |> Enum.take(1)
    |> hd
    |> Stream.map(&String.to_integer/1)
    |> Enum.with_index()
  end
end
