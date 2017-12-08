defmodule Day2Test do
  use ExUnit.Case

  test "Day 2: Part 1" do
    assert Day2.solve1("test_input") == 18
    assert Day2.solve1("input") == 34581 
  end
  
  test "Day 2: Part 2" do
    assert Day2.solve2("test_2_input") == 9 
  end
  
end
