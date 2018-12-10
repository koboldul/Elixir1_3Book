defmodule Otpsq.Server do
  use GenServer

  def init(initial_number) do
    {:ok, initial_number}
  end

  def handle_call(:next_number, from, current_number) do
    IO.inspect(from)

    {:reply, current_number, current_number + 1}
  end
end
