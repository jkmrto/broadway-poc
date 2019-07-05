defmodule BroadwayPoc do
  use Application

  def start(_type, _args) do
    children = [
      {BroadwayPoc.Consumer, 0}
    ]

    opts = [strategy: :one_for_one, name: BroadwayPoc.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
