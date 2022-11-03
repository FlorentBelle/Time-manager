defmodule ApiWeb.UserController do
  use ApiWeb, :controller

  import Ecto.Query

  alias Api.User
  alias Api.Repo
  alias Api.Clocks

  # conn |> render(ApiWeb.WorkingTimesView, "get_working_time.json", %{status: 0, success: 0, message: "Logger: ", content: is_integer(userID)})

  def create(conn, %{ "email" => email, "username" => username } = params) do
    case params |> User.create_user() do
      {:ok, %User{} = user} ->
        newUser = %{ id: user.id, username: user.username, email: user.email}
        user_id = user.id
        Repo.insert(%Clocks{user: user_id})
        conn |> render(ApiWeb.UserView, "user_view.json", %{status: 201, success: true, message: "User created", content: %{user: newUser, user_id: user_id}})
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
          conn |> render(ApiWeb.UserView, "user_view.json", %{status: 200, success: true, message: "User matching the given username query retrieved", content: retrieved})
        else
          conn |> render(ApiWeb.ErrorView, "error.json", %{status: 403, error: "No user matching the given username query"})
        end
      else
        if (email !== nil && username === nil) do
          retrieved = Repo.all(from u in User, where: u.email == ^email)
          if (retrieved !== nil && Enum.count(retrieved) !== 0) do
            conn |> render(ApiWeb.UserView, "user_view.json", %{status: 200, success: true, message: "Users matching the given email query retrieved", content: retrieved})
          else
            conn |> render(ApiWeb.ErrorView, "error.json", %{status: 403, error: "No user matching the given email query"})
          end
        else
          retrieved = Repo.all(User)
          if(retrieved !== nil && Enum.count(retrieved) !== 0) do
            conn |> render(ApiWeb.UserView, "user_view.json", %{status: 200, success: true, message: "All users retrieved", content: retrieved})
          else
            conn |> render(ApiWeb.ErrorView, "error.json", %{status: 403, error: "No user found"})
          end
        end
      end
    else
      retrieved = Repo.all(from u in User, where: u.username >= ^username, where: u.email <= ^email)
      if(retrieved !== nil && Enum.count(retrieved) !== 0) do
        conn |> render(ApiWeb.UserView, "user_view.json", %{status: 200, success: true, message: "Users matching the given queries email and username retrieved", content: retrieved})
      else
        conn |> render(ApiWeb.ErrorView, "error.json", %{status: 403, error: "No user the given queries email and username"})
      end
    end
  end

  def retrieve(conn, params) do
    id = params["userID"]
    if(id !== nil) do
      if (is_bitstring(id) || is_integer(id)) do
        if(is_bitstring(id)) do
          id = String.to_integer(id)
        end
        user = Repo.one(from u in User, where: u.id == ^id)
        if(user !== nil) do
          conn |> render(ApiWeb.UserView, "user_view.json", %{status: 200, success: true, message: "User updated", content: user})
        else
          conn |> render(ApiWeb.ErrorView, "error.json", status: 403, error: "No user found")
        end
      else
        conn |> render(ApiWeb.ErrorView, "error.json", status: 403, error: "User id have to be integer or string type")
      end
    else
      conn |> render(ApiWeb.ErrorView, "error.json", status: 404, error: "Route not found")
    end
  end

  def update(conn, params) do
    id = params["userID"]
    if(id !== nil) do
      if (is_bitstring(id) || is_integer(id)) do
        if(is_bitstring(id)) do
          id = String.to_integer(id)
        end
        user = Repo.one(from u in User, where: u.id == ^id)
        if(user !== nil) do
          user
          |> User.changeset(params)
          |> Repo.update()
          conn |> render(ApiWeb.UserView, "user_view.json", %{status: 201, success: true, message: "User updated", content: params})
        else
          conn |> render(ApiWeb.ErrorView, "error.json", status: 403, error: "No user found")
        end
      else
        conn |> render(ApiWeb.ErrorView, "error.json", status: 403, error: "User id have to be integer or string type")
      end
    else
      conn |> render(ApiWeb.ErrorView, "error.json", status: 404, error: "Route not found")
    end
  end

  def delete(conn, params) do
    id = params["userID"]
    if(id !== nil) do
      id = String.to_integer(params["userID"])
      user = Repo.one(from u in User, where: u.id == ^id)
      if(user !== nil) do
        newUser = %{ id: user.id, username: user.username, email: user.email}
        Repo.delete(user)
        conn |> render(ApiWeb.UserView, "user_view.json", %{status: 204, success: true, message: "User deleted", content: newUser})
      else
        conn |> render(ApiWeb.ErrorView, "error.json", status: 403, error: "No user found")
      end
    else
      conn |> render(ApiWeb.ErrorView, "error.json", status: 404, error: "Route not found")
    end
  end

end
