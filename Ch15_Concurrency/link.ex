defmodule Link do
  import :timer, only: [sleep: 1]

  def child() do
    receive do
      {sender, tk} ->
        send(sender, "tkssss #{tk}")
        raise RuntimeError
    end
  end

  def run() do
    Process.flag(:trap_exit, true)
    f1 = spawn_link(__MODULE__, :child, [])
    send(f1, {self(), "mihihi"})

    sleep(500)

    wait_m =
      (fn w ->
         receive do
           tk -> IO.inspect(tk)
           w.(w)
         after
           700 -> "Stopped"
         end
       end)
       wait_m.(wait_m)
  end
end
