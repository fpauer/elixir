defmodule TextClient.State do

  defstruct(
    pid: nil,
    game_service: nil,
    tally: nil,
    guess: ""
  )

end
