defmodule ApiWeb.WorkingTimeController do
  use ApiWeb, :controller

  import Ecto.Query

  alias Api.WorkingTimes
  alias Api.User
  alias Api.Repo

  # conn |> render(ApiWeb.WorkingTimesView, "get_working_time.json", %{status: 0, success: 0, message: "Logger: ", content: is_integer(userID)})

  def create(conn, params) do
    {:ok, dt_struct, utc_offset} = DateTime.from_iso8601(params["end"])
    end_parse = DateTime.truncate(dt_struct, :second)
    {:ok, dt_struct, utc_offset} = DateTime.from_iso8601(params["start"])
    start_parse = DateTime.truncate(dt_struct, :second)

    userId = params["userID"]
    user = Repo.one(from u in User, where: u.id == ^userId)

    if (user !== nil) do
      Repo.insert(%WorkingTimes{end: end_parse, start: start_parse, user: user.id})
      conn |> render(ApiWeb.WorkingTimesView, "working_time_view.json", %{status: 201, success: true, message: "Workingtime registered", content: user})
    else
      conn |> render(ApiWeb.ErrorView, "error.json", status: 403, error: "No user found")
    end
  end

  def retrieveAll(conn, params) do
    end_ = params["end"]
    start_ = params["start"]
    userID = params["userID"]


    if ((start_ === nil || end_ === nil) && userID !== nil) do
      if (start_ !== nil) do
        {:ok, dt_struct, utc_offset} = DateTime.from_iso8601(start_)
        start__ = DateTime.truncate(dt_struct, :second)
        retrieved = Repo.all(from w in WorkingTimes, where: w.user == ^userID, where: w.start >= ^start__)
        conn |> render(ApiWeb.WorkingTimesView, "working_time_view.json", %{status: 200, success: true, message: "Workingtime retrieved for start query parameter", content: retrieved})
      else
        if (end_ !== nil) do
          {:ok, dt_struct, utc_offset} = DateTime.from_iso8601(end_)
          end__ = DateTime.truncate(dt_struct, :second)
          retrieved = Repo.all(from w in WorkingTimes, where: w.user == ^userID, where: w.end <= ^end__)
            conn |> render(ApiWeb.WorkingTimesView, "working_time_view.json", %{status: 200, success: true, message: "Workingtime retrieved for end query parameter", content: retrieved})
        end
      end
    else
      if(userID !== nil) do
        {:ok, dt_struct, utc_offset} = DateTime.from_iso8601(start_)
        start__ = DateTime.truncate(dt_struct, :second)
        {:ok, dt_struct, utc_offset} = DateTime.from_iso8601(end_)
        end__ = DateTime.truncate(dt_struct, :second)
        retrieved = Repo.all(from w in WorkingTimes, where: w.user == ^userID, where: w.start >= ^start__, where: w.end <= ^end__)
        conn |> render(ApiWeb.WorkingTimesView, "working_time_view.json", %{status: 200, success: true, message: "All workingtime retrieved for the query parameters", content: retrieved})
      end
    end
    if ((is_integer(userID) || is_bitstring(userID)) &&  userID !== nil) do
      if(is_bitstring(userID)) do
        userID = String.to_integer(userID)
      end
      user = Repo.one(from u in User, where: u.id == ^userID)
      if(user !== nil) do
        workingtime = Repo.all(from w in WorkingTimes, where: w.user == ^userID)
        if(workingtime !== nil && length(workingtime) !== 0) do
          conn |> render(ApiWeb.WorkingTimesView, "working_time_view.json", %{status: 200, success: true, message: "Working time retrieved for the user", content: workingtime})
        else
          conn |> render(ApiWeb.ErrorView, "error.json", status: 403, error: "No working time for this user")
        end
      else
        conn |> render(ApiWeb.ErrorView, "error.json", status: 403, error: "No user found")
      end
    else
      conn |> render(ApiWeb.ErrorView, "error.json", status: 404, error: "Route not found")
    end
  end

  def retrieve(conn, params) do
    id = String.to_integer(params["id"])
    userID = String.to_integer(params["userID"])

    if(userID !== nil && id !== nil && is_integer(userID) && is_integer(id)) do
      user = Repo.one(from u in User, where: u.id == ^userID)
      working_time = Repo.one(from u in WorkingTimes, where: u.user == ^userID, where: u.id == ^id)
      if(user !== nil) do
        if(working_time !== nil) do
          conn |> render(ApiWeb.WorkingTimesView, "working_time_view.json", %{status: 200, success: true, message: "One working time found for this user", content: working_time})
        else
          conn |> render(ApiWeb.ErrorView, "error.json", status: 403, error: "No working time found")
        end
      else
        conn |> render(ApiWeb.ErrorView, "error.json", status: 403, error: "No user found")
      end
    else
      conn |> render(ApiWeb.ErrorView, "error.json", status: 404, error: "Route not found")
    end
  end

  def update(conn, params) do
    id = params["id"]

    if(id !== nil) do
      id = String.to_integer(params["id"])
      {:ok, dt_struct, utc_offset} = DateTime.from_iso8601(params["end"])
      end_parse = DateTime.truncate(dt_struct, :second)
      {:ok, dt_struct, utc_offset} = DateTime.from_iso8601(params["start"])
      start_parse = DateTime.truncate(dt_struct, :second)
      newParams = %{start: start_parse, id: id, end: end_parse}
      working_time = Repo.one(from w in WorkingTimes, where: w.id == ^id)
      if(working_time !== nil) do
        working_time
        |> WorkingTimes.changeset(newParams)
        |> Repo.update()
        conn |> render(ApiWeb.WorkingTimesView, "working_time_view.json", %{status: 200, success: true, message: "Working time updated for this user", content: params})
      else
        conn |> render(ApiWeb.ErrorView, "error.json", status: 403, error: "No working time found")
      end
    else
      conn |> render(ApiWeb.ErrorView, "error.json", status: 404, error: "Route not found")
    end
  end

  def delete(conn, params) do
    id = params["id"]
    if(id !== nil) do
      id = String.to_integer(params["id"])
      working_time = Repo.one(from w in WorkingTimes, where: w.id == ^id)
      if(working_time !== nil) do
        Repo.delete(working_time)
        conn |> render(ApiWeb.WorkingTimesView, "working_time_view.json", %{status: 204, success: true, message: "Working time deleted", content: working_time})
      else
        conn |> render(ApiWeb.ErrorView, "error.json", status: 403, error: "No working time found")
      end
    else
      conn |> render(ApiWeb.ErrorView, "error.json", status: 404, error: "Route not found")
    end
  end

end
