defmodule Skull.GameSupervisor do
  use DynamicSupervisor

  alias Skull.GameServer

  def start_link(_), do: DynamicSupervisor.start_link(__MODULE__, :ok, name: __MODULE__)

  def init(:ok), do: DynamicSupervisor.init(strategy: :one_for_one)

  def ensure_game_started(game_id) do
    case Registry.lookup(Skull.GameRegistry, game_id) do
      [] ->
        DynamicSupervisor.start_child(__MODULE__, {GameServer, game_id})

      _ ->
        :ok
    end
  end
end
