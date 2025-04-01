defmodule SkullBackendWeb.GameChannel do
  use Phoenix.Channel

  alias Skull.GameSupervisor
  alias Skull.GameServer

  def join("game:" <> game_id, %{"player_id" => player_id}, socket) do
    GameSupervisor.ensure_game_started(game_id)
    {:ok, GameServer.player_joined(game_id, player_id), assign(socket, :game_id, game_id)}
  end

  def handle_in("make_move", %{"player_id" => pid, "type" => type, "data" => data}, socket) do
    game_id = socket.assigns.game_id

    case GameServer.make_move(game_id, pid, type, data) do
      {:ok, new_state} ->
        broadcast!(socket, "game_update", %{state: new_state})
        {:noreply, socket}

      {:error, reason} ->
        push(socket, "error", %{reason: reason})
        {:noreply, socket}
    end
  end

  def handle_in("new_msg", payload, socket) do
    broadcast!(socket, "new_msg", payload)
    {:noreply, socket}
  end
end
