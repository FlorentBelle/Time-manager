defmodule ApiWeb.WorkingTimesView do
  use ApiWeb, :view


  def render("post_working_time.json", %{status: status, success: success, message: message}),
    do: %{status: status, success: success, message: message}

  def render("get_working_time.json", %{status: status, success: success, message: message, content: content}),
    do: %{status: status, success: success, message: message, content: content}

end
