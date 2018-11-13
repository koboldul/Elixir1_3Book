defmodule Chop do
  def guess(n, range) do
    a..b = range
    _guess(n, div(a+b, 2), range)
  end

  defp _guess(n, c, range) when c < n  do
    a..b = range
    nc = div(b+a, 2)
    IO.puts "Guessing #{nc} lower"

    _guess(n, nc, c..b)
  end

  defp _guess(n, c, range) when c > n  do
    a..b = range
    nc = div(b+a, 2)

    IO.puts "Guessing #{nc} higher"
    _guess(n, nc, a..c)
  end

  defp _guess(n, c, _) when c == n  do
     n
  end
end
