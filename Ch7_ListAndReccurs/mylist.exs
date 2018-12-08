defmodule MyList do
  def len([]), do: 0
  def len([_head|tail]), do: 1+len(tail)

  def square([]), do: []
  def square([head|tail]), do: [head*head | square(tail)]

  def map([], _func), do: []
  def map([h|t], func) do
    [func.(h)|map(t,func)]
  end

  def reduce([],value, _), do: value
  def reduce([h|t], value, func) do
      reduce(t,func.(h,value),func)
  end

  def map_reduce([], val, _, _), do: val
  def map_reduce([h|t], val, m_func, r_func) do
    map_reduce(t, r_func.(m_func.(h), val), m_func, r_func)
  end

  def mapsum([h|t], func), do: mapsum([h|t], func, 0)

  defp mapsum([h|t], func, val) do
    mapsum(t, func, func.(h) + val)
  end
  defp mapsum([],_, val), do: val

  def max([h|t]), do: lmax([h|t], nil)

  defp lmax([h|t], nil), do: lmax(t, h)
  defp lmax([h|t], v) when h > v, do: lmax(t, h)
  defp lmax([h|t], v) when h <= v, do: lmax(t, v)
  defp lmax([], v), do: v

  def cul(x, from, to) when from < x and x < to, do: x
  def cul(x, from, to) when from >=x or x >= to, do: []

  def span([head|tail], from, to) do
    List.flatten(map([head|tail], fn(n)->cul(n,from,to)end))
    IO.puts('Geheheh')
  end
end
