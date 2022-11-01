defmodule ApiWeb.TeamMemberController do
  use ApiWeb, :controller

  import Ecto.Query

  alias Api.Member
  alias Api.Teams
  alias Api.Repo
  alias Api.User

  def addteammember(conn, params) do
    userID = params["userID"]
    teamID = params["teamID"]
    team = Repo.one(from t in Teams, where: t.id == ^teamID)
    user = Repo.one(from u in User, where: u.id == ^userID)
      if (user !== nil) do
        Repo.insert(%Member{team: team.id, user: user.id})
        conn |> render(ApiWeb.TeamsMemberView, "add_team_member.json", status: 201, success: true, message: "Member Added in team", userid: user.id)
      else
        conn |> render(ApiWeb.ErrorView, "error.json", status: 403, error: "Team can not be insered")
      end
  end

  def retrieve(conn, params) do
    teamId = params["teamID"]
    retrieved = Repo.all(from t in Member, where: t.team == ^teamId)
    if (retrieved !== nil && retrieved !== []) do
      conn |> render(ApiWeb.TeamsMemberView, "get_teams.json", %{status: "200", success: true, message: "Members found", content: retrieved})
    else
      conn |> render(ApiWeb.ErrorView, "error.json", %{status: "403", error: "No teams Found"})
    end
  end
end
