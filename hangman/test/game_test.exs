defmodule Hangman.GameTest do
  use ExUnit.Case
  doctest Hangman.Game

  alias Hangman.Game

  test "new_game returns structure" do
    game = Game.new_game()
    assert game.turns_left == 7
    assert game.game_state == :initializing
    assert length(game.letters) > 0
  end

  test "new_game returns lowercase letters" do
    game = Game.new_game()
    assert game.letters |> List.to_string =~ ~r(^[a-z]*$)
  end

  test "letter is a not valid guess" do
    game = Game.new_game() |> Game.make_move("$")
    assert game.game_state == :invalid_guess
  end

  test "state isn't changed for :won or :lost game" do
    for state <- [ :won, :lost ] do
      game = Game.new_game() |> Map.put(:game_state, state)
      assert ^game = Game.make_move(game, "x")
    end
  end

  test "first occurrence of letter is not already used" do
    game = Game.new_game() |> Game.make_move("x")
    assert game.game_state != :already_used
  end

  test "first occurrence of letter is already used" do
    game = Game.new_game() |> Game.make_move("x")
    assert game.game_state != :already_used
    game = Game.make_move(game, "x")
    assert game.game_state == :already_used
  end

  test "a good guess is recognized" do
    game = Game.new_game("wibble")
    game = Game.make_move(game, "w")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
  end

  test "a guessed word is a won game" do
    game = Game.new_game("abc")

    moves = [
      {"a", :good_guess},
      {"b", :good_guess},
      {"c", :won}
    ]

    Enum.reduce(moves, game,
      fn ({ guess, state }, new_game) ->
        new_game = Game.make_move(new_game, guess)
        assert new_game.game_state == state
        new_game
      end
    )

    assert game.turns_left == 7
  end

  test "bad guess is recognized" do
    game = Game.new_game("abc")
    |> Game.make_move("x")
    assert game.game_state == :bad_guess
    assert game.turns_left == 6
  end

  test "lost game is recognized" do
    game = Game.new_game("w")

    [
      {"a", :bad_guess},
      {"b", :bad_guess},
      {"c", :bad_guess},
      {"d", :bad_guess},
      {"e", :bad_guess},
      {"f", :bad_guess},
      {"g", :lost}
    ]
    |> Enum.with_index()
    |> Enum.reduce( game, fn ({{ guess, state }, index}, new_game) ->
        new_game = Game.make_move(new_game, guess)
        assert new_game.game_state == state
        assert new_game.turns_left == 6 - index
        new_game
      end)

  end
end