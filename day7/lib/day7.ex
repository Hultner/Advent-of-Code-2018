defmodule Day7 do
    
    # Read the problem wrong and then kept hacking my solution until it fit 
    # the actual problem. It works and it's fast but it isn't pretty.

    def read_input(file) do 
        file
        |> File.stream! 
        |> (CSV.decode!separator: ?\t)
        |> (Enum.take 1)
        |> hd 
        |> (Enum.map &String.to_integer/1)
        |> Enum.with_index
    end
    
    (defp max_mem(mem), 
        do: mem
            |> (Enum.max_by fn{n, _} -> n end)
    )

    def mem_dup({v,k},m) do
        if Enum.count(m, fn {mv, _} -> mv == v end) > 1 do 
            k 
            else -1 
        end
    end

    def mem_map(mem, _pos, 0, _), do: mem
    def mem_map(mem, pos, blocks, bl) when pos >= length(mem) do
        mem_map(mem, 0, blocks, bl)
    end
    # Skippity skip
    def mem_map(mem, pos, blocks, blist) when pos == blist do
        mem_map(mem, pos+1, blocks, blist)
    end
    def mem_map(mem, pos, blocks, bl) do
        mem
        |> List.replace_at(
            pos,
            Enum.at(mem, pos)
            |> ( fn{v,k} -> {v+1,k} end).()
        ) 
        |> mem_map(pos+1, blocks-1, bl)
    end

    @solv [{1, 0}, {0, 1}, {14, 2}, {14, 3}, {12, 4}, {12, 5}, {10, 6}, {10, 7},
    {8, 8},  {8, 9}, {6, 10}, {6, 11}, {4, 12}, {3, 13}, {2, 14}, {1, 15}]

    def reallocate(mem, alloc_set) do
        mem
        |> max_mem
        |> (fn{v,k} ->
            mem_map(
                mem |> List.replace_at(k,{0,k}), 
                k+1, 
                v, 
                mem_dup( {v,k}, mem)
            )
        end
        ).()
        |> (fn new_mem ->
                if MapSet.member?(alloc_set, new_mem) do # or new_mem == @solv do
                    MapSet.size(alloc_set)
                else
                    reallocate(new_mem, MapSet.put(alloc_set, new_mem)) 
                end
            end
           ).()
    end
    
    def solution_part_1(input),
        do: read_input(input)
            |> (fn x -> reallocate(x, MapSet.new([x])) end).()
            
    def solution_part_2(),
        do: nil #(jump_2 read_input("input"), 0, 0) 
           
end
