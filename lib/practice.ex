defmodule Practice do
  @moduledoc """
  Practice keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  def double(x) do
    2 * x
  end

  def calc(expr) do
    # This is more complex, delegate to lib/practice/calc.ex
    Practice.Calc.calc(expr)
  end

  def factor(x) do
    Practice.Factor.factor(x)
  end

  def palindrome?(x) do
    reverse_x = x
                |> String.to_charlist()
                |> Enum.reverse
                |> to_string
    reverse_x == x
  end

end
