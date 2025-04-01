defmodule SkullBackendWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :skull_backend

  socket "/socket", SkullBackendWeb.UserSocket,
    websocket: true,
    longpoll: false

  plug Plug.Static,
    at: "/",
    from: :skull_backend,
    only: ~w(assets fonts images favicon.ico robots.txt test.html)
end
