defmodule Day5Test do
  use ExUnit.Case

  @day5_test_map %{0 => 0, 1 => 3, 2 => 0, 3 => 1, 4 => -3}

  test "Day 5: Part 1" do
    assert Day5.jump(@day5_test_map, 0, 0, &Day5.new_value_1/1) == 5
  end

  test "Day5: Part 1 Solution" do
    assert Day5.solution_part_1() == 373160
  end

  test "Day 5: Part 2" do
    assert Day5.jump(@day5_test_map, 0, 0,  &Day5.new_value_2/1) == 10
  end

  test "Day5: Part 2 Solution" do
    assert Day5.solution_part_2() == 26395586
  end
  
end
