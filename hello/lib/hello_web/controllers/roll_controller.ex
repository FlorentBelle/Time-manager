defmodule HelloWeb.RollController do
  use HelloWeb, :controller

  def getUserWithParams(conn, params) do
    render(conn, "getUserWithParams.json", id: params)
  end

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

end
