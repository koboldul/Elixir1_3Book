authors = [
  %{name: "Jose", language: "Elixir", m: %{a: {"C", "A"}, b: "B"}}
]

r_select = fn (:get, collection, next_fn) ->
  for row <-collection do
    if String.contains?(row.language, "r") do
      next_fn.(row)
    end
  end
end

IO.inspect get_in(authors, [r_select, :language])
wtf = %{name: "Jose", language: "Elixir"}
IO.inspect get_in(wtf, [​:name])

