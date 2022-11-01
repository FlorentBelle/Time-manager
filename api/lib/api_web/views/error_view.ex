defmodule ApiWeb.ErrorView do
  use ApiWeb, :view

  def render("error.json", %{status: status, error: error}),
    do: %{status: status, success: false, error: error}
end
