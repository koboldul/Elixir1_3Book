defmodule Fib do
  def of(0), do: 0
  def of(1), do: 1
  def of(n), do: of(n-1) + of (n-2)
  
  def start_fib do
    IO.puts "Start task"
    
    worker = Task.async(fn -> of(20) end)

    IO.puts "DO something else"

    IO.puts ("Wait")

    result = Task.await(worker)

    IO.puts ("Result #{result}")
  end
end


