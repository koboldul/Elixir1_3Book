defmodule SpawnBasic do
  def greet do
    receive do
      {sender, "xxx"} ->
        IO.puts("xxx")
      {sender, msg} ->
        IO.inspect(self())
        send sender, {:ok, "Hello #{msg}"}
        greet()

    end
  end
end


pid = spawn(SpawnBasic, :greet, [])

send pid,{self(), "hello1"}
send pid,{self(), "xxx"}

for _ <- 0..1 do
  receive do
    {:ok, message} ->
      IO.puts message
  after 500 ->
    IO.puts("Timeout")
  end
end
