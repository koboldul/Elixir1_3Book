defmodule Ch15 do
  @moduledoc """
    Concurrency
  """
  def greet do
    receive do
      {sender, msg} -> 
        send sender, {:ok, "Hello #{msg}"}
      greet
    end
  end
end

pid = spawn(Ch15, :greet, [])

send pid, {self, "World?"}
receive do
    {:ok, message} -> IO.puts message
end

send pid, {self, "WTF"}
receive do
  {:ok, message} -> IO.puts message
  after 500 -> IO.puts "Away"
end


