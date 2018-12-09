defmodule Tick do
  def start do
    pid = spawn(__MODULE__, :tick, [])
    #:global.register_name("wtf", pid)

    send(pid, {:tick, 200})

  end

  def tick do
    receive do
      {:tick, n} ->
        IO.puts n
        tick()
      {:stop} ->
        exit(:stopping)
      after 2000 ->
        IO.puts "Ticking"
        tick()
    end

  end

end
