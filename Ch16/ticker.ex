defmodule Ticker do
  @interval 2000 # 2 sec
  @name :ticker

  def start do
    IO.puts @name
    pid = spawn(__MODULE__, :generator, [[]])
    :global.register_name(@name, pid)
  end

  def register(client_pid) do
    IO.puts @name
    send :global.whereis_name(@name), {:register, client_pid } 
  end

  def generator(clients) do
    receive do
      {:register, pid} ->
        IO.puts "registering #{inspect pid}"
        generator([pid|clients])
    after
      @interval ->
        IO.puts "tick"
        Enum.each clients, &(send &1, {:tick})
        generator clients
    end
  end
end
