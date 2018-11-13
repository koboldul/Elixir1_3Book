 defmodule Sequence.Server do
    use GenServer

    @vns "1"

    defmodule State do
        defstruct current_number: 0, stash_pid: nil, delta: 1
    end

    def start_link(stash_pid) do
        {:ok, _pid} = GenServer.start_link(__MODULE__, stash_pid, name: __MODULE__)
    end

    def next_number do
        with number = GenServer.call(__MODULE__, :next_number), 
        do: "The next number is #{number}"
    end

    def increment_number(delta) do
        GenServer.cast __MODULE__, {:increment_number, delta}
    end

    #GenServer implementation
    def init(stash_pid) do
        current_number = Sequence.Stash.get_value(stash_pid)
        {:ok, %State{current_number: current_number, stash_pid: stash_pid}}
    end

    def handle_call(:next_number, _from, state) do
        {:reply, state.current_number, %{state | current_number: state.current_number+state.delta }}
    end

    def handle_cast({:increment_number, delta}, state) do
        {:noreply, %{state | current_number: state.current_number+delta, delta: delta  }}
    end

    def format_status(_reason, [_pdict, state]) do
        [data: [{'State', "My current state is #{inspect state}."}]]
    end

    def terminate(_reason, state) do
        IO.puts inspect state
        Sequence.Stash.save_value(state.stash_pid, state.current_number)
    end

    @spec wtf(integer) :: integer
    def wtf(integer) do
        IO.puts ("WTF: #{integer}")
        123
    end

    require Logger
    def code_change("0", old_state, _extra) do
       #new_state = %State{ current_number: current_number, stash_pid: stash_pid, delta: 1 }
        Logger.info "Changing code from 0 to 1"
        Logger.info inspect(old_state)
        #Logger.info inspect(new_state)

        {:ok, old_state}
    end
end