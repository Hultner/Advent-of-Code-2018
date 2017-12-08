defmodule Day5Test do
  use ExUnit.Case

  test "Day 5: Part 1" do
    assert Day5.jump([0,3,0,1,-3], 0, 0) == 5
  end
  
  test "Day 5: Part 2" do
    assert Day5.jump_2([0,3,0,1,-3], 0, 0) == 10
  end
  
end
