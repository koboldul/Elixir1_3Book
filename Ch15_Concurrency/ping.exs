defmodule Ping do
  def betty(token) do
    receive do
      {_, 4} ->
        IO.puts("Stoped")

      {sender, times} ->
        IO.puts("Betty received")
        send(sender, {:ok, token, times + 1, self()})
        betty(token)
    end
  end

  def fred(ct \\ :init) do
    case ct do
      :init ->
        bid = spawn(Ping, :betty, ["xxx"])
        send(bid, {self(), 0})

      _ ->
        nil
    end

    receive do
      {:ok, token, times, pid} ->
        IO.puts("Freddy got token #{token} for #{times}llions time")
        send(pid, {self(), times})
        fred(:notinit)
    after
      500 -> IO.puts("Screw betty")
    end
  end

  def real_b() do
    receive do
      {sender, tk} ->
        send(sender, tk)
        real_b()
    end
  end

  def run() do
    for idx <- 0..3 do
      f1 = spawn(Ping, :real_b, [])
      send f1, {self(), "#{idx} Muhaha"}
      receive do
        tk -> IO.puts(tk)
      after
        500 -> "Stopped"
      end
    end
  end
end
