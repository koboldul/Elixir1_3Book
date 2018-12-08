defmodule TableFormatterTest  do
  use ExUnit.Case
  import ExUnit.CaptureIO

  alias Issues.TableFormatter, as: TF

  @sample_data [
    [c1: "r1 c1", c2: "r1 c2", c3: "r1 c3", c4: "r1++++c4"],
    [c1: "r2 c1", c2: "r2 + +  c2", c3: "r2 c3", c4: "r2 c4"],
    [c1: "r3 c1", c2: "r3 c2", c3: "r3 c3", c4: "r3 c4"],
    [c1: "r4 c1", c2: "r4 c2", c3: "r4 c3", c4: "r4 c4"]
  ]

  @headers [:c1, :c2, :c4]

  test "width get" do
    TF.split_into_cols(@sample_data, @headers)
    |> TF.widths_of()
    |> Enum.each(&(IO.puts &1))
  end

  test "all shabable" do
    result = capture_io (fn -> TF.print_as_table_with_cols(@sample_data, @headers) end)

    # assert result == """
    # c1    | c2     | c4​​ 
    # ------+--------+--------​​
    # r1 c1 | r1 c2  | r1+++c4​
    # r2 c1 | r2 c2  | r2 c4​​ ​
    # r3 c1 | r3 c2  | r3 c4​​ ​
    # r4 c1 | r4++c2 | r4 c4​​ ​
    # """
  end
end
