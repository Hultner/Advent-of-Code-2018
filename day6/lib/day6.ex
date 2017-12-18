defmodule Day6 do
  # Read the problem wrong and then kept hacking my solution until it fit 
  # the actual problem. It works and it's fast but it isn't pretty.

  defp max_mem(mem), do: mem |> Enum.max_by(fn {n, _} -> n end)

  def mem_dup({v, k}, m) do
    if Enum.count(m, fn {mv, _} -> mv == v end) > 1 do
      k
    else
      -1
    end
  end

  # Out of blocks, exit memory  distrubution cycle
  def mem_map(mem, _pos, 0, _), do: mem
  # Fix with rem
  def mem_map(mem, pos, blocks, bl) when pos >= length(mem) do
    mem_map(mem, 0, blocks, bl)
  end

  # Skippity skip blacklist
  def mem_map(mem, pos, blocks, blist) when pos == blist do
    mem_map(mem, pos + 1, blocks, blist)
  end

  def mem_map(mem, pos, blocks, bl) do
    mem
    |> List.replace_at(pos, Enum.at(mem, pos) |> (fn {v, k} -> {v + 1, k} end).())
    |> mem_map(pos + 1, blocks - 1, bl)
  end

  def reallocate(mem, alloc_set) do
    max_mem(mem)
    |> (fn {v, k} ->
          mem_map(
            List.replace_at(mem, k, {0, k}),
            k + 1,
            # Block at current memory page
            v,
            mem_dup({v, k}, mem)
          )
        end).()
    |> (fn new_mem ->
          if Map.has_key?(alloc_set, new_mem) do
            # If the new set is a previous seen one we should return
            # {total_steps, steps_first_seen}
            Enum.count(alloc_set)
            |> (fn stp -> {stp, stp - Map.get(alloc_set, new_mem)} end).()
          else
            # Since allocation set hasn't been seen we run another round
            reallocate(new_mem, Map.put(alloc_set, new_mem, Enum.count(alloc_set)))
          end
        end).()
  end

  defp solv(input, part) do
    read_input(input)
    |> (fn x -> reallocate(x, %{x => 0}) end).()
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
