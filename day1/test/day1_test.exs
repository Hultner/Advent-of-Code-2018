defmodule Day1Test do
  use ExUnit.Case

  test "day 1: Inverse Capcha sum part 1" do
    assert Day1.puzzle_sum([1,1,2,2]) == 3
    assert Day1.puzzle_sum([1,1,1,1]) == 4
    assert Day1.puzzle_sum([1,2,3,4]) == 0
    assert Day1.puzzle_sum([9,1,2,1,2,1,2,9]) == 9
  end
  
  test "day 1: Inverse Capcha sum part 2" do
    assert Day1.solution_part_2(1212) == 6
    assert Day1.solution_part_2(1221) == 0
    assert Day1.solution_part_2(123425) == 4
    assert Day1.solution_part_2(123123) == 12
    assert Day1.solution_part_2(12131415) == 4
  end
  
end
