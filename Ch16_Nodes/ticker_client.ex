defmodule TickerClient do
  require Ticker

  def start do
    pid = spawn(__MODULE__, :receiver, [])
    Ticker.register(pid)
  end

  def receiver do
    receive do
      {:tick} -> 
        IO.puts "tok client"
        receiver()
    end
  end
end
