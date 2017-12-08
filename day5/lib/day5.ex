defmodule Day5 do
    # Should refactor so jump and jump_2 uses the same jump with new_value cond.

    def jump(list, pos, count) when pos < 0 or pos >= length(list) do 
        count
    end
    def jump(list, pos, count) do
        jump(
            List.replace_at(list, pos, 1+Enum.at(list, pos)),
            pos+Enum.at(list, pos),
            count+1
        )
    end
   
    def jump_2(list, pos, count) when pos < 0 or pos >= length(list) do 
        count
    end
    def jump_2(list, pos, count) do
        jump_2(
            List.replace_at(list, pos, (new_value (Enum.at list, pos))),
            pos+Enum.at(list, pos),
            count+1
        )
    end
   
    (defp new_value(val) when val >= 3, do: val-1)
    (defp new_value(val), do: val+1)

    def read_input() do 
        File.read!("input") 
        |> String.trim_trailing( "\n" ) 
        |> String.split("\n") 
        |> Enum.map(&String.to_integer/1)
    end

    def solution_part_1(),
        do: (jump read_input(), 0, 0) 
           
    def solution_part_2(),
        do: (jump_2 read_input(), 0, 0) 
           
end
