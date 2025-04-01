defmodule Skull.GameLogic do
  def init_state(game_id) do
    %{
      game_id: game_id,
      players: %{},
      phase: :placing,
      board: [],
      history: []
    }
  end

  def player_joined(pid, state) do
    Map.update(state, :players, %{pid => %{hand: [:skull, :rose, :rose, :rose]}}, fn players ->
      Map.put(players, pid, %{hand: [:skull, :rose, :rose, :rose]})
    end)
  end

  def dispatch("place_card", pid, %{"card" => card}, state) do
    # Replace with real rules
    {:ok, put_in(state[:board], [{pid, card} | state.board])}
  end

  def dispatch("bet", pid, %{"amount" => amt}, state), do: {:ok, Map.put(state, :bet, {pid, amt})}
  def dispatch(_, _, _, _), do: {:error, "invalid move"}
end
