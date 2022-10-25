defmodule ApiWeb.UserController do
  use ApiWeb, :controller

  alias Api.User

  def create(conn, params) do
    case params |> User.create_user() do
      {:ok, %User{} = _user} -> conn |> render(ApiWeb.UserView, "create_user.json", %{status: "201", success: true, message: "User created"})
      _ -> conn |> render(ApiWeb.ErrorView, "error.json", %{status: "500", error: "Interal Server Error"})
    end
  end

  def retrieveAll(conn, %{"username" => username, "email" => email}) do
    user = User.get_queried_users(email, username)
    conn |> render(ApiWeb.UserView, "get_users.json", %{status: "200", success: true, message: "User found", content: user})
  end

  def retrieveAll(conn, %{"username" => username}) do
    conn |> render(ApiWeb.ErrorView, "error.json", %{status: "403", error: "Not enough query params provided"})
  end

  def retrieveAll(conn, %{"email" => email}) do
    conn |> render(ApiWeb.ErrorView, "error.json", %{status: "403", error: "Not enough query params provided"})
  end

  def retrieveAll(conn, params) do
    conn |> render(ApiWeb.UserView, "get_users.json", %{status: "200", success: true, message: "Users found", content: User.get_all_users()})
  end

  def retrieveAll(conn, params) do
    conn |> render(ApiWeb.ErrorView, "error.json", %{status: "403", error: "No user found"})
  end

  def retrieve(conn, params) do
    id = String.to_integer(params["userID"])
    conn |> render(ApiWeb.UserView, "get_users.json", %{status: "200", success: true, message: "User found", content: User.get_user(id)})
  end

  def retrieve(conn, params) do
    conn |> render(ApiWeb.ErrorView, "error.json", %{status: "403", error: "No user found"})
  end

  def update(conn, %{"id" => id, "email" => email, "username" => username}) do
    user = User.get_user!(id)
    params = %{"email": email, "username": username}

    with {:ok, %User{} = user} <- User.update_user(user, params) do
      conn |> render(ApiWeb.UserView, "get_users.json", %{status: "201", success: true, message: "User updated", content: params})
    end
  end

  def delete(conn, %{"id" => id}) do
    newId = String.to_integer(id)
    user = User.get_user!(id)
    if (user !== nil) do
      User.delete_user(user)
      conn |> render(ApiWeb.UserView, "delete_user.json", %{status: "204", success: true, message: "User deleted"})
    else
      conn |> render(ApiWeb.ErrorView, "error.json", %{status: "403", error: "No user found"})
    end
  end

end
