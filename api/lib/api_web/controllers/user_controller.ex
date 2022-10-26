defmodule ApiWeb.UserController do
  use ApiWeb, :controller

  import Ecto.Query

  alias Api.User
  alias Api.Repo

  def create(conn, %{ "email" => email, "username" => username } = params) do
    case params |> User.create_user() do
      {:ok, %User{} = _user} ->
        conn |> render(ApiWeb.UserView, "post_user.json", %{status: 201, success: true, message: "User created"})
      _ ->
        if(Repo.exists?(from u in User, where: u.email == ^email)) do
          conn |> render(ApiWeb.ErrorView, "error.json", %{status: 409, error: "User already exists"})
        else
          conn |> render(ApiWeb.ErrorView, "error.json", %{status: 500, error: "Interal Server Error. Canno't create user"})
        end
    end
  end

  def retrieveAll(conn, params) do
    email = params["email"]
    username = params["username"]

    if (username === nil || email === nil) do
      if (username !== nil && email === nil) do
        retrieved = Repo.all(from u in User, where: u.username == ^username)
        if (retrieved !== nil && Enum.count(retrieved) !== 0) do
          conn |> render(ApiWeb.UserView, "get_users.json", %{status: 200, success: true, message: "User matching the given username query retrieved", content: retrieved})
        else
          conn |> render(ApiWeb.ErrorView, "error.json", %{status: 403, error: "No user matching the given username query"})
        end
      else
        if (email !== nil && username === nil) do
          retrieved = Repo.all(from u in User, where: u.email == ^email)
          if (retrieved !== nil && Enum.count(retrieved) !== 0) do
            conn |> render(ApiWeb.UserView, "get_users.json", %{status: 200, success: true, message: "Users matching the given email query retrieved", content: retrieved})
          else
            conn |> render(ApiWeb.ErrorView, "error.json", %{status: 403, error: "No user matching the given email query"})
          end
        else
          retrieved = Repo.all(User)
          if(retrieved !== nil && Enum.count(retrieved) !== 0) do
            conn |> render(ApiWeb.UserView, "get_users.json", %{status: 200, success: true, message: "All users retrieved", content: retrieved})
          else
            conn |> render(ApiWeb.ErrorView, "error.json", %{status: 403, error: "No user found"})
          end
        end
      end
    else
      retrieved = Repo.all(from u in User, where: u.username >= ^username, where: u.email <= ^email)
      if(retrieved !== nil && Enum.count(retrieved) !== 0) do
        conn |> render(ApiWeb.UserView, "get_users.json", %{status: 200, success: true, message: "Users matching the given queries email and username retrieved", content: retrieved})
      else
        conn |> render(ApiWeb.ErrorView, "error.json", %{status: 403, error: "No user the given queries email and username"})
      end
    end
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
      conn |> render(ApiWeb.UserView, "get_users.json", %{status: "204", success: true, message: "User deleted"})
    else
      conn |> render(ApiWeb.ErrorView, "error.json", %{status: "403", error: "No user found"})
    end
  end

end
