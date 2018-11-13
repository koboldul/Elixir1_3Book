defmodule EvaluatorTest do
  use ExUnit.Case
  doctest Evaluator

  import LineSigil

  test "greets the world" do
    assert Evaluator.hello() == :world
  end
end
