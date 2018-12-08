defmodule Ch11 do
  #1
  def is_ascii(str) when is_list(str), do: Enum.all?(str, &(&1 < 127 && &1 >=0))
  def is_ascii(_), do: false

  #2
  def is_anagram(x, y) do
    prod = fn(m, acc) -> m*acc end
    Enum.reduce(x, prod) == Enum.reduce(y, prod)  
  end

  #3 Print a list of string "" on each line and center them against the longest
  @defaults ["cat", "zebra", "elephant", "mouse", "boar"]
  def center(c_list\\@defaults) do
    max_l = Enum.max_by(c_list, &String.length/1) |> String.length

    IO.puts 'max length is : #{max_l}'

    (for m <- c_list, 
        do:  String.pad_leading(m, String.length(m) + round((max_l-String.length(m))/2), " "))
    |> Enum.each (&IO.puts/1) 
  end

  #4
  def capitalize_sentences(sentences) do
    (String.split(sentences, ". ") |>
     Enum.filter(&(&1 != "")) |> 
     Enum.map (&_capitalize_sentence/1)) |>
    Enum.join(". ")
  end

  defp _capitalize_sentence(""), do: ""
  defp _capitalize_sentence(sentence) do
    String.split(sentence) |> _capitalize_word() |> Enum.join (" ")
  end

  def _capitalize_word([w|tail]) do
    [String.capitalize(w)|_capitalize_word(tail, 1)]
  end
  defp _capitalize_word([], 1), do: []
  defp _capitalize_word([w|tail], 1), do: [String.downcase(w)|_capitalize_word(tail, 1)]

  #5
  @doc"""
  Read a file that has the structure of book shipments like chapter 10.
  After parsing sends the details to the calculate tax function.
  """
  def read_shipment_file(file_name\\'shipments.txt') do
    import FileR
    import Ch10

    st = FileR.read(file_name)
    header = Enum.at(st, 0)
             |> String.split(",") 
             |> Enum.map(&(String.to_atom(String.trim(&1, "\n"))))

    Stream.drop(st, 1) 
      |> Enum.map(&(read_line(&1, header))) 
      |> Ch10.merge
  end

  defp read_line(line, header) do
    Enum.zip(header,
             String.split(line, ",") 
             |> Enum.map(&(String.trim(&1, "\n"))) 
             |> parse_line)  
  end
  
  defp parse_line([h|tail]) do
    cond do
      length(tail) == 2 -> [String.to_integer(h)|parse_line(tail)]
      length(tail) == 1 -> [String.to_atom(String.trim(h, ":"))|parse_line(tail)]
      length(tail) == 0 -> [String.to_float(h)|tail]
    end
  end
  defp parse_line([]), do: []
end
