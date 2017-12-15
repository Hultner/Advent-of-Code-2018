defmodule Day2 do

    # Part 1
    def check_sum(mat) do
      Stream.map(mat, &min_max_diff/1)
      |> Enum.sum
    end

    defp min_max_diff(list) do
      Enum.min_max(list)
      |> (fn {min, max} -> max-min end).()
    end

    # Part 2
    def div_sum(mat) do
      # Find combinations of 2 which is evenly divisable then divide and sum
      Stream.map(mat, &Combination.combine(&1, 2))
      |> Stream.map(fn pair ->
        Enum.find( pair, &even_divisable/1) end)
      # We need to know which is the largest divisor
      |> Stream.map(&Enum.sort/1)
      |> Stream.map(fn [a,b] -> div(b,a) end)
      |> Enum.sum
    end

    defp even_divisable([a,b]) do
      rem(a,b) === 0 or rem(b,a) === 0
    end

    # Input handling, naïve tsv parsing.
    def read_input(file) do
      File.stream!(file)
      |> Stream.map(&line_to_values/1)
    end

    defp line_to_values(line) do
      # Surrounding white space would make to_integer to fail on ""
      String.trim(line)
      # There's a whitespace \s between each number
      |> String.split(~r{\s})
      |> Enum.map(&String.to_integer/1)
    end

    def solve1(input) do 
      read_input(input)
      |> check_sum
    end
           
    def solve2(input) do
      read_input(input)
      |> div_sum
    end
           
end
