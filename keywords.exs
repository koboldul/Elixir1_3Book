defmodule Canvas do
  @defaults [fg: "black", bg: "white", font: "xxx"]

  def draw_text(text, options \\[]) do
    options = Keyword.merge(@defaults, options)
    IO.puts "Drawing text #{inspect(text)}"
    IO.puts "Fwground: #{inspect Keyword.get_values(options, :fg)}"
    IO.puts "Bckground: #{Keyword.get(options, :bg)}"
    IO.puts "PAttern: #{Keyword.get(options, :pattern, "solid")}"
    IO.puts "Style: #{inspect Keyword.get_values(options, :style)}"
  end
end
