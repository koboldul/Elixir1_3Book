defmodule Ch9 do
  def span(from, to) when from < to do
    [from | span(from+1, to)]
  end
  def span(from, to) when from == to do
    [to] 
  end

  def generate_primes(n) do
    upTo(span(2,n))    
  end

  defp upTo([x | primes]) do
    [x | upTo(for p <- primes, rem(p,x) != 0, do: p)]
  end

  defp upTo([]), do: []

end

