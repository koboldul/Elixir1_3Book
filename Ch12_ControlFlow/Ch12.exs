defmodule Ch12 do
  def fizzbuzz(n) do
    1..n |>
    Enum.map(
    fn x -> 
      case {rem(x,3), rem(x,5)} do
        {0, 0} -> "fizz_buzz" 
        {_, 0} -> "fizz"
        {0, _} -> "buzz"
        _ -> x 
      end
    end)
  end

  def ok!(x) do
    case x do
      {:ok, data} -> data
      _ -> raise "No dice!"  
    end
  end
end
