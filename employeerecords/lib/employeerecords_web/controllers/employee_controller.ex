defmodule EmployeerecordsWeb.EmployeeController do
  use EmployeerecordsWeb, :controller

  alias Employeerecords.Functions
  alias Employeerecords.Functions.Employee

  def index(conn, _params) do
    employees = Functions.list_employees()
    render(conn, "index.html", employees: employees)
  end

  def new(conn, _params) do
    changeset = Functions.change_employee(%Employee{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"employee" => employee_params}) do
    case Functions.create_employee(employee_params) do
      {:ok, employee} ->
        conn
        |> put_flash(:info, "Employee created successfully.")
        |> redirect(to: Routes.employee_path(conn, :show, employee))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    employee = Functions.get_employee!(id)
    render(conn, "show.html", employee: employee)
  end

  def edit(conn, %{"id" => id}) do
    employee = Functions.get_employee!(id)
    changeset = Functions.change_employee(employee)
    render(conn, "edit.html", employee: employee, changeset: changeset)
  end

  def update(conn, %{"id" => id, "employee" => employee_params}) do
    employee = Functions.get_employee!(id)

    case Functions.update_employee(employee, employee_params) do
      {:ok, employee} ->
        conn
        |> put_flash(:info, "Employee updated successfully.")
        |> redirect(to: Routes.employee_path(conn, :show, employee))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", employee: employee, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    employee = Functions.get_employee!(id)
    {:ok, _employee} = Functions.delete_employee(employee)

    conn
    |> put_flash(:info, "Employee deleted successfully.")
    |> redirect(to: Routes.employee_path(conn, :index))
  end
end
