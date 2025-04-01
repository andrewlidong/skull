defmodule Skull.Repo do
  use Ecto.Repo,
    otp_app: :skull,
    adapter: Ecto.Adapters.SQLite3
end
