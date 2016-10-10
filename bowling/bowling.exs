defmodule Bowling do
  use GenServer

  def start do
    {:ok, pid} = GenServer.start_link(__MODULE__, [], name: :game_server)
    pid
  end

  def roll(_game, roll) when roll < 0, do: {:error, "Pins must have a value from 0 to 10"}
  def roll(_game, roll) when roll > 10, do: {:error, "Pins must have a value from 0 to 10"}
  def roll(game, roll) do
    case GenServer.call(game, {:roll, roll}) do
      :ok -> game
      error -> error
    end
  end

  def score(game) do
    GenServer.call(game, :score)
  end

  ## SERVER

  def init(_) do
    game = %{score: 0, rolls: [], roll_number: 1, finished: false}
    {:ok, game}
  end

  def handle_call({:roll, 10}, _caller, %{roll_number: 9} = game) do
    new_game = %{game | rolls: [10], roll_number: game.roll_number - 1}
    {:reply, :ok, new_game}
  end

  def handle_call({:roll, roll}, _caller, %{rolls: [first], roll_number: 10} = game) when roll + first == 10 do
    new_game = %{game | rolls: [], score: game.score + roll + first, finished: true}
    {:reply, :ok, new_game}
  end

  def handle_call({:roll, roll}, _caller, %{rolls: [], roll_number: 10} = game) do
    new_game = %{game | score: game.score + roll, finished: true}
    {:reply, :ok, new_game}
  end

  def handle_call({:roll, roll}, _caller, %{rolls: [previous]} = game) when roll + previous > 10 and previous != 10 do
    {:reply, {:error, "Pin count exceeds pins on the lane"}, game}
  end

  def handle_call({:roll, roll}, _caller, %{rolls: [first], roll_number: 10} = game) do
    new_game = %{game | rolls: [roll], score: game.score + first + roll, finished: true}
    {:reply, :ok, new_game}
  end

  def handle_call({:roll, roll}, _caller, %{rolls: [second, 10]} = game) do
    new_game = %{game | rolls: [roll, second], score: game.score + 10 + second + roll, finished: true}
    {:reply, :ok, new_game}
  end

  def handle_call({:roll, roll}, _caller, %{rolls: [second, first]} = game) when first + second == 10 do
    new_game = %{game | rolls: [roll], roll_number: game.roll_number + 1, score: game.score + first + second + roll}
    {:reply, :ok, new_game}
  end

  def handle_call({:roll, roll}, _caller, %{rolls: [second, first]} = game) do
    new_game = %{game | rolls: [roll], roll_number: game.roll_number + 1, score: game.score + first + second}
    {:reply, :ok, new_game}
  end

  def handle_call({:roll, roll}, _caller, game) do
    new_game = %{game | rolls: [roll|game.rolls]}
    {:reply, :ok, new_game}
  end

  def handle_call(:score, _caller, game) do
    cond do
      game.finished -> {:reply, game.score, game}
      true -> {:reply, {:error, "Score cannot be taken until the end of the game"}, game}
    end
  end
end
