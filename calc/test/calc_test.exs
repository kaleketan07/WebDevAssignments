defmodule CalcTest do
  use ExUnit.Case
  doctest Calc

  test "greets the world" do
    assert Calc.hello() == :world
  end

  test "Welcome" do
   assert Calc.eval("(1 + 2)") == 3
  end

  test "test1"  do
   assert Calc.eval("(1 * 3 / 2) + (12 + 2)") == 15.5
  end
  
  test "test2"  do
   assert Calc.eval("(5 * 3 + 3) * (12 / 2)") == 108 
  end
 
  test "test3"  do
   assert Calc.eval("(2 * 3 / 2) - (12 + 2)") == -11
  end
 
  test "test 4" do
   assert Stack.push([1],1) == [1,1]
  end 
 
  test "test 5" do
   assert Stack.pop([1,3,5]) == {1,[3,5]}
  end

  test "test 6" do
   assert Stack.stack_size([1,2,3,4,5]) == 5
  end
 
end
