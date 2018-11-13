zero = fn
  0, 0, _ -> "FizzBuzz"
  0, _, _ -> "Buzz"
  _, 0, _ -> "Fizz"
  _, _, a -> a
end

fizzy = fn n ->
  zero.(rem(n, 3), rem(n, 5), n)
end

IO.puts fizzy.(10)
IO.puts fizzy.(11)
IO.puts fizzy.(12)
IO.puts fizzy.(13)
IO.puts fizzy.(15)
