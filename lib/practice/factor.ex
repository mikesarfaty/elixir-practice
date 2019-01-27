defmodule Practice.Factor do

  def factor(num)  do
    factor(num, 2, [])
    |> Enum.reverse
  end

  def factor(num, sofar, factors) when sofar == num do
    IO.puts "done"
    [num | factors]
  end

  def factor(num, sofar, factors) do
    cond do
      Integer.mod(num, sofar) == 0 ->
        factor(trunc(num / sofar), 2, [trunc(sofar) | factors])
      true ->
        factor(num, sofar + 1, factors)
    end
  end

end
