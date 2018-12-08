defmodule Math do
  def compute_gdc(x, 0), do: x
  def compute_gdc(x, y) when y > x, do: compute_gdc(y, x)
  def compute_gdc(x, y), do: compute_gdc(y, rem(x, y))
end

