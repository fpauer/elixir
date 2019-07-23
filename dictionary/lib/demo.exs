defmodule Demo do

  def reverse do
    receive do
      { sender ,msg } ->
        IO.inspect sender
        result = msg |> String.reverse
        send sender, result
        reverse()
    end
  end
end
