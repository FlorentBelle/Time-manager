defmodule ApiWeb.UserView do
  use ApiWeb, :view


  def render("user_view.json", %{status: status, success: success, message: message, content: content}),
    do: %{status: status, success: success, message: message, content: content}

end
