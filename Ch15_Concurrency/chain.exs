defmodule Chain do
  def counter(next_pid) do
    receive do
      n ->
        send(next_pid, n+1)
    end
  end

  def create_process(n) do
    func = fn _, send_to ->
      spawn(Chain, :counter, [send_to])
    end

    last = Enum.reduce(1..n, self(), func)
    send(last, 0)

    receive do
      fa when is_integer(fa) ->
        "Result is #{inspect(fa)}"

    end
  end

  def run(n) do
    :timer.tc(Chain, :create_process, [n]) |> IO.inspect
  end
end
