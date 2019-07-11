defmodule Cache do
  @moduledoc """
  We implement a simple key/value cache. State is stored in an Agent, in
  the form of a map.
  The function `lookup` tries to look the value up in the cache, and then
  calls `complete_if_not_found`. This takes two forms. If there was
  no value in the cache, it calls the function passed in by the client
  to supply it, updating the cache at the same time.
  Otherwise, it simply returns the cached value.
  """

  @doc """
  Start the cache, run the supplied function, then stop the cache.

  Eventually we'll be able to do better than this.
  """

  alias Cache.Engine

  defdelegate run(body), to: Engine
  defdelegate reset(initial), to: Engine
  defdelegate lookup(cache, n, if_not_found), to: Engine

end
