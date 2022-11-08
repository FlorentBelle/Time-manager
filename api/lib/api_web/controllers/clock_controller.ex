defmodule ApiWeb.ClocksController do
  use ApiWeb, :controller

  import Ecto.Query

  alias Api.Clocks
  alias Api.Repo
  alias Api.WorkingTimes

  def create(conn, %{"status" => status, "time" => time, "user" => userId}) do
    if(conn.assigns == %{}) do
      conn |> render(ApiWeb.ErrorView, "error.json", %{status: 401, error: "Unauthorize"})
    else
      {:ok, dt_struct, utc_offset} = DateTime.from_iso8601(time)
      time_ = DateTime.truncate(dt_struct, :second)
      if (userId !== nil) do
        Repo.insert(%Clocks{user: userId, time: time_, status: status})
        conn |> render(ApiWeb.ClocksView, "create_clock.json", status: 201, success: true, message: "Clock created")
      else
        conn |> render(ApiWeb.ErrorView, "error.json", status: 403, error: "No user found")
      end
    end
  end

  def retrieve(conn, params) do
    if(conn.assigns == %{}) do
      conn |> render(ApiWeb.ErrorView, "error.json", %{status: 401, error: "Unauthorize"})
    else
      userID = params["userID"]
      retrieved = Repo.one(from c in Clocks, where: c.user == ^userID)
      if (retrieved !== nil) do
        conn |> render(ApiWeb.ClocksView, "get_clock.json", %{status: "200", success: true, message: "Clock found", content: retrieved})
      else
        conn |> render(ApiWeb.ErrorView, "error.json", %{status: "403", error: "No clock found"})
      end
    end
  end

  def update(conn, params) do
    if(conn.assigns == %{}) do
      conn |> render(ApiWeb.ErrorView, "error.json", %{status: 401, error: "Unauthorize"})
    else
      id = params["id"]
      if(id !== nil) do
        id = String.to_integer(params["id"])
        clock = Repo.one(from w in Clocks, where: w.id == ^id)
        if (clock.status === false) do
          newParams = %{time: DateTime.utc_now(), status: true}
          clock
          |> Clocks.changeset(newParams)
          |> Repo.update()
          conn |> render(ApiWeb.WorkingTimesView, "working_time_view.json", %{status: 200, success: true, message: "Working time started for this user", content: params})
        else
          newParams = %{time: DateTime.utc_now(), status: false}
          time = DateTime.truncate(newParams.time, :second)
          clock
          |> Clocks.changeset(newParams)
          |> Repo.update()
          Repo.insert(%WorkingTimes{user: clock.user, start: clock.time, end: time})
          conn |> render(ApiWeb.WorkingTimesView, "working_time_view.json", %{status: 200, success: true, message: "Working time stopped for this user", content: params})
        end
      else
        conn |> render(ApiWeb.ErrorView, "error.json", status: 404, error: "Route not found")
      end
    end
  end

end
