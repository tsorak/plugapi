defmodule KV.Registry do
  use GenServer

  def start_link(_arg) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def create(todo) do
    GenServer.cast(__MODULE__, {:create, todo})
  end

  def get_all do
    GenServer.call(__MODULE__, :get_all)
  end

  ###

  def init(initial_state) do
    {:ok, initial_state}
  end

  def handle_call({:lookup, todo_id}, _from, todos) do
    {:reply, Map.fetch(todos, todo_id), todos}
  end

  def handle_call(:get_all, _from, todos) do
    {:reply, Map.values(todos), todos}
  end

  def handle_cast({:create, todo}, todos) do
    todo_id = Ecto.UUID.generate()
    {:noreply, Map.put(todos, todo_id, todo)}
  end
end
