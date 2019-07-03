defmodule Procs do

  def greeting(count) do
    receive do

    :reset ->
      greeting(0)

    {what_to_say, msg} ->
      IO.puts "#{count}: #{what_to_say} #{msg}"
      greeting(count+2)

    end
  end
end