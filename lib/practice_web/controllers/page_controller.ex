defmodule PracticeWeb.PageController do
  use PracticeWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def double(conn, %{"x" => x}) do
    {x, _} = Integer.parse(x)
    y = Practice.double(x)
    render conn, "double.html", x: x, y: y
  end

  def calc(conn, %{"expr" => expr}) do
    y = Practice.calc(expr)
    render conn, "calc.html", expr: expr, y: y
  end

  def factor(conn, %{"x" => x}) do
    {x, _} = Integer.parse(x)
    y = Practice.factor(x)
        |> Enum.map(&Integer.to_string/1)
        |> Enum.join(", ")

    render conn, "factor.html", x: x, y: y
  end

  def palindrome(conn, %{"x" => x}) do
    ans = Practice.palindrome?(x)
          |> (fn(a) ->
            cond do
              a ->
                "is a palindrome"
              true ->
                "is not a palindrome"
            end
          end).()
    render conn, "palindrome.html", x: x, y: ans
  end

end
