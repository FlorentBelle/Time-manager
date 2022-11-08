defmodule ApiWeb.AuthView do
  use ApiWeb, :view


  def render("auth_view.json", %{status: status, success: success, message: message, content: content}),
    do: %{status: status, success: success, message: message, content: content}

  def render("login_view.json", %{status: status, success: success, message: message, user: user, token: token }),
    do: %{status: status, success: success, message: message, user: user, token: token }

  def render("authentificated_user.json", %{status: status, success: success, message: message, user: user}),
    do: %{status: status, success: success, message: message, user: user }

  def render("logout.json", %{status: status, success: success, message: message}),
    do: %{status: status, success: success, message: message }

end
