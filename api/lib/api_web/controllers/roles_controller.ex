defmodule ApiWeb.RolesController do
  use ApiWeb, :controller

  import Ecto.Query
  alias Api.Roles
  alias Api.Repo

  def create(conn, %{"role_name" => rolename}) do
      Repo.insert(%Roles{role_name: rolename})
      conn |> render(ApiWeb.RolesView, "create_role.json", status: 201, success: true, message: "role_created")
  end

  def retrieve(conn, params) do
    retrieved = Repo.all(Roles)
    if (retrieved !== nil && retrieved !== []) do
      conn |> render(ApiWeb.RolesView, "get_roles.json", %{status: "200", success: true, message: "roles found", content: retrieved})
    else
      conn |> render(ApiWeb.ErrorView, "error.json", %{status: "403", error: "No Roles Found"})
    end
  end
end
