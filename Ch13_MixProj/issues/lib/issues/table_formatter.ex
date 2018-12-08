defmodule Issues.TableFormatter do
  import Enum, only: [each: 2, map: 2, map_join: 3, max: 1]

  def print_as_table_with_cols(list, headers) do
    with data_by_cols = split_into_cols(list, headers),
         col_widths = widths_of(data_by_cols),
         format = format_for(col_widths) do
      # IO.inspect(format)
      put_one_line_in_columns(headers, format)
      IO.puts(separator(col_widths))
      puts_in_columns(data_by_cols, format)
    end
  end

  def split_into_cols(rows, headers) do
    Enum.map(headers, &for(r <- rows, do: printable(r[&1])))
  end

  defp printable(str) when is_binary(str), do: str
  defp printable(str), do: to_string(str)

  def widths_of(cols) do
    Enum.map(cols, fn col -> String.length(Enum.max_by(col, &String.length/1)) end)
    # for c <-cols, do: c |> map(&String.length/1) |> max
  end

  def put_one_line_in_columns(fields, format) do
    :io.format(format, fields)
  end

  def puts_in_columns(data_by_cols, format) do
    data_by_cols
    |> Enum.zip()
    |> map(&Tuple.to_list/1)
    |> each(&put_one_line_in_columns(&1, format))
  end

  def separator(column_widths) do
    map_join(column_widths, "-+-", &List.duplicate("-", &1))
  end

  def format_for(col_widths) do
    IO.inspect(Enum.map_join(col_widths, " | ", fn width -> "~-#{width}s" end) <> "~n")
  end
end
