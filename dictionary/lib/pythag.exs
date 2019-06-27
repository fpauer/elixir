:timer.tc(fn ->
  for a <- 1..100, b <- 1..100, c <- 1..100, a*a + b*b == c*c, do: [a, b, c]
end) |> IO.inspect

:timer.tc(fn ->
  for a <- 1..100,
      b <- (a+1)..100,
      c <- (b+1)..100,
      a*a + b*b == c*c,
      a + b > c,
      do: [a, b, c]
end) |> IO.inspect

# Naive executions: 970299
naive_count = for a <- 1..99,
                  b <- 1..99,
                  c <- 1..99
                do
                  {a, b, c}
                end
              |> length
IO.puts("Naive executions: #{naive_count}")

# Optimized executions: 77418
optimized_count = for a <- 1..97,
                      b <- (a + 1)..98,
                      c <- (b + 1)..min(a + b - 1, 99)
                    do
                      {a, b, c}
                    end
                  |> length
IO.puts("Optimized executions: #{optimized_count}")

naive_triples = for a <- 1..99,
                    b <- 1..99,
                    c <- 1..99,
                    a < b, a*a + b*b == c*c,
                    into: MapSet.new()
                do
                  {a, b, c}
                end

optimized_triples = for a <- 1..98,
                        b <- (a + 1)..98,
                        c <- (b + 1)..min(a + b - 1, 99),
                        a < b,
                        a*a + b*b == c*c,
                        into: MapSet.new()
                    do
                      {a, b, c}
                    end

IO.puts("Optimized is correct? #{MapSet.equal?(naive_triples, optimized_triples)}")
optimized_triples |> Enum.sort() |> Enum.each(&IO.inspect(&1))