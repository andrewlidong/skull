defmodule Skull.GameServer do
  use GenServer

  alias Skull.GameLogic

  def start_link(game_id), do: GenServer.start_link(__MODULE__, game_id, name: via_tuple(game_id))

  defp via_tuple(game_id), do: {:via, Registry, {Skull.GameRegistry, game_id}}

  def init(game_id), do: {:ok, GameLogic.init_state(game_id)}

  def make_move(game_id, player_id, type, data) do
    GenServer.call(via_tuple(game_id), {:make_move, player_id, type, data})
  end

  # test2

  def player_joined(game_id, player_id) do
    GenServer.call(via_tuple(game_id), {:player_joined, player_id})
  end

  def handle_call({:make_move, pid, type, data}, _from, state) do
    with {:ok, new_state} <- GameLogic.dispatch(type, pid, data, state) do
      {:reply, {:ok, new_state}, new_state}
    else
      {:error, reason} -> {:reply, {:error, reason}, state}
    end
  end

  def handle_call({:player_joined, pid}, _from, state) do
    {:reply, :ok, GameLogic.player_joined(pid, state)}
  end
end
