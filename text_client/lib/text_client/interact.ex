defmodule TextClient.Interact do

  @hangman_server :hangman@MAC1F1G3

  alias TextClient.{Player, State}

  def start() do
    new_game()
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

  defp new_game() do
    Node.connect(@hangman_server)
    :rpc.call(
      @hangman_server,
      Hangman,
      :new_game,
      []
    )
  end

end
