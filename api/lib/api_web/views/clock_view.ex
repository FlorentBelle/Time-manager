defmodule ApiWeb.ClocksView do
  use ApiWeb, :view

  import Ecto.Query

  alias Api.{Repo, User, Clocks, WorkingTimes}

  def render("create_clock.json", %{status: status, success: success, message: message}),
    do: %{status: status, success: success, message: message}

  def render("get_clock.json", %{status: status, success: success, message: message, content: content}),
    do: %{status: status, success: success, message: message, content: content}
end
