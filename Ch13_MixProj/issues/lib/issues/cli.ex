defmodule Issues.CLI do
  @default_count 4

  def main(argv) do
    argv
    |> parse_args
    |> process
  end

  def parse_args(argv) do
    OptionParser.parse(argv, switches: [help: :boolean, aliases: [h: :help]])
    |> elem(1)
    |> args_repr()
  end

  defp args_repr([user, project, count]) do
    {user, project, String.to_integer(count)}
  end

  defp args_repr([user, project]) do
    {user, project, @default_count}
  end

  defp args_repr(_) do
    :help
  end

  defp process(:help) do
    IO.puts("""
      usage: TODO
    """)

    System.halt(0)
  end

  defp process({user, project, count}) do
    Issues.GithubIssues.fetch(user, project)
    |> decode_response()
    |> sort_into_desc_order()
    |> get_last(count)
    |> Issues.TableFormatter.print_as_table_with_cols(["number", "created_at", "title"])
  end

  def decode_response({:ok, body}), do: body

  def decode_response({:error, error}) do
    IO.puts("Error fetching from github #{error["message"]}")
    System.halt(2)
  end

  def get_last(list, count) do
    list
    |> Enum.take(count)
    |> Enum.reverse()
  end

  def sort_into_desc_order(list_of_issues) do
    list_of_issues
    |> Enum.sort(fn i1, i2 ->
      i1["created_at"] >= i2["created_at"]
    end)
  end
end
