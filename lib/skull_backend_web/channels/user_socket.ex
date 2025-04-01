defmodule SkullBackendWeb.UserSocket do
  use Phoenix.Socket

  channel "game:*", SkullBackendWeb.GameChannel

  def id(_socket), do: nil
end
