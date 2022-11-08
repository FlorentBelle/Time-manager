defmodule ApiWeb.RolesController do
  use ApiWeb, :controller

  import Ecto.Query
  alias Api.Roles
  alias Api.Repo

  def create(conn, %{"role_name" => rolename}) do
    if(conn.assigns == %{}) do
      conn |> render(ApiWeb.ErrorView, "error.json", %{status: 401, error: "Unauthorize"})
    else
      Repo.insert(%Roles{role_name: rolename})
      conn |> render(ApiWeb.RolesView, "create_role.json", status: 201, success: true, message: "role_created")
    end
  end

  def retrieve(conn, params) do
    if(conn.assigns == %{}) do
      conn |> render(ApiWeb.ErrorView, "error.json", %{status: 401, error: "Unauthorize"})
    else
      retrieved = Repo.all(Roles)
      if (retrieved !== nil && retrieved !== []) do
        conn |> render(ApiWeb.RolesView, "get_roles.json", %{status: "200", success: true, message: "roles found", content: retrieved})
      else
        conn |> render(ApiWeb.ErrorView, "error.json", %{status: "403", error: "No Roles Found"})
      end
    end
  end

  def retrievedroits(conn,  %{"roleID" => roleID}) do
    if(conn.assigns == %{}) do
      conn |> render(ApiWeb.ErrorView, "error.json", %{status: 401, error: "Unauthorize"})
    else
      roleID = String.to_integer(roleID)
      retrieved = Repo.one(from r in Roles, where: r.id == ^roleID)
      if (retrieved !== nil && retrieved !== []) do
        conn |> render(ApiWeb.RolesView, "get_roles.json", %{status: "200", success: true, message: "roles found", content: retrieved})
      else
        conn |> render(ApiWeb.ErrorView, "error.json", %{status: "403", error: "No Roles Found"})
      end
    end
  end
  
end
