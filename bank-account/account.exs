defmodule BankAccount do
  use GenServer

  def open_bank() do
    {:ok, pid} = GenServer.start_link(__MODULE__, [])
    pid
  end

  def close_bank(pid) do
    GenServer.call(pid, :close)
  end

  def balance(pid) do
    GenServer.call(pid, :balance)
  end

  def update(pid, amount) do
    GenServer.call(pid, {:update, amount})
  end

  def init(_) do
    {:ok, %{balance: 0, closed: false}}
  end

  def handle_call(:balance, _from, account) do
    {:reply, account.balance, account}
  end

  def handle_call(:close, _from, account) do
    {:reply, :ok, %{account | closed: true }}
  end

  def handle_call({:update, amount}, _from, account) do
    if account.closed do
      {:stop, "cannot operate on closed account", account}
    else
      new_account = Map.update!(account, :balance, &(&1 + amount))
      {:reply, new_account.balance, new_account}
    end
  end
end
