defmodule ApiWeb.ClocksController do
  use ApiWeb, :controller

  import Ecto.Query

  alias Api.Clocks
  alias Api.Repo

  def create(conn, %{"status" => status, "time" => time, "user" => userId}) do
    {:ok, dt_struct, utc_offset} = DateTime.from_iso8601(time)
    time_ = DateTime.truncate(dt_struct, :second)
    if (userId !== nil) do
      Repo.insert(%Clocks{user: userId, time: time_, status: status})
      conn |> render(ApiWeb.ClocksView, "create_clock.json", status: 201, success: true, message: "Clock created")
    else
      conn |> render(ApiWeb.ErrorView, "error.json", status: 403, error: "No user found")
    end
  end

  def retrieve(conn, params) do
    clockId = String.to_integer(params["id"])
    userID = params["userID"]
    retrieved = Repo.one(from c in Clocks, where: c.user == ^userID, where: c.id == ^clockId)
    if (retrieved !== nil) do
      conn |> render(ApiWeb.ClocksView, "get_clock.json", %{status: "200", success: true, message: "Clock found", content: retrieved})
    else
      conn |> render(ApiWeb.ErrorView, "error.json", %{status: "403", error: "No clock found"})
    end
  end
end
