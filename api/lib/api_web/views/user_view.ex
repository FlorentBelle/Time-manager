defmodule ApiWeb.UserView do
  use ApiWeb, :view

  import Ecto.Query

  alias Api.{Repo, User, Clocks, WorkingTimes}

  defstruct [:id, :username, :email, :inserted_at, :updated_at]

  def render("create_user.json", %{status: status, success: success, message: message}),
    do: %{status: status, success: success, message: message}

  def render("get_users.json", %{status: status, success: success, message: message, content: content}),
    do: %{status: status, success: success, message: message, content: content}

  def render("delete_user.json", %{status: status, success: success, message: message}),
    do: %{status: status, success: success, message: message}

end
