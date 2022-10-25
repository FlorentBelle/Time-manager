defmodule ApiWeb.RollController do
  use ApiWeb, :controller

  alias Api.User
  alias Api.WorkingTimes

  def getUserWithParams(conn, params) do
    render(conn, "getUserWithParams.json", id: params)
  end

  def getUsers(conn, %{"username" => username, "email" => email} = params) do
    render(conn, "getUserWithParams.json", params: params)
  end

  def getUsers(conn, params) do
    render(conn, "getUsers.json", params: params)
  end

  def getUserWithID(conn, params) do
    render(conn, "getUserWithID.json", id: params)
  end

  def postUser(conn, params) do
    render(conn, "postUser.json", params: params)
  end

  def putUser(conn, %{"id" => id, "params" => params}) do
    user = User.get_user!(id)

    with {:ok, %User{} = user} <- User.update_user(user, params) do
      render(conn, "putUser.json", params: params)
    end
  end

  def postWorkingTime(conn, params) do
    render(conn, "postWorkingTime.json", params: params)
  end

  def putWorkingTime(conn, %{"id" => id, "params" => params}) do
    working_time = WorkingTimes.get_working_time!(id)

    with {:ok, %WorkingTimes{} = working_time} <- WorkingTimes.update_working_time(working_time, params) do
      render(conn, "putWorkingTime.json", params: params)
    end
  end

end
