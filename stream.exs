defmodule ST do
  def x( h \\[]) do
    Stream.map(h, &(&1+1))
  end

  def rep(f), do: Stream.repeatedly(f)|> Enum.take(2)
end
