defmodule ApiWeb.WorkingTimeController do
  use ApiWeb, :controller

  alias Api.WorkingTimes

  def postWorkingTime(conn, params) do
    render(conn, "postWorkingTime.json", params: params)
  end

  def getAllWorktimes(conn, params) do
    render(conn, "getAllWorktimes.json", params: params)
  end

  def getWorktimesByID(conn, params) do
    render(conn, "getWorktimesByID.json", params: params)
  end

  def putWorkingTime(conn, %{"id" => id, "params" => params}) do
    working_time = WorkingTimes.get_working_time!(id)
    with {:ok, %WorkingTimes{} = working_time} <- WorkingTimes.update_working_time(working_time, params) do
      render(conn, "putWorkingTime.json", params: params)
    end
  end

  def deleteWorkingTime(conn, params) do
    render(conn, "deleteWorkingTime.json", params: params)
  end

end
