defmodule EmployeerecordsWeb.PageController do
  use EmployeerecordsWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
