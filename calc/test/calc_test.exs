defmodule CalcTest do
  use ExUnit.Case
  doctest Calc

  test "Main Eval function" do
    assert Calc.eval("3+5") == 8
    assert Calc.eval("3-5") == -2
    assert Calc.eval("3-5+ (4*2)") == 6
    assert Calc.eval("3-5 + (5/3)") == -1
    assert Calc.eval("3-5 + ((5/3)+ 34)") == 33
    assert Calc.eval("3 + 6   -1  *9") == 0
  end

  test "Eval with different arguments" do
    assert Calc.eval(["3","+"," ","6"],"",[],[]) == 9
    assert Calc.eval([],"",[43,5],["+"]) == 48
    assert Calc.eval([],"",[43],[]) == 43
  end

  test "hasPrecedence Function" do
    assert Calc.hasPrecedence("+","(") == false
    assert Calc.hasPrecedence("+",")") == false
    assert Calc.hasPrecedence("+","*") == true
    assert Calc.hasPrecedence("/","-") == false
  end

  test "Solve Function" do
    assert Calc.solve("+",5,10) == 15
    assert Calc.solve("-",5,10) == 5
    assert Calc.solve("*",5,10) == 50
    assert Calc.solve("/",5,10) == 2
  end

end
