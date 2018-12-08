defmodule MyEnum do
  def all?(list, func), do: _all?(list, func, true)

  def each([h|t], func) do
    func.(h)
    each(t, func)
  end

  def each([], _), do: :end

  def flatten([]), do: []

  def flatten([h|t]) when is_list(h) do
    flatten(h)++flatten(t)
  end

  def flatten([h|t]) do
    [h|flatten(t)]
  end


  defp _all?([h|t], func, true), do: _all?(t, func, func.(h))
  defp _all?(_, _, false), do: false
  defp _all?([], _, true), do: true
end
