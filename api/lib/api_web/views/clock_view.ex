defmodule ApiWeb.ClocksView do
  use ApiWeb, :view

  import Ecto.Query

  alias Api.{Repo, User, Clocks, WorkingTimes}


  def render("create_clock.json", %{"status" => status, "time" => time, "userId" => userId}) do
    {:ok, dt_struct, utc_offset} = DateTime.from_iso8601(time)
    time_ = DateTime.truncate(dt_struct, :second)
    # userId = params["userId"]
    # status = params["status"]
    clockId = Repo.insert(%Clocks{status: status, time: time_, user: userId})
    %{status: "201", success: true, message: "Clock"}
  end

  # def render("create_clock.json", %{status: status, success: success, message: message}),
  #   do: %{status: status, success: success, message: message}

  def render("get_clock.json", %{status: status, success: success, message: message, content: content}),
    do: %{status: status, success: success, message: message, content: content}
end
