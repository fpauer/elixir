defmodule Cache.Application do

  use Application

  def start(_type, _args) do

    import Supervisor.Spec

    children = [
      worker(Cache.Engine, [])
    ]

    options = [
      name: Dictionary.Supervisor,
      strategy: :one_for_one
    ]

    Supervisor.start_link(children, options)
  end

end
