defmodule Fibonacci do

  def fib(n) do
    Cache.reset(%{ 0 => 0, 1 => 1 })
    Cache.run(fn cache ->
      cached_fib(n, cache)
    end)
  end

  defp cached_fib(n, cache) do
    Cache.lookup(cache, n, fn ->
      cached_fib(n-2, cache) + cached_fib(n-1, cache)
    end)
  end

end
