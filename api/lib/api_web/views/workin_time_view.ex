defmodule ApiWeb.WorkingTimesView do
  use ApiWeb, :view


  def render("working_time_view.json", %{status: status, success: success, message: message, content: content}),
    do: %{status: status, success: success, message: message, content: content}

end
