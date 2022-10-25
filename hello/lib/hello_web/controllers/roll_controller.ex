defmodule HelloWeb.RollController do
  use HelloWeb, :controller

  def getAllUsers(conn, params) do
    render(conn, "getAllUsers.json", params: params)
  end

  def getUserWithID(conn, params) do
    render(conn, "getUserWithID.json", id: params)
  end

  def postUser(conn, params) do
    render(conn, "postUser.json", params: params)
  end

  def putUser(conn, params) do
    render(conn, "putUser.json", params: params)
  end

  def deleteUser(conn, params) do
    render(conn, "deleteUser.json", params: params)
  end

  def getAllWorktimes(conn, params) do
    render(conn, "getAllWorktimes.json", params: params)
  end

  def getWorktimesByID(conn, params) do
    render(conn, "getWorktimesByID.json", params: params)
  end

  def postWorkingTimes(conn, params) do
    render(conn, "postWorkingTimes.json", params: params)
  end

  def deleteWorkingTime(conn, params) do
    render(conn, "deleteWorkingTime.json", params: params)
  end
end
