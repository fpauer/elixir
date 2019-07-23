defmodule TextClient.Interact do

  alias TextClient.{Player, State}

  def start() do
    Hangman.new_game()
    |> setup_state()
    |> Player.play()
  end

  defp setup_state(pid) do
    %State{
      pid: pid,
      game_service: Hangman.get_game(pid),
      tally: Hangman.tally(pid)
    }
  end

end
