defmodule Employeerecords.FunctionsTest do
  use Employeerecords.DataCase

  alias Employeerecords.Functions

  describe "employees" do
    alias Employeerecords.Functions.Employee

    @valid_attrs %{location: "some location", name: "some name", photo: "some photo", role: "some role"}
    @update_attrs %{location: "some updated location", name: "some updated name", photo: "some updated photo", role: "some updated role"}
    @invalid_attrs %{location: nil, name: nil, photo: nil, role: nil}

    def employee_fixture(attrs \\ %{}) do
      {:ok, employee} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Functions.create_employee()

      employee
    end

    test "list_employees/0 returns all employees" do
      employee = employee_fixture()
      assert Functions.list_employees() == [employee]
    end

    test "get_employee!/1 returns the employee with given id" do
      employee = employee_fixture()
      assert Functions.get_employee!(employee.id) == employee
    end

    test "create_employee/1 with valid data creates a employee" do
      assert {:ok, %Employee{} = employee} = Functions.create_employee(@valid_attrs)
      assert employee.location == "some location"
      assert employee.name == "some name"
      assert employee.photo == "some photo"
      assert employee.role == "some role"
    end

    test "create_employee/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Functions.create_employee(@invalid_attrs)
    end

    test "update_employee/2 with valid data updates the employee" do
      employee = employee_fixture()
      assert {:ok, %Employee{} = employee} = Functions.update_employee(employee, @update_attrs)
      assert employee.location == "some updated location"
      assert employee.name == "some updated name"
      assert employee.photo == "some updated photo"
      assert employee.role == "some updated role"
    end

    test "update_employee/2 with invalid data returns error changeset" do
      employee = employee_fixture()
      assert {:error, %Ecto.Changeset{}} = Functions.update_employee(employee, @invalid_attrs)
      assert employee == Functions.get_employee!(employee.id)
    end

    test "delete_employee/1 deletes the employee" do
      employee = employee_fixture()
      assert {:ok, %Employee{}} = Functions.delete_employee(employee)
      assert_raise Ecto.NoResultsError, fn -> Functions.get_employee!(employee.id) end
    end

    test "change_employee/1 returns a employee changeset" do
      employee = employee_fixture()
      assert %Ecto.Changeset{} = Functions.change_employee(employee)
    end
  end
end
