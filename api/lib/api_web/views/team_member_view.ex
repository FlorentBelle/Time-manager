defmodule ApiWeb.TeamsMemberView do
  use ApiWeb, :view


  def render("add_team_member.json", %{status: status, success: success, message: message, userid: userID}),
    do: %{status: status, success: success, message: message, userid: userID}

  def render("get_teams.json", %{status: status, success: success, message: message, content: content}),
    do: %{status: status, success: success, message: message, content: content}

end
