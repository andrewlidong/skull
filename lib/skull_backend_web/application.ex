defmodule SkullBackendWeb.Application do
  use Application

  def start(_type, _args) do
    children = [
      {Registry, keys: :unique, name: Skull.GameRegistry},
      Skull.GameSupervisor,
      SkullBackendWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: SkullBackend.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
