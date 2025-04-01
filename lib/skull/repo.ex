defmodule Skull.Repo do
  use Ecto.Repo,
    otp_app: :skull,
    adapter: Ecto.Adapters.Postgres
end
