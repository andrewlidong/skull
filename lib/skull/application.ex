defmodule Skull.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      SkullWeb.Telemetry,
      Skull.Repo,
      {DNSCluster, query: Application.get_env(:skull, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Skull.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Skull.Finch},
      # Start a worker by calling: Skull.Worker.start_link(arg)
      # {Skull.Worker, arg},
      # Start to serve requests, typically the last entry
      SkullWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Skull.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SkullWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
