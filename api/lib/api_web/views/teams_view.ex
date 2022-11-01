defmodule ApiWeb.TeamsView do
  use ApiWeb, :view


  def render("create_team.json", %{status: status, success: success, message: message}),
    do: %{status: status, success: success, message: message}

  def render("get_teams.json", %{status: status, success: success, message: message, content: content}),
    do: %{status: status, success: success, message: message, content: content}

end
