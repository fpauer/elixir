defmodule Cache.Engine do

  @me __MODULE__

  def start_link do
    Agent.start_link(fn -> %{} end, name: @me)
  end

  def reset(initial = %{}) do
    Agent.update(@me, fn state -> initial end)
  end

  def run(body) do
    result = body.(@me)
    Agent.stop(@me)
    result
  end

  def lookup(cache, n, if_not_found) do
    Agent.get(cache, fn map -> map[n] end)
    |> complete_if_not_found(cache, n, if_not_found)
  end

  defp complete_if_not_found(nil, cache, n, if_not_found) do
    if_not_found.()
    |> set(cache, n)
  end

  defp complete_if_not_found(value, _cache, _n, _if_not_found) do
    value
  end

  defp set(val, cache, n) do
    Agent.get_and_update(cache, fn map ->
      { val, Map.put(map, n, val)}
    end)
  end

end
