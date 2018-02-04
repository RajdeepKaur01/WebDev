defmodule Calc do
  @moduledoc """
  Documentation for Calc.
  """

  # repeatedly print a prompt, read one line, eval it, and print the result.
  def main() do
    IO.gets("> ")
    |> eval()
    |> IO.puts
    main()
  end

  # parse and evaulate an arithmetic expression.
  def eval(str) do
    String.split(str,"")
    |> Enum.drop(-1)
    |> eval("",[],[])
  end

  # Helper Functions
  def eval([head|tail],acc,list1,list2) do
    case head do
      n when n in ["0","1","2","3","4","5","6","7","8","9"]
      -> eval(tail,acc<>head,list1,list2)
      " " -> eval(tail,acc,list1,list2)
      "\n" -> eval([],acc,list1,list2)
      _ -> eval1([head|tail],acc,list1,list2)
    end
  end

  def eval([],acc,list1,[head|tail]) do
    if !(acc=="") do
      eval([],"",[String.to_integer(acc)] ++ list1,[head|tail])
    else
      eval([],acc,
      [solve(head,Enum.at(list1,0),Enum.at(list1,1))]++Enum.drop(list1,2),tail)
    end
  end

  def eval([],acc,list1,[]) do
    Enum.at(list1,String.length(acc))
  end

  def eval1(list,acc,list1,list2) do
    if !(acc=="") do
      eval1(list,"",[String.to_integer(acc)] ++ list1,list2)
    else
      case Enum.at(list,0) do
        "(" -> eval(Enum.drop(list,1),"",list1,["("] ++ list2)
        ")" -> eval_close(Enum.drop(list,1),"",list1,list2)
        _ -> eval_exp(list,"",list1,list2)
      end
    end
  end

  def eval_close(list,acc,list1,list2) do
    if !(Enum.at(list2,0)=="(") do
      eval_close(list,acc,
      [solve(Enum.at(list2,0),Enum.at(list1,0),Enum.at(list1,1))]++Enum.drop(list1,2),
      Enum.drop(list2,1))
    else
      eval(list,acc,list1,Enum.drop(list2,1))
    end
  end

  def eval_exp(list,acc,list1,list2) do
    if (!(list2==[]) && hasPrecedence(Enum.at(list,0),Enum.at(list2,0))) do
      eval_exp(list,acc,
      [solve(Enum.at(list2,0),Enum.at(list1,0),Enum.at(list1,1))]++Enum.drop(list1,2),
      Enum.drop(list2,1))
    else
      eval(Enum.drop(list,1),acc,list1,[Enum.at(list,0)]++list2)
    end
  end

  def hasPrecedence(op1,op2) do
    if (op2 == "(" || op2 == ")") do
      false
    else
      if ((op1 == "*" || op1 == "/") && (op2 == "+" || op2 == "-")) do
        false
      else
        true
      end
    end
  end

  def solve(op,j,i) do
    case op do
      "+" -> i+j
      "-" -> i-j
      "*" -> i*j
      "/" -> div(i,j)
    end
  end
end
