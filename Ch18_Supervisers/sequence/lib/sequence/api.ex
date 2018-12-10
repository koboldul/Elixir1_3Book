defmodule Sequence.Api do
  use GenServer, restart: :transient
  @server Sequence.Server

  def start_link(list \\ []) do
    GenServer.start_link(@server, list, name: @server)
  end

  def pop do
    GenServer.call(@server, :pop)
  end

  def push(val) do
    GenServer.cast(@server, {:push, val})
  end
end
