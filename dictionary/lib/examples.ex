defmodule Examples do
  require Logger

  def read_file({:ok, file}) do
    file |> String.split(~r/\n/) |> Enum.random()
  end

  def read_file({:error, reason}) do
    Logger.error("File error: #{reason}")
  end

  def test() do
    "assets/words1.txt"
    |> File.read()
    |> read_file
  end

  def swap({ a, b}) do
    {b, a}
  end

  def same(a, a), do: true
  def same(_a, _b), do: false

  def len([]), do: 0
  def len([_h | t]), do: 1 + len(t)

  def sum([]), do: 0
  def sum([h | t]), do: h + sum(t)

  def double([]), do: []
  def double([h | t]), do: [h*2 | double(t)]

  def square([]), do: []
  def square([h | t]), do: [h*h | square(t)]

  def sum_pairs([]), do: []
  def sum_pairs([h1, h2 | t]), do: [h1+h2 | sum_pairs(t)]

  def even_length([]), do: true
  def even_length([h1, h2 | t]), do: true && even_length(t)
  def even_length([h | t]), do: false

  def countdown(0), do: IO.puts "Liftoff!"
  def countdown(n) do
    IO.puts n
    countdown(n-1)
  end
end
