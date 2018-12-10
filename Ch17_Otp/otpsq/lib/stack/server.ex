defmodule Sequence.Stack.Server do
  use GenServer

  def init(list) do
    {:ok, Enum.reverse(list)}
  end

  def handle_call(:pop, _from, stack) do
    IO.inspect(stack)
    [val | tail] = stack
    {:reply, val, tail}
  end

  def handle_cast({:push, val}, stack) do
    {:noreply, [val | stack]}
  end

  def format_status(_reason, [_pdict, state]) do
    [data: [{'State', "My current state is '#{inspect(state)}' etc."}]]
  end

  def terminate(reason, state) do
    IO.puts("Terminating ...")

    IO.inspect(reason)
    IO.inspect(state)

    IO.puts("Terminated")
  end
end

# {:ok, pid} = GenServer.start_link(Otpsq.Stack, [10, 20, 30])
# GenServer.call(pid, :pop)
# GenServer.cast(pid, { :push, 44 })
# :sys.trace pid, false
