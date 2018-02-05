defmodule Calc do
  @moduledoc """
  Documentation for Calc.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Calc.hello
      :world

  """
  def hello do
    :world
  end

  def main do
    x = IO.gets ">"
    res = eval(x)
    IO.puts res
    main() 
  end 
  
  def eval(x) do 
    a = String.replace(x, "(", "( ")
    b = String.trim(String.replace(a, ")", " )"))
    c = String.split(b, " ")
    res = valueof(c) 
  end
     
  defp valueof(exp) do
    values = []
    ops = [] 
   
     
   # for token <- exp do
   #      {values, ops} = comparetoken(token, values, ops)
   # end
    tup =  List.foldl(exp, {values, ops}, fn(x, acc) -> comparetoken(x, elem(acc, 0), elem(acc, 1)) end ) 
    tup2 = pushremaining(elem(tup,0), elem(tup,1)) 
    {res, values} = Stack.pop(elem(tup2, 0))
    res	       
  end
  
  defp comparetoken(token, values, ops) do
      case token do
         "(" ->       
                       ops = Stack.push(ops, token)
                       {values, ops}
         ")" ->
                       {values, ops} = evalparenthesis(values, ops)
                       {top, ops} = Stack.pop(ops)
                       {values, ops}
         "+" ->
                       {values, ops} = evaloperations(token, values, ops)
                       ops = Stack.push(ops, token)
                       {values, ops}
         "-" ->
                       {values, ops} = evaloperations(token, values, ops)
                       ops = Stack.push(ops, token)
                       {values, ops}
         "*" ->
                       {values, ops} = evaloperations(token, values, ops)
                       ops = Stack.push(ops, token)
                       {values, ops}
         "/" ->
                       {values, ops} = evaloperations(token, values, ops)
                       ops = Stack.push(ops, token)
                       {values, ops}
         _ ->         
                       values = Stack.push(values, String.to_integer(token))
                       {values, ops}
       end

  end

 

  defp pushremaining(values, ops) do
    if Enum.count(ops) != 0 do
       {val1 , values}= Stack.pop(values)
       {val2 , values}= Stack.pop(values)
       {op , ops}= Stack.pop(ops)
       values = Stack.push(values,operate(op, val2, val1))
       {values, ops} = pushremaining(values, ops)
    else 
      {values, ops}
    end
  end

  defp evaloperations(token, values, ops) do
    if Stack.stack_size(ops) != 0 and hasPrecedence(token, hd(ops)) do
       {val1 , values}= Stack.pop(values)
       {val2 , values}= Stack.pop(values)
       {op , ops}= Stack.pop(ops)
       values = Stack.push(values,operate(op, val2, val1))
       {values, ops} = evaloperations(token, values, ops)
    else
       {values, ops}
    end
  end

  defp evalparenthesis(values, ops) do
    if (hd(ops) != "(") do
	{val1 , values }= Stack.pop(values)
        {val2 , values }= Stack.pop(values)
        {op , ops}= Stack.pop(ops)
        values = Stack.push(values,operate(op, val2, val1))
        {values, ops}= evalparenthesis(values, ops)	
    else
       {values, ops}
    end
  end
   
  defp hasPrecedence(op1, op2) do
    cond do
      op2 === "(" || op2 === ")" -> false
      (op1 === "*" || op1 === "/") and (op2 === "+" || op2 === "-") -> false
      true -> true
    end
  end 
  
  defp operate(op, val1, val2) do
    cond do
      op === "+" -> add(val1, val2)
      op === "-" -> sub(val1, val2)
      op === "*" -> mul(val1, val2)
      op === "/" -> divide(val1, val2)
      true -> IO.puts "Invalid Operator supplied"
    end
  end

  defp add(x, y) do
    x + y
  end
  
  defp sub(x, y) do
    x - y
  end
 
  defp mul(x, y) do
    x * y
  end

  defp divide(x, y) do
    if y == 0 do
      IO.puts "Division by Zero error!"
    else
      x / y
    end
  end 
end



defmodule Stack do

  def push(stack, element) do 
   stack = [element | stack] 
   stack
  end
 
  def pop(stackname) do 
    [stack_top | rest] = stackname
    {stack_top, rest }
  end

  def stack_size(stackname) do
    Enum.count(stackname) 
  end

end
