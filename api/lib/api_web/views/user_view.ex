defmodule ApiWeb.UserView do
  use ApiWeb, :view


  def render("post_user.json", %{status: status, success: success, message: message}),
    do: %{status: status, success: success, message: message}

  def render("get_users.json", %{status: status, success: success, message: message, content: content}),
    do: %{status: status, success: success, message: message, content: content}

end
