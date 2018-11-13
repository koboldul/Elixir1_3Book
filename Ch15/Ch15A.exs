defmodule Parallel do
  def pmap(collection, fun) do
    me = self
    collection
    |> Enum.map(fn(e) ->
          spawn_link fn -> (send me, {self, fun.(e)}) end
       end)
    |> Enum.map(fn(pid) ->
        receive do {^pid, r} -> r end      
       end)   
  end
end
