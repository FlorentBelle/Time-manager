defmodule ApiWeb.RolesView do
  use ApiWeb, :view


  def render("create_role.json", %{status: status, success: success, message: message}),
    do: %{status: status, success: success, message: message}

  def render("get_roles.json", %{status: status, success: success, message: message, content: content}),
    do: %{status: status, success: success, message: message, content: content}

end
