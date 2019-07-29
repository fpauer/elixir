defmodule GallowsWeb.HangmanView do
  use GallowsWeb, :view

  def displayWordSoFar(tally) do
    tally.letters
    |> Enum.join(" ")
  end

end
