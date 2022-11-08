defmodule ApiWeb.TeamsController do
  use ApiWeb, :controller

  import Ecto.Query
  alias Api.Teams
  alias Api.Repo
  alias Api.User

  def create(conn, params) do
    if(conn.assigns == %{}) do
      conn |> render(ApiWeb.ErrorView, "error.json", %{status: 401, error: "Unauthorize"})
    else
      teamname = params["team_name"]
      userId = params["userID"]
      user = Repo.one(from u in User, where: u.id == ^userId)
      if (user !== nil) do
        Repo.insert(%Teams{team_name: teamname, user: user.id})
        conn |> render(ApiWeb.TeamsView, "create_team.json", status: 201, success: true, message: "Team created")
      else
        conn |> render(ApiWeb.ErrorView, "error.json", status: 403, error: "Team can not be insered")
      end
    end
  end

  def retrieve(conn, params) do
    if(conn.assigns == %{}) do
      conn |> render(ApiWeb.ErrorView, "error.json", %{status: 401, error: "Unauthorize"})
    else
      retrieved = Repo.all(Teams)
      if (retrieved !== nil && retrieved !== []) do
        conn |> render(ApiWeb.TeamsView, "get_teams.json", %{status: "200", success: true, message: "teams found", content: retrieved})
      else
        conn |> render(ApiWeb.ErrorView, "error.json", %{status: "403", error: "No teams Found"})
      end
    end
  end

  def retrievewithid(conn, params) do
    if(conn.assigns == %{}) do
      conn |> render(ApiWeb.ErrorView, "error.json", %{status: 401, error: "Unauthorize"})
    else
      userId = params["userID"]
      retrieved = Repo.all(from t in Teams, where: t.user == ^userId)
      if (retrieved !== nil && retrieved !== []) do
        conn |> render(ApiWeb.TeamsView, "get_teams.json", %{status: "200", success: true, message: "teams found", content: retrieved})
      else
        conn |> render(ApiWeb.ErrorView, "error.json", %{status: "403", error: "No teams Found"})
      end
    end
  end
  
end
