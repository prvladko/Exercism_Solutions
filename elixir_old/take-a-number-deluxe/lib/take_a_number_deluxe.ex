defmodule TakeANumberDeluxe do
  use GenServer

  # Client API
  @spec start_link(keyword()) :: {:ok, pid()} | {:error, atom()}
  def start_link(init_arg) do
    GenServer.start_link(__MODULE__, init_arg)
  end

  @spec report_state(pid()) :: TakeANumberDeluxe.State.t()
  def report_state(machine), do: GenServer.call(machine, :report_state)

  @spec queue_new_number(pid()) :: {:ok, integer()} | {:error, atom()}
  def queue_new_number(machine), do: GenServer.call(machine, :queue_new)

  @spec serve_next_queued_number(pid(), integer() | nil) :: {:ok, integer()} | {:error, atom()}
  def serve_next_queued_number(machine, priority_number \\ nil),
    do: GenServer.call(machine, {:serve, priority_number})

  @spec reset_state(pid()) :: :ok
  def reset_state(machine) do
    GenServer.cast(machine, :reset)
    :ok
  end

  # Server callbacks
  @impl GenServer
  def init(init_arg) do
    min = Keyword.get(init_arg, :min_number)
    max = Keyword.get(init_arg, :max_number)
    auto = Keyword.get(init_arg, :auto_shutdown_timeout, :infinity)
    {ok, state} = TakeANumberDeluxe.State.new(min, max, auto)
    case ok do
      :ok -> {ok, state, auto}
      _ -> {:stop, state}
    end
  end

  @impl GenServer
  def handle_call(:report_state, _from, state),
    do: {:reply, state, state, state.auto_shutdown_timeout}

  @impl GenServer
  def handle_call(:queue_new, _from, state) do
    response = TakeANumberDeluxe.State.queue_new_number(state)
    case response do
      {:ok, new_number, new_state} ->
        {:reply, {:ok, new_number}, new_state, state.auto_shutdown_timeout}
      {:error, error} ->
        {:reply, {:error, error}, state, state.auto_shutdown_timeout}
    end
  end

  def handle_call({:serve, priority}, _from, state) do
    response = TakeANumberDeluxe.State.serve_next_queued_number(state, priority)
    case response do
      {:ok, next_number, new_state} ->
        {:reply, {:ok, next_number}, new_state, state.auto_shutdown_timeout}
      {:error, error} ->
        {:reply, {:error, error}, state, state.auto_shutdown_timeout}
    end
  end

  @impl GenServer
  def handle_cast(:reset, state) do
    {_, new_state} =
      TakeANumberDeluxe.State.new(state.min_number, state.max_number, state.auto_shutdown_timeout)
    {:noreply, new_state, state.auto_shutdown_timeout}
  end

  @impl GenServer
  def handle_info(:timeout, state), do: {:stop, :normal, state}

  @impl GenServer
  def handle_info(_, state),
    do: {:noreply, state, state.auto_shutdown_timeout}
end
