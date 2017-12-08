defmodule Day2 do

    # Part 1
    def check_sum(mat) do
      mat
      |> Enum.map( &(Enum.max(&1)-Enum.min(&1)))
      |> Enum.sum
    end

    # Part 2
    def div_sum(mat) do
      mat
      |> Enum.map(&Combination.combine(&1, 2))
      |> Enum.map(
        &Enum.find( &1, fn [a,b] -> rem(a,b) === 0 or rem(b,a) === 0 end))
      |> Enum.map(&Enum.sort/1)
      |> Enum.map(fn [a,b] -> div(b,a) end)
      |> Enum.sum
    end

    # Input handling, naïve tsv parsing.
    def read_input(file) do 
      file
      |> File.read!
      |> String.split("\n")    
      |> Enum.map(
        fn r ->
          String.split(r, ~r{\s}) 
          |> Enum.map(&String.to_integer/1) 
        end
      )
    end
    
    def solve1(input) do 
      input
      |> read_input 
      |> check_sum
    end
           
    def solve2(input) do
      input
      |> read_input 
      |> div_sum
    end
           
end
