defmodule BroadwayPoc.Producer do
  use GenStage

  @type state :: [pos_integer()]

  def init(_counter) do
    Process.send_after(self(), :produce, 1)
    {:producer, []}
  end

  def handle_demand(demand, [h | rest]) when demand > 0 do
    {:noreply, h, rest}
  end

  def handle_demand(demand, []) when demand > 0 do
    {:noreply, [], []}
  end

  def handle_info(:produce, state ) do
    Process.send_after(self(),  :produce, 1000)
    {:noreply, [1 | state]}
  end
end
