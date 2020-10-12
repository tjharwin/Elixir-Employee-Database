defmodule Employeerecords.Repo do
  use Ecto.Repo,
    otp_app: :employeerecords,
    adapter: Ecto.Adapters.Postgres
end
