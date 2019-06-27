defmodule TextClient.Summary do

  def display(game = %{ game_service: game_service, tally: tally }) do
    IO.puts [
      "\n",
      "Word so far: #{Enum.join(tally.letters, " ")} ",
      "\nguess left: #{tally.turns_left}",
      "\nused: #{Enum.join(game_service.used, " ")}\n"
    ]
    game
  end

end