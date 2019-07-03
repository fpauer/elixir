defmodule Fibonacci do

  defdelegate fib(n), to: Fibonacci.Fibonacci

end