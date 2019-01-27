defmodule Practice.Calc do
  def parse_float(text) do
    {num, _} = Float.parse(text)
    num
  end

  def calc(expr) do
    # This should handle +,-,*,/ with order of operations,
    # but doesn't need to handle parens.
    expr
    |> String.split(~r/\s+/)
    |> Enum.map(&tag/1)
    |> postfix([], [])
    #|> Enum.reverse
    |> eval([])
  end


    # Hint:
    # expr
    # |> split
    # |> tag_tokens  (e.g. [+, 1] => [{:op, "+"}, {:num, 1.0}]
    # |> convert to postfix
    # |> reverse to prefix
    # |> evaluate as a stack calculator using pattern matching

  def eval([], stack) do
    hd(stack)
  end

  def eval(pfix, stack) do
    next = hd(pfix)
    cond do
      next == "*" ->
        operand1 = hd(stack)
        operand2 = hd(tl(stack))
        eval(tl(pfix), [operand1 * operand2 | tl(tl(stack))])
      next == "/" ->
        operand1 = hd(stack)
        operand2 = hd(tl(stack))
        eval(tl(pfix), [operand2 / operand1 | tl(tl(stack))])
      next == "+" ->
        operand1 = hd(stack)
        operand2 = hd(tl(stack))
        eval(tl(pfix), [operand1 + operand2 | tl(tl(stack))])
      next == "-" ->
        operand1 = hd(stack)
        operand2 = hd(tl(stack))
        eval(tl(pfix), [operand2 - operand1 | tl(tl(stack))])
      true ->
        eval(tl(pfix), [next] ++ stack)
    end
  end




  def equal_precendece(op1, op2) do
    cond do
      op1 in ["*", "/"] ->
        op2 in ["/", "*"]
      true ->
        op2 in ["+", "-"]
    end
  end

  def precedence_over(op1, _op2) when op1 in ["*", "/"] do
    true
  end

  def precedence_over(_op1, _op2) do
    false
  end

  def postfix([], [], pfix) do
    pfix
  end

  def postfix([], opstack, pfix) do
    postfix([], tl(opstack), pfix ++ [hd(opstack)])
  end

  def postfix(expr, opstack, pfix) do
    eng_expr = expr
               |> Enum.map(fn(a) -> elem(a, 1) end)
    cond do
      elem(hd(expr), 0) == :op ->
        postfix_op(expr, opstack, pfix)
      true ->
        postfix_n(expr, opstack, pfix)
    end
  end
      
  def postfix_op(expr, [], pfix) do
    postfix(tl(expr), [elem(hd(expr), 1)], pfix)
  end

  def postfix_op(expr, opstack, pfix) do
    next_op = elem(hd(expr), 1)
    cond do
      equal_precendece(next_op, hd(opstack)) ->
        postfix(tl(expr), [next_op | tl(opstack)], pfix ++ [hd(opstack)])
      precedence_over(next_op, hd(opstack)) ->
        postfix(tl(expr), [next_op | opstack], pfix)
      true ->
        postfix(expr, tl(opstack), pfix ++ [hd(opstack)])
    end
  end

  def postfix_n(expr, opstack, pfix) do
    next_num = elem(hd(expr), 1)
    postfix(tl(expr), opstack, pfix ++ [next_num])
  end

  def tag("+") do
    {:op, "+"}
  end

  def tag("-") do
    {:op, "-"}
  end

  def tag("/") do
    {:op, "/"}
  end

  def tag("*") do
    {:op, "*"}
  end

  def tag(other) do
    {:num, String.to_integer(other)}
  end


end
