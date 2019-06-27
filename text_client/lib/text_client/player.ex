defmodule TextClient.Player do

  alias TextClient.{Prompter, Summary, State}

  # won, lost, good guess, bad guess, already used, initial
  def play(%State{ tally: %{ game_state: :won }, game_service: %{ letters: letters }}) do
    msg = [
      "YOU WON :D\n",
      "word :",
      Enum.join(letters, ""),
      "\n"
    ]
    exit_with_message(msg)
  end

  def play(%State{ tally: %{ game_state: :lost }, game_service: %{ letters: letters }}) do
    msg = [
      "Sorry, you lost :(\n",
      "\ncorrect word was:",
      Enum.join(letters, ""),
      "\n"
    ]
    exit_with_message(Enum.join(msg, " "))
  end

  def play(game = %State{ tally: %{ game_state: :good_guess }}) do
    continue_with_message(game, "Good guess, :)")
  end

  def play(game = %State{ tally: %{ game_state: :bad_guess }}) do
    continue_with_message(game, "Bad guess, :/")
  end

  def play(game = %State{ tally: %{ game_state: :already_used }}) do
    continue_with_message(game, "You've already used that letter")
  end

  def play(game) do
    continue(game)
  end

  def continue_with_message(game, msg) do
    IO.puts msg
    continue(game)
  end

  def continue(game) do
    game
    |> Summary.display()
    |> Prompter.input()
    |> make_move()
    |> play()
  end

  def make_move(state) do
    { game_service, tally } = Hangman.make_move(state.game_service, state.guess)
    %State{ state | game_service: game_service, tally: tally }
  end

  defp exit_with_message(msg) do
    IO.puts msg
    exit(:normal)
  end
end