defmodule ApiWeb.ClocksView do
  use ApiWeb, :view

  def render("create_clock.json", %{status: status, success: success, message: message}),
    do: %{status: status, success: success, message: message}

  def render("get_clock.json", %{status: status, success: success, message: message, content: content}),
    do: %{status: status, success: success, message: message, content: content}

end
