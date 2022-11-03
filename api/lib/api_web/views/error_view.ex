defmodule ApiWeb.ErrorView do
  use ApiWeb, :view

  def render("error.json", %{status: status, error: error}),
    do: %{status: status, success: false, error: error}

  # def template_not_found(template, _assigns) do
  #   Phoenix.Controller.status_message_from_template(template)
  # end

end
