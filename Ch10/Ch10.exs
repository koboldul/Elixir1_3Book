defmodule Ch10 do
  @moduledoc """
    Chapter 10 from Programming Elixir book.
  """

  @defaults [TX: 0.08, NC: 0.075]
  @doc """
    Takes a list: [[id: _, ship_to: _, net_amount: _]] and calculates a total_amount
    based on a tac list.
  """
  def merge(orders) do
    for o <- orders,
    #, Keyword.has_key?(@defaults, o[:ship_to]),
    #into: orders, 
    do: Keyword.put(o, :total_amount, o[:net_amount]*(Keyword.get(@defaults, o[:ship_to], 0)+1)) 
    #do: IO.inspect o
  end
end

