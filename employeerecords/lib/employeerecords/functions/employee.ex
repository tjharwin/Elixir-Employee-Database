defmodule Employeerecords.Functions.Employee do
  use Ecto.Schema
  import Ecto.Changeset

  schema "employees" do
    field :location, :string
    field :name, :string
    field :photo, :string
    field :role, :string

    timestamps()
  end

  @doc false
  def changeset(employee, attrs) do
    employee
    |> cast(attrs, [:name, :role, :photo, :location])
    |> validate_required([:name, :role, :photo, :location])
  end
end
